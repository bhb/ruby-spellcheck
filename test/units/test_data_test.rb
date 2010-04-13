require File.join(File.dirname(__FILE__), '..', 'test_helper')

class TestDataTest < Test::Unit::TestCase

  context "with test data" do
    include Construct::Helpers

    should "should map word to single misspelling" do
      within_construct do |c|
        c.file "test.643","family 1 familly"
        assert_equal ["familly"], TestData.new("test.643")[:family]
      end
    end

    should "should map word to multiple misspellings" do
      within_construct do |c|
        c.file "test.643","favourite 4 favrit favorite fairit [* sport]"
        assert_equal ["favrit", "favorite", "fairit"], TestData.new("test.643")[:favourite]
      end
    end

  end

end
