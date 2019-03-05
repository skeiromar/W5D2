class SubsController < ApplicationController
  before_action :ensure_logged_in
  
  before_action :is_mod?, only: [:edit, :update]

  # GET /subs
  # GET /subs.json
  def index
    @subs = Sub.all
  end

  # GET /subs/1
  # GET /subs/1.json
  def show
    @sub = Sub.find_by(id: params[:id])

  end

  # GET /subs/new
  def new
    @sub = Sub.new
  end

  # GET /subs/1/edit
  def edit
    @sub = Sub.find_by(id: params[:id])
    render :edit
  end

  # POST /subs
  # POST /subs.json
  def create
    @sub = Sub.new(sub_params)
    @sub.moderator = current_user

      if @sub.save
        redirect_to sub_url(@sub)
      else
        flash.now[:errors] = @sub.errors.full_messages
        render :new 
      end

  end

  # PATCH/PUT /subs/1
  # PATCH/PUT /subs/1.json
  def update
    @sub = Sub.find_by(id: params[:id])
    if @sub.update_attributes(sub_params)
      redirect_to sub_url(@sub)
    else
      flash.now[:errors] = @sub.errors.full_messages
      render :edit
    end
  end

  # DELETE /subs/1
  # DELETE /subs/1.json
  def destroy
    @sub.destroy
    respond_to do |format|
      format.html { redirect_to subs_url, notice: 'Sub was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sub
      @sub = Sub.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def sub_params
      params.require(:sub).permit(:title, :description) # {title: 'dsadsa', description: 'dsadsa'} params[:sub][:title]
    end
end
