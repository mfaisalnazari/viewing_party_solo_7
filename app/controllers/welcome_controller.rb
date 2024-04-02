class WelcomeController < ApplicationController
  def index
    if current_user
      @users = User.all
    end
    # binding.pry
  end
end
