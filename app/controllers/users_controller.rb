class UsersController < ApplicationController
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
        flash.now[:error] = "A problem occurred: could not log in"
        render :login_form
        return
      end

      @user.save
      session[:user_id] = @user.id
      flash[:success] = "Successfully created new user #{name} with ID #{user.id}"
    end
  
    redirect_to welcome_path
    return
  end

  def logout
    session[:user_id] = nil
    flash[:success] = "Successfully logged out"
    redirect_to welcome_path
    return
  end
end
