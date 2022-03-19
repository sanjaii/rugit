# frozen_string_literal: true

require_relative 'data'

if $PROGRAM_NAME == __FILE__ && !ARGV[0].nil?
  case ARGV[0]
  when 'init'
    Rugit.new(ARGV).init
  when 'hash-object'
    Rugit.new(ARGV).hash_object
  when 'cat-file'
    Rugit.new(ARGV).cat_file
  end
end
