# frozen_string_literal: true

require 'English'
require File.expand_path('lib/serialport/version', __dir__)

Gem::Specification.new do |s|
  s.name = 'serialport'
  s.license = 'GPL-2.0-only'
  s.version = SerialPort::VERSION
  s.authors = ['Guillaume Pierronnet', 'Alan Stern', 'Daniel E. Shipton', 'Tobin Richard', 'Hector Parra',
               'Ryan C. Payne', 'Roman Gaufman']
  s.summary = 'Library for using RS-232 serial ports.'
  s.description = 'Ruby/SerialPort is a Ruby library that provides a class for using RS-232 serial ports.'
  s.email = 'hector@hectorparra.com'
  s.homepage = 'http://github.com/hparra/ruby-serialport/'

  s.add_development_dependency 'bundler'
  s.add_development_dependency 'rake'
  s.add_development_dependency 'rake-compiler', '>= 0.4.1'
  s.add_development_dependency 'rubocop'

  s.require_paths     = ['lib']
  s.files             = `git ls-files`.split($OUTPUT_RECORD_SEPARATOR)
  s.extensions        = 'ext/native/extconf.rb'
  s.executables       = s.files.grep(%r{^bin/}).map { |f| File.basename(f) }
  s.extra_rdoc_files  = ['LICENSE', 'README.md']
  s.metadata['rubygems_mfa_required'] = 'true'
end
