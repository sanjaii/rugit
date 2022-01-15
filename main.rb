class Rgit
  GIT_DIR = '.rugit'
  def initialize(args)
    @args = args
    if args[0] == "init"
      init()
    end
  end
  def init
    if File.exists?(GIT_DIR)
      p "Already a rgit repository"
    else
      Dir.mkdir GIT_DIR
      p "Initialized a git repository"
    end
  end
end

if $0 == __FILE__
  Rgit.new(ARGV)
end
