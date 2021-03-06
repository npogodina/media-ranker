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

  describe "relations" do
    it "has many votes" do
      nataliya = users(:nataliya)
      expect(nataliya.votes).must_be_kind_of Enumerable

      nataliya.votes.each do |vote|
        expect(vote).must_be_instance_of Vote
      end
    end

    it "has many works through votes" do
      nataliya = users(:nataliya)
      expect(nataliya.works).must_be_kind_of Enumerable

      nataliya.works.each do |work|
        expect(work).must_be_instance_of Work
      end
    end
  end

  describe "default order" do
    it "orders users by timestamp created by default - in ascending order" do
      users = User.all

      i = 0
      while i < users.length - 1
        expect(users[i].created_at).must_be :<=, users[i + 1].created_at
        i += 1
      end
    end
  end
end
