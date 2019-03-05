class SessionsController < ApplicationController
    def new
        render :new
    end

    def create
        user = User.find_by_credentials(session_params[:username], session_params[:password])
        if user
            login(user)
            redirect_to subs_url
        else
            flash.now[:errors] = ["Wrong user/password"]
            render :new
        end
    end

    def destroy
        logout
        redirect_to new_sessions_url
    end

    def session_params
        params.require(:user).permit(:username, :password)
    end
end
