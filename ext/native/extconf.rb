require 'mkmf'

printf('checking for OS... ')
$stdout.flush
os = /-([a-z]+)/.match(RUBY_PLATFORM)[1]
puts(os)

$CFLAGS += " -DOS_#{os.upcase}"

exit(1) if !%w[mswin bccwin mingw].include?(os) && (!have_header('termios.h') || !have_header('unistd.h'))

create_makefile('serialport')
