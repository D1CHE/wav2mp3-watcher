class Scanner

  attr_accessor :path, :items

  def initialize(options={})
    self.path = options[:path]
    self.items = Array.new()
  end

  def scan
    self.items = Dir["#{path}/**/*.wav"]
  end

end