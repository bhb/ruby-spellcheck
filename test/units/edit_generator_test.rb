require File.join(File.dirname(__FILE__), '..', 'test_helper')

class EditGeneratorTest < Test::Unit::TestCase

  should "give word back if edit distance is zero (and word is known)" do
    counter = WordCounter.new(%w{something smoothing seething something soothing})
    generator = EditGenerator.new("something", counter)
    assert_equal ["something"], generator.edits(0)
  end

  should "give back empty set if word is unknown" do
    counter = WordCounter.new(%w{something smoothing seething something soothing})
    generator = EditGenerator.new("somethin", counter)
    assert_equal [], generator.edits(0)  
  end
  
  should "give real words for edit distance 1" do
    counter = WordCounter.new(%w{something smoothing seething something soothing})
    generator = EditGenerator.new("somethin", counter)
    assert_equal ['something'], generator.edits(1)
  end

  should "give real words for edit distance 2" do
    counter = WordCounter.new(%w{something smoothing seething something soothing})
    generator = EditGenerator.new("something", counter)
    assert_equal %w{smoothing seething something soothing}.sort, generator.edits(2).sort
  end

  should "have 114,324 distance-2 edits for 'something' if none are pruned" do
    generator = EditGenerator.new("something", nil)
    assert_equal 114_324, generator.edits(2,false).length
  end

  should "give all deletes" do
    generator = EditGenerator.new("abc", nil)
    edits = generator.edits(1,false)
    assert edits.include?("ab")
    assert edits.include?("bc")
    assert edits.include?("ac")
  end

  should "give all transposes" do
    generator = EditGenerator.new("abc", nil)
    edits = generator.edits(1,false)
    assert edits.include?("bac")
    assert edits.include?("acb")
    assert edits.include?("abc")
  end

  should "give all replaces" do
    generator = EditGenerator.new("ab", nil)
    edits = generator.edits(1,false)
    # test only a subset
    assert edits.include?("zb")
    assert edits.include?("az")
  end

  should "give all inserts" do
    generator = EditGenerator.new("ab", nil)
    edits = generator.edits(1,false)
    # test only a subset
    assert edits.include?("zab")
    assert edits.include?("azb")
    assert edits.include?("abz")
  end


end
