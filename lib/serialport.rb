require 'serialport.bundle' if RUBY_PLATFORM.include?('darwin')
require 'serialport.so' unless RUBY_PLATFORM.include?('darwin')

require 'serialport/version'

# This class is used for communication over a serial port.
# In addition to the methods here, you can use Ruby IO methods, e.g. read, write, getc, readlines, etc.
#
# @see http://rubydoc.info/stdlib/core/IO Ruby IO class
# @see http://www.cmrr.umn.edu/~strupp/serial.html "Serial Programming Guide for POSIX Operating Systems"
class SerialPort
  private_class_method(:create)

  # Creates a serial port object.
  # Accepts the port identifier and a variable list for configuration as paramaters or hash.
  # Please see SerialPort#set_modem_params
  #
  # @overload new(port, *params)
  #  @param port [Integer] the serial port number,
  #    where 0 is mapped to "COM1" on Windows, "/dev/ttyS0" on Linux, "/dev/cuaa0" on Mac OS X, etc.
  # @overload new(port, *params)
  #  @param port [String] the serial port file e.g. "/dev/ttyS0"
  # @return [SerialPort]
  # @see SerialPort#set_modem_params
  def self.new(port, *params)
    sp = create(port)
    begin
      sp.set_modem_params(*params)
    rescue StandardError
      sp.close
      raise
    end
    sp
  end

  # This behaves like SerialPort#new, except that you can pass a block
  # to which the new serial port object will be passed. In this case
  # the connection is automaticaly closed when the block has finished.
  #
  # @yield [serial_port] the serial port number or filename
  # @see SerialPort#new
  # @see SerialPort#set_modem_params
  def self.open(port, *params)
    sp = create(port)
    begin
      sp.set_modem_params(*params)
    rescue StandardError
      sp.close
      raise
    end
    if block_given?
      begin
        yield sp
      ensure
        sp.close
      end
      return nil
    end
    sp
  end
end
