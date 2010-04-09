class Spellchecker

  def initialize
    @word_counter = WordCounter.for_path(File.join(File.dirname(__FILE__),'corpus.txt'))
  end

  def correct(word)
    
  end

end
