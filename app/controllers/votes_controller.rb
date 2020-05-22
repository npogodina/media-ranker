class VotesController < ApplicationController
  before_action :require_user
  before_action :require_work

  def create
    @vote = Vote.new(user: @user, work: @work)

    if @vote.save
      flash[:success] = "Successfully upvoted!" 
    else
      error_messages = @vote.errors.full_messages.map { |message| 
        if message == "Work has already been taken"
          "<li>user: has already voted for this work</li>" 
        else
          "<li>#{message}</li>" 
        end
      }.join
      flash[:error] = "A problem occured. Could not upvote. <ul>#{error_messages}</ul>"
    end

    redirect_back(fallback_location: root_path)
  end

  private

  def require_user
    @user = User.find_by(id: session[:user_id])
    if @user.nil?
      flash[:error] = "A problem occured. You must log in to do that." 
      redirect_back(fallback_location: root_path)
    end
  end

  def require_work
    @work = Work.find_by(id: params[:id])  
    if @work.nil?
      flash[:error] = "A problem occured. We couldn't find this work."
      redirect_back(fallback_location: root_path)
    end
  end
end
