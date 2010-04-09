require File.join(File.dirname(__FILE__), 'test_helper')

class EditGeneratorClass < Test::Unit::TestCase

  should "give word back if edit distance is zero" do
    counter = WordCounter.new(%w{something smoothing seething something soothing})
    generator = EditGenerator.new("something", counter)
    assert_equal ["something"], generator.edits(0)
  end
  
  should "give real words for edit distance 1" do
    counter = WordCounter.new(%w{something smoothing seething something soothing})
    generator = EditGenerator.new("something", counter)
    assert_equal ['something'], generator.edits(1)
  end

  should "give real words for edit distance 2" do
    counter = WordCounter.new(%w{something smoothing seething something soothing})
    generator = EditGenerator.new("something", counter)
    assert_equal %w{smoothing seething something soothing}.sort, generator.edits(2).sort
  end

end
