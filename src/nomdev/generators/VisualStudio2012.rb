#!/usr/bin/env ruby

=begin

  nomlib - C++11 cross-platform game engine

Copyright (c) 2013, 2014 Jeffrey Carpenter <i8degrees@gmail.com>
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:

1. Redistributions of source code must retain the above copyright notice, this
   list of conditions and the following disclaimer.
2. Redistributions in binary form must reproduce the above copyright notice,
   this list of conditions and the following disclaimer in the documentation
   and/or other materials provided with the distribution.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR
ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

=end

=begin

# TODO #

- [ ] Stub

# References #

* Stub

=end

require 'fileutils'

require "#{NOMDEV_SRC_DIR}/config.rb"

module Generator

  class VisualStudio2012

    def initialize( options )
      @options = options
    end # initialize

    def generate
      args = Array.new

      if @options.arch == :x64
        args << "-GVisual Studio 12 Win64"
        args << "-DARCH_64=on"
      elsif @options.arch == :x86
        args << "-GVisual Studio 12"
        args << "-DARCH_32=on"
      end

      if @options.build_debug || @options.developer
        args << "-DDEBUG=on"
        args << "-DDEBUG_ASSERT=on"
      end

      args << "-DEXAMPLES=on" if @options.build_examples || @options.developer

      if @options.build_docs #|| @options.developer
        puts "Error: '--docs' not implemented."
        quit
      end

      args << "-DNOM_BUILD_TESTS=on" if @options.build_tests || @options.developer
      args << "-DCMAKE_INSTALL_PREFIX=#{@options.install_prefix}" if @options.install_prefix

      run( "cmake", *args, "..", @options )
    end # generate

  end # VisualStudio2012

end # namespace CMakeGenerator
