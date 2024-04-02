class UsersController < ApplicationController

   def new
      @user = User.new
   end

   def show
      if current_user
         @user = User.find(params[:id])
         cookies[:user_id]
      else
         flash[:error] = "Must be logged in or registered"
         redirect_to root_path
      end
   end

   def create
      user = User.new(user_params)
      if user.save
         session[:user_id] = user.id
         flash[:success] = 'Successfully Created New User'
         redirect_to user_path(user)
      else
         flash[:error] = "#{error_message(user.errors)}"
         redirect_to register_user_path
      end   
   end

   def login_form
      # cookies[:user_id]

   end

   def login_user
      if params[:email].present? && params[:password].present?
         user = User.find_by(email: params[:email])
         if user.authenticate(params[:password])
            session[:user_id] = user.id
            cookies[:user_id] = params[:location]
            flash[:success] = "Welcome, #{user.name}!"
            redirect_to user_path(user)
         else
            flash[:error] = "Sorry, your credentials are bad."
            redirect_to login_path
         end
      else
         flash[:error] = "Fill in the blanks."
         redirect_to login_path
      end


   end

   def logout
      # require "pry"; binding.pry
      session[:user_id] = nil
      redirect_to root_path
   end
private

  def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

end