require 'rubygems'
require 'ffi'
require File.join(File.dirname(__FILE__), 'run_midi')

class LiveMIDI
  include RunMidi

  ON = 0x90
  OFF = 0x80
  PC = 0xC0

  def initialize
    open
  end

  def note_on(channel, note, velocity=64)
    message(ON | channel, note, velocity)
  end

  def note_off(channel, note, velocity=64)
    message(OFF | channel, note, velocity)
  end

  def program_change(channel, preset)
    message(PC | channel, preset)
  end
end


if RUBY_PLATFORM.include?('darwin')
  class LiveMIDI
    module C
      extend FFI::Library
      ffi_lib '/System/Library/Frameworks/CoreMIDI.framework/Versions/Current/CoreMIDI'
      attach_function :MIDIClientCreate, [:pointer, :pointer, :pointer, :pointer], :int
      attach_function :MIDIClientDispose, [:pointer], :int
      attach_function :MIDIGetNumberOfDestinations, [], :int
      attach_function :MIDIGetDestination, [:int], :pointer
      attach_function :MIDIOutputPortCreate, [:pointer, :pointer, :pointer], :int
      attach_function :MIDIPacketListInit, [:pointer], :pointer
      attach_function :MIDISend, [:pointer, :pointer, :pointer], :int
      attach_function :MIDIPacketListAdd, [:pointer, :int, :pointer, :int, :int, :pointer], :pointer
    end

    module CF
      extend FFI::Library
      ffi_lib '/System/Library/Frameworks/CoreFoundation.framework/Versions/Current/CoreFoundation'
      attach_function :CFStringCreateWithCString, [:pointer, :string, :int], :pointer
    end

    def open
      client_name = CF.CFStringCreateWithCString nil, 'Ruby', 0

      client_ptr = FFI::MemoryPointer.new :pointer
      C.MIDIClientCreate client_name, nil, nil, client_ptr
      @client = client_ptr.read_pointer

      port_name = CF.CFStringCreateWithCString nil, 'Output', 0
      outport_ptr = FFI::MemoryPointer.new :pointer
      C.MIDIOutputPortCreate @client, port_name, outport_ptr
      @outport = outport_ptr.read_pointer

      destinations = C.MIDIGetNumberOfDestinations
      raise 'No MIDI destinations' if destinations < 1
      @destination = C.MIDIGetDestination 0
    end

    def close
      C.MIDIClientDispose @client
    end

    def message(*args)
      format = 'C' * args.size
      bytes = FFI::MemoryPointer.new FFI.type_size(:char) * args.size
      bytes.write_string args.pack(format)
      packet_list = FFI::MemoryPointer.new 256
      packet_ptr = C.MIDIPacketListInit packet_list
      packet_ptr = C.MIDIPacketListAdd packet_list, 256, packet_ptr, 0, args.size, bytes
      C.MIDISend @outport, @destination, packet_list
    end
  end
end
