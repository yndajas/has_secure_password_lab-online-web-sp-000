class UsersController < ApplicationController
    def new
        @user = User.new
    end

    def create
        user = User.new(user_params)
        if user.save
            session[:user_id] = user.id
            redirect_to welcome_path
        else
            redirect_to signup_path
        end
    end

    def welcome
        redirect_to login_path if !session.include? :user_id
        @user = User.find(session[:user_id])
    end
    
    private
    
    def user_params
        params.require(:user).permit(:name, :password, :password_confirmation)
    end
end