class UserDetailsController < ApplicationController
  before_action :set_user_detail, only: %i[ show edit update destroy ]

  # GET /user_details or /user_details.json
  def index
    @user_details = UserDetail.all
  end

  # GET /user_details/1 or /user_details/1.json
  def show
  end

  # GET /user_details/new
  def new
    @user_detail = UserDetail.new
  end

  # GET /user_details/1/edit
  def edit
  end

  # POST /user_details or /user_details.json
  def create
    @user_detail = UserDetail.new(user_detail_params)

    respond_to do |format|
      if @user_detail.save
        format.html { redirect_to @user_detail, notice: "User detail was successfully created." }
        format.json { render :show, status: :created, location: @user_detail }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user_detail.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /user_details/1 or /user_details/1.json
  def update
    respond_to do |format|
      if @user_detail.update(user_detail_params)
        format.html { redirect_to @user_detail, notice: "User detail was successfully updated." }
        format.json { render :show, status: :ok, location: @user_detail }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user_detail.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /user_details/1 or /user_details/1.json
  def destroy
    @user_detail.destroy
    respond_to do |format|
      format.html { redirect_to user_details_url, notice: "User detail was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_detail
      @user_detail = UserDetail.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_detail_params
      params.require(:user_detail).permit(:user_id, :age)
    end
end
