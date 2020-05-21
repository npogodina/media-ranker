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

  describe "relations" do
    it "has a work" do
      vote = votes(:vote_1)
      expect(vote.work).must_equal works(:wheel_1)
    end

    it "has a user" do
      vote = votes(:vote_1)
      expect(vote.user).must_equal users(:nataliya)
    end

    it "can set the work" do
      vote = Vote.new(user: users(:nataliya))
      vote.work = works(:wheel_3)
      expect(vote.work_id).must_equal works(:wheel_3).id
    end

    it "can set the user" do
      vote = Vote.new(work: works(:wheel_3))
      vote.user = users(:cody)
      expect(vote.user_id).must_equal users(:cody).id
    end
  end

  describe "default order" do
    it "orders users by timestamp created by default - in ascending order" do
      votes = Vote.all

      i = 0
      while i < votes.length - 1
        expect(votes[i].created_at).must_be :<=, votes[i + 1].created_at
        i += 1
      end
    end
  end
end
