require "test_helper"

describe User do

  describe "validations" do
    it "is valid with a name" do
      user = User.new(name: "Evelynna")
      result = user.valid?
      expect(result).must_equal true
    end

    it "is is invalid without a name" do
      user = User.new(name: "")
      result = user.valid?
      expect(result).must_equal false
    end

    it "should have a unique name" do
      user = User.new(name: "Nataliya")
      result = user.valid?
      expect(result).must_equal false
    end
  end

  
end
