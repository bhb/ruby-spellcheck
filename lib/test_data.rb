class TestData

  def initialize(path)
    @hash = {}
    lines = File.readlines(path)
    lines.each do |line|
      information, comments = line.split("[")
      word, _, *misspellings = information.split(" ")
      @hash[word.to_sym] = misspellings
    end
  end

  def [](key)
    @hash[key]
  end

end
