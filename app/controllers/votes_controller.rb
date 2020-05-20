class VotesController < ApplicationController
  def create
    user = User.find_by(id: session[:user_id])
    if user.nil?
      flash[:error] = "A problem occured. You must log in to do that." 
      redirect_back(fallback_location: root_path)
      return
    end
    # if voted already? (has many-through relationship)

    work = Work.find_by(id: params[:id])
    
    if work.nil?
      flash[:error] = "A problem occured. We couldn't find this work."
      redirect_back(fallback_location: root_path)
      return
    end

    # if user.works.include? work
    #   flash[:error] = "A problem occured. Could not upvote."
    #   redirect_back(fallback_location: root_path)
    #   return
    # end

    @vote = Vote.new(
      user_id: user.id,
      work_id: work.id
    )

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
end
