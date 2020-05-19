class UsersController < ApplicationController
  def index
    @users = User.all.order(:id)
  end

  def show
    @user = User.find_by(id: params[:id])
    if @user.nil?
      head :not_found
      return
    end

    # @trips = @user.trips
  end

  def login_form
    @user = User.new
  end

  def login
    name = params[:user][:name]
    @user = User.find_by(name: name)
    if @user
      session[:user_id] = @user.id
      flash[:success] = "Successfully logged in as existing user #{name}"
    else
      @user = User.new(name: name)
      
      unless @user.save
        error_messages = @user.errors.full_messages.map { |message| "<li>#{message}</li>" }.join
        flash.now[:error] = "A problem occurred: could not log in. <ul>#{error_messages}</ul>".html_safe
        render :login_form
        return
      end

      @user.save
      session[:user_id] = @user.id
      flash[:success] = "Successfully created new user #{name} with ID #{user.id}"
    end
  
    redirect_to root_path
  end

  def logout
    session[:user_id] = nil
    flash[:success] = "Successfully logged out"
    redirect_to root_path
  end
end
