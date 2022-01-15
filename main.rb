# frozen_string_literal: true

require 'digest/sha1'

# All the rugit functionalities Implemented in this class
class Rugit
  GIT_DIR = '.rugit'

  def initialize(args)
    @args = args
    init if args[0] == 'init'
    hash_object if args[0] == 'hash-object'
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
    return if @args[1].nil?

    oid = Digest::SHA1.hexdigest @args[1]
    File.open("#{GIT_DIR}/objects/#{oid}", 'wb')
  end
end

Rugit.new(ARGV) if $PROGRAM_NAME == __FILE__
