# frozen_string_literal: true

require 'optparse'
require_relative 'data'

def git_repository?
  initialized_repo?
end

def initialized_repo?
  File.exist?(GIT_DIR)
end

def log(end_notes)
  p end_notes
  exit
end

GIT_DIR = '.rugit'

subcommands = { 'init' => 'init', 'hash-object' => 'hash_object', 'cat-file' => 'read_object' }

if $PROGRAM_NAME == __FILE__ && !ARGV[0].nil?
  args = ARGV
  case args[0]
  when 'init'
    log('Already a rugit repository') if git_repository?

    Rugit.new.send(subcommands[args[0]])
  when 'hash-object'
    log('This is not a rugit repository') unless git_repository?
    log('Insufficient arguments') if args[1].nil?

    Rugit.new.send(subcommands[args[0]], args[1..args.length])
  when 'cat-file'
    log('This is not a git_repository') unless git_repository?
    log('Insufficient arguments') if args[1].nil?

    Rugit.new.send(subcommands[args[0]], args[1..args.length], nil)
  end
end
