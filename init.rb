#!/usr/bin/env ruby

# wav2mp3-watcher is a program that watches a folder for wav files and converts them to mp3 files.
# Copyright (C) 2018  Willem Deen

# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <https://www.gnu.org/licenses/>.

require 'logger'
require 'shellwords'
require_relative('lib/scanner')

log_path = ARGV[1]
folder_path = ARGV[0]

File.open(log_path, 'w') {}
logger = Logger.new(log_path)
logger.level = Logger::INFO

s = Scanner.new(path: folder_path)

logger.info("###########################################################")
logger.info("wav2mp3-watcher Started!".center(60))
logger.info("###########################################################")

command = "/usr/local/bin/ffmpeg"
input_option = " -i "
format_option = " -f mp3 "

while true do
  s.items.each do |i|
    file_no_ext = Shellwords.shellescape i[0..-5]
    if system( "#{command}#{input_option}#{file_no_ext}.wav#{format_option}#{file_no_ext}.mp3" )
      logger.info("Converted file: #{i} to mp3.")
      File.delete(i) if File.exist?(i)
    end
  end
  
  s.scan

  sleep 5

end