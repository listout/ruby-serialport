require 'serialport.bundle' if RUBY_PLATFORM.include?('darwin')
require 'serialport.so' unless RUBY_PLATFORM.include?('darwin')

if ARGV.size < 4
  $stderr.print <<EOF
  Usage: ruby #{$PROGRAM_NAME} num_port bps nbits stopb
EOF
  exit(1)
end

sp = SerialPort.new(ARGV[0].to_i, ARGV[1].to_i, ARGV[2].to_i, ARGV[3].to_i, SerialPort::NONE)

open('/dev/tty', 'r+') do |tty|
  tty.sync = true
  Thread.new do
    loop { tty.printf('%c', sp.getc) }
  end
  while (l = tty.gets)
    sp.write(l.sub("\n", "\r"))
  end
end

sp.close
