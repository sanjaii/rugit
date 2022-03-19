# frozen_string_literal: true

require 'digest/sha1'

# All the rugit functionalities implemented in this class.
class Rugit
  attr_reader :args

  GIT_DIR = '.rugit'

  def initialize(args)
    @args = args
  end

  def init
    if File.exist?(GIT_DIR)
      p 'Already a rgit repository'
    else
      Dir.mkdir GIT_DIR
      Dir.mkdir "#{GIT_DIR}/objects"
      p 'Initialized a git repository'
    end
  end

  def hash_object
    git_repository?
    return if args[1].nil?
    return  unless File.exist?(args[1])

    content = File.read(args[1])
    oid = Digest::SHA1.hexdigest args[1]
    File.open("#{GIT_DIR}/objects/#{oid}", 'wb') do |f|
      f.write content
    end
  end

  def cat_file
    git_repository?
    return if args[1].nil?
    return unless File.exist?("#{GIT_DIR}/objects/#{args[1]}")

    content = File.read("#{GIT_DIR}/objects/#{args[1]}")
    puts content
  end

  def git_repository?
    raise StandardError, 'This is not a git repository' unless initialized_repo?
  end

  def initialized_repo?
    File.exist?(GIT_DIR)
  end
end
