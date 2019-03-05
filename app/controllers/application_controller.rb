class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception
    

    helper_method :current_user, :logged_in?, :all_subs
    def current_user
        @current_user ||= User.find_by(session_token: session[:session_token])
    end
    

    def all_subs 
        @subs = Sub.all
    end

    def login(user)
        session[:session_token] = user.reset_session_token!
        current_user
    end

    def logout
        current_user.reset_session_token!
        session[:session_token] = nil
    end

    def logged_in?
        !!current_user
    end

    def is_mod? 
        # params availability?
        debugger
        @sub = Sub.find_by(id: params[:id])  # params = {id: 3, post: {title: 'hello'}}
        redirect_to sub_url(@sub) unless @sub.moderator == current_user
    end

    def is_post_author? 
        @post = Post.find_by(id: params[:id])
        redirect_to post_url(@post) unless @post.user == current_user
    end

    def ensure_logged_in
        redirect_to new_sessions_url unless logged_in?
    end
end
