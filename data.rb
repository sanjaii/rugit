# frozen_string_literal: true

require 'digest/sha1'
# All the rugit functionalities implemented in this class.
class Rugit
  attr_reader :args

  GIT_DIR = '.rugit'

  def init
    Dir.mkdir GIT_DIR
    Dir.mkdir "#{GIT_DIR}/objects"
    p 'Initialized a git repository'
  end

  def hash_object(args, type = 'blob')
    obj = (type.encode << 0) + File.read(args[0])
    oid = Digest::SHA1.hexdigest args[0]
    p "Hashing the content of the file #{args[0]} using SHA-1"
    File.open("#{GIT_DIR}/objects/#{oid}", 'wb') do |f|
      f.write obj
    end
  end

  def read_object(args, expected = 'blob')
    type, content = File.read("#{GIT_DIR}/objects/#{args[0]}").split("\u0000")
    puts content

    "Expected #{expected}, got #{type}" if !expected.nil? && (type == expected)
  end
end
