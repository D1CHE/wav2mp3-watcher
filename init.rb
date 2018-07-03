#!/usr/bin/env ruby

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
logger.info("wav2mp3_watcher Started!".center(60))
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