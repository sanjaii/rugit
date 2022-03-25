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

  def hash_object(file, type = 'blob')
    obj = (type.encode << 0) + File.read(file)
    oid = Digest::SHA1.hexdigest file
    File.open("#{GIT_DIR}/objects/#{oid}", 'wb') do |f|
      f.write obj
    end
  end

  def read_object(obj)
    content = File.read("#{GIT_DIR}/objects/#{obj}").split("\u0000")
    puts content[1]
  end
end
