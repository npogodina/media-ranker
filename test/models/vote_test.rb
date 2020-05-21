require "test_helper"

describe Vote do
  describe "validations" do
    it "is valid with work and user" do
      vote = Vote.new(work: works(:wheel_1), user: users(:yulia))
      result = vote.valid?
      expect(result).must_equal true
    end

    it "is invalid without work" do
      vote = Vote.new(user: users(:yulia))
      result = vote.valid?
      expect(result).must_equal false
    end

    it "is invalid without user" do
      vote = Vote.new(work: works(:wheel_1))
      result = vote.valid?
      expect(result).must_equal false
    end

    it "is okay for the same user to upvote multiple works" do
      nataliyas_votes = Vote.where(user: users(:nataliya))
      expect(nataliyas_votes.length).must_be :>, 1
    end

    it "but only once/work: it is invalid if there's already vote with the same user and work" do
      vote = Vote.where(user: users(:nataliya), work: works(:wheel_1))
      expect(vote.nil?).must_equal false

      dupe = Vote.new(work: works(:wheel_1), user: users(:nataliya))
      expect(dupe.valid?).must_equal false
    end
  end

end
