# frozen_string_literal: true

require 'digest/sha1'

# All the rugit functionalities implemented in this class.
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
    return  unless File.exist?(@args[1])

    content = File.read(@args[1])
    oid = Digest::SHA1.hexdigest @args[1]
    File.open("#{GIT_DIR}/objects/#{oid}", 'wb') do |f|
      f.write content
    end
  end
end

Rugit.new(ARGV) if $PROGRAM_NAME == __FILE__
