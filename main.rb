# frozen_string_literal: true

require_relative 'data'

def git_repository?
  raise StandardError, 'This is not a git repository' unless initialized_repo?
end

def initialized_repo?
  File.exist?(GIT_DIR)
end

if $PROGRAM_NAME == __FILE__ && !ARGV[0].nil?
  args = ARGV
  GIT_DIR = '.rugit'

  case args[0]
  when 'init'
    if File.exist?(GIT_DIR)
      p 'Already a rgit repository'
      return
    end
    Rugit.new.init

  when 'hash-object'
    git_repository?
    return if args[1].nil?
    return unless File.exist?(args[1])

    Rugit.new.hash_object(args[1])
  when 'cat-file'
    git_repository?
    return if args[1].nil?
    return unless File.exist?("#{GIT_DIR}/objects/#{args[1]}")

    Rugit.new.read_object(args[1])
  end
end
