require File.join(File.dirname(__FILE__), 'test_helper')

class EditGeneratingStringTest < Test::Unit::TestCase

  should "give all deletes" do
    edits = EditGeneratingString.new("abc").edits
    assert edits.include?("ab")
    assert edits.include?("bc")
    assert edits.include?("ac")
  end

end
