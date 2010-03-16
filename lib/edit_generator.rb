class EditGenerator

  def initialize(word, word_counter)
    @word = word
    @word_counter = word_counter
  end

  def candidates
    
  end
  
  def edits(distance)
    
  end

end

class CuttableString

  def initialize(string)
    @string = string
  end

  def cut(index)
    [CuttableString.new(@string[0,index]), CuttableString.new(@string[index..-1])]
  end

  def first
    CuttableString.new(@string[0,1] || "")
  end

  def rest
    CuttableString.new(@string[1..-1] || "")
  end

  def to_s
    @string
  end

  def +(other)
    CuttableString.new(@string+other.to_s)
  end

end


class EditGeneratingString

  def initialize(string)
    @string = string
    @alphabet = ('a'..'z')
  end

  def edits
    splits = []
    cstring = CuttableString.new(@string)
    @string.length.times do |i|
      splits << cstring.cut(i)
    end
    deletes = splits.map { |left, right| left + right.rest }
    transposes = []
    replaces = []
    inserts = []
    (deletes + transposes + replaces + inserts).map{ |x| x.to_s}
  end

end
