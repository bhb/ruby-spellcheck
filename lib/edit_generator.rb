require 'delegate'

class EditGenerator

  ALPHABET = ('a'..'z').to_a

  def initialize(word, word_counter)
    @word = word
    @word_counter = word_counter
    @edits = []
    @edits[0] = [@word]
  end

  def candidates(word)
    (0..2).each do |distance|
      words = edits(distance)
      return words unless words.empty?
    end
    []
  end

  def edits(distance, select_real_words=true)
    distance.times do |count|
      if @edits[count+1]==nil
        @edits[count+1] = @edits[count].map{|word| edits_for_word(word)}.flatten.uniq
      end
    end
    if select_real_words
      select_real_words(@edits[distance])
    else
      @edits[distance]
    end
  end

  private

  def select_real_words(words)
    words.select do |word|
      @word_counter.present?(word)
    end
  end

  def edits_for_word(word)
    # yes, this could be broken into multiple methods, but perf improvement of inlining is significant
    splits = []

    word.length.times do |index|
      splits << [word[0,index], word[index,word.length-index]]
    end

    edits = []
    splits.each do |left,right|
      right_rest = right[1,right.length-1] || ""
      right_first = right[0,1] || ""
      right_second = right[1,1] || ""
      right_rest_2 = right[2,right.length-2] || ""
      
      # compute delete
      edits << "#{left}#{right_rest}"

      # compute transpose
      edits << "#{left}#{right_second}#{right_first}#{right_rest_2}"

      ALPHABET.each do |letter|
        
        # compute replaces
        edits << "#{left}#{letter}#{right_rest}"
        
        # compute inserts
        edits << "#{left}#{letter}#{right}"
      end
    end
    
    # add on additional inserts (for the split of [word, ''])
    left, right = word, ""
    ALPHABET.each do |letter|
      edits << "#{left}#{letter}#{right}"
    end

    edits.uniq!
    edits
  end

end
