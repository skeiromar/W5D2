class PostsController < ApplicationController
  before_action :is_post_author? , only: [:edit, :update]
  before_action :ensure_logged_in
  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.all
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @post = Post.find_by(id: params[:id])
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
    @post = Post.find_by(id: params[:id])
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    
    if @post.save 
      redirect_to post_url(@post)
    else 
      flash.now[:errors] = @post.errors.full_messages
      render :new 
    end
    
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    @post = Post.find_by(id: params[:id])
    # , :sub_id, :user_id
    
    # check if you can pass data through views to controller via params
    # @post.sub_id = params[:sub_id]
    @post.user = current_user


    if @post.update_attributes(post_params)
      redirect_to post_url(@post)
    else  
      flash.now[:errors] = @post.errors.full_messages
      render :edit
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    #     t.string "title"
    # t.string "url"
    # t.string "content"
    # t.integer "sub_id"
    # t.integer "user_id"
    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:title, :url, :content)
    end
end
