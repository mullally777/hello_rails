class UsersController < ApplicationController
  protect_from_forgery with: :null_session
  before_action :set_user, only: %i[ show edit update destroy ]

  # GET /users or /users.json
  def index
    if params[:id]
      users = User.find params[:id]
    else
      users = User.all
    end
    render json: users, status: 200
  end

  # GET /users/1 or /users/1.json
  def show
      user = User.find_by(id: params[:id])
      render json: user, status: 200
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users or /users.json
  def create
    if !auth? 
      render json: {error: "Unauthorized"}, status: 401
    else
      user = User.new(user_params)

      if user.save
        render json: user, status: 200
      else
        render json: {error: "Error creating user"}, status: 412
      end
    end
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to user_url(@user), notice: "User was successfully updated." }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url, notice: "User was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit([
        :name, 
        :email
        ])
    end

    def auth?
      return false unless request.headers["token"].present?
      return true if request.headers["token"] == "0ok9ij8uh"
    end
end
