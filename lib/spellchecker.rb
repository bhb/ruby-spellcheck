class Spellchecker

  def initialize
    @word_counter = WordCounter.for_path(File.join(File.dirname(__FILE__),'corpus.txt'))
  end

  def correct(word)
    generator = EditGenerator.new(word, @word_counter)
    candidates = generator.candidates(word)
    candidates.max {|candidate| @word_counter.count(candidate)}
  end

end
