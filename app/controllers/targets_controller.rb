class TargetsController < ApplicationController
  before_action :signed_in_user, only: [:index, :show]
  before_action :admin_user, only: [:edit, :new, :destroy]

  # GET /targets
  # GET /targets.json
  def index
    @targets = Target.all
  end

  # GET /targets/1
  # GET /targets/1.json
  def show
    @target = Target.find(params[:id])
  end

  # GET /targets/new
  def new
    @target = Target.new
  end

  # GET /targets/1/edit
  def edit
  end

  # POST /targets
  # POST /targets.json
  def create
    @target = Target.new(target_params)

    respond_to do |format|
      if @target.save
        format.html { redirect_to @target, notice: 'Target was successfully created.' }
        format.json { render :show, status: :created, location: @target }
      else
        format.html { render :new }
        format.json { render json: @target.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /targets/1
  # PATCH/PUT /targets/1.json
  def update
    respond_to do |format|
      if @target.update(target_params)
        format.html { redirect_to @target, notice: 'Target was successfully updated.' }
        format.json { render :show, status: :ok, location: @target }
      else
        format.html { render :edit }
        format.json { render json: @target.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /targets/1
  # DELETE /targets/1.json
  def destroy
    @target.destroy
    respond_to do |format|
      format.html { redirect_to targets_url, notice: 'Target was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def target_params
      params.require(:target).permit(:email, :name, :role)
    end

    def admin_user
      redirect_to root_url unless current_user.admin?
    end

    def signed_in_user
      store_location
      redirect_to "/auth/facebook" unless signed_in?
    end
end
