require '../serialport.so'

if ARGV.size < 4
  STDERR.print <<EOF
  Usage: ruby #{$0} num_port bps nbits stopb
EOF
  exit(1)
end

sp = SerialPort.new(ARGV[0].to_i, ARGV[1].to_i, ARGV[2].to_i, ARGV[3].to_i, SerialPort::NONE)

open('/dev/tty', 'r+') do |tty|
  tty.sync = true
  Thread.new do
    tty.printf('%c', sp.getc) while true
  end
  while (l = tty.gets)
    sp.write(l.sub("\n", "\r"))
  end
end

sp.close
