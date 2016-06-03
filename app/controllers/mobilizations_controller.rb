class MobilizationsController < ApplicationController
  before_action :signed_in_user, only: [:new, :create, :show]

  
  # GET /mobilizations
  # GET /mobilizations.json
  def index
    @mobilizations = Mobilization.all
  end

  # GET /mobilizations/1
  # GET /mobilizations/1.json
  def show
    @mobilization = Mobilization.find(params[:id])
  end

  # GET /mobilizations/new
  def new
    @mobilization = Mobilization.new
  end

  # GET /mobilizations/1/edit
  def edit
  end

  # POST /mobilizations
  # POST /mobilizations.json
  def create
    @mobilization = current_user.mobilizations.build(mobilization_params)

    if @mobilization.save
      UserMailer.mobCreation_mail(@mobilization).deliver_now
      flash[:success] = "Moblização criada!"
      current_user.vote_for @mobilization
      redirect_to @mobilization
    else
      format.html { render :new }
      format.json { render json: @mobilization.errors, status: :unprocessable_entity }
    end
  end

  # PATCH/PUT /mobilizations/1
  # PATCH/PUT /mobilizations/1.json
  def update
    respond_to do |format|
      if @mobilization.update(mobilization_params)
        format.html { redirect_to @mobilization, notice: 'Mobilization was successfully updated.' }
        format.json { render :show, status: :ok, location: @mobilization }
      else
        format.html { render :edit }
        format.json { render json: @mobilization.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /mobilizations/1
  # DELETE /mobilizations/1.json
  def destroy
    @mobilization.destroy
    respond_to do |format|
      format.html { redirect_to mobilizations_url, notice: 'Mobilization was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def press
    @mobilization = Mobilization.find(params[:id])
    if !(current_user.voted_on? @mobilization) then
      current_user.vote_for @mobilization
    end
    redirect_to @mobilization
  end

  def showByCategory
    id = Integer(params[:id])
    if id>=0 and id <4
      @mobilizations = Mobilization.where(:category => id)
    else
      redirect_to "/"
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_mobilization
      @mobilization = Mobilization.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def mobilization_params
      params.require(:mobilization).permit(:title, :category, :description, :mail_content, :target_ids => [])
    end

    def signed_in_user
      store_location
      redirect_to "/auth/facebook" unless signed_in?
    end
end
