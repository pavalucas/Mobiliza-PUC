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
    @goal = @mobilization.goal
  end

  # GET /mobilizations/new
  def new
    @mobilization = Mobilization.new
  end

  # GET /mobilizations/1/edit
  def edit
    @mobilization = Mobilization.find(params[:id])
  end

  # POST /mobilizations
  # POST /mobilizations.json
  def create
    if current_user.email.to_s == ''
      redirect_to edit_user_path(current_user)
    else
      @mobilization = current_user.mobilizations.build(mobilization_params)

      if @mobilization.save
        pressureAllTargetsFrom @mobilization
        flash[:success] = "Moblização criada!"
        current_user.vote_for @mobilization
        redirect_to @mobilization
      else
        format.html { render :new }
        format.json { render json: @mobilization.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /mobilizations/1
  # PATCH/PUT /mobilizations/1.json
  def update
    @mobilization = Mobilization.find(params[:id])
    
    if @mobilization.update_attributes(mobilization_params)
      flash[:success] = "Mobilização Atualizada"
      redirect_to @mobilization
    else
      render 'edit'
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

  def pressureAllTargetsFrom(mobilization)
    @mobilization = mobilization
    @mobilization.targets.each do |target|      
      UserMailer.pressure_mail(@mobilization, target).deliver_now
    end
  end

  def press
    if current_user.email.to_s == ''
      redirect_to edit_user_path(current_user)
    else
      @mobilization = Mobilization.find(params[:id])
      if !(current_user.voted_on? @mobilization) then
        current_user.vote_for @mobilization
      end

      mob_pressures = @mobilization.votes_for
      if (mob_pressures <= 50) and (mob_pressures%10 == 0) then
        pressureAllTargetsFrom @mobilization
      end

      redirect_to @mobilization
    end
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
      params.require(:mobilization).permit(:title, :category, :description, :mail_content, :target_ids, :goal => [])
    end

    def signed_in_user
      store_location
      redirect_to "/auth/facebook" unless signed_in?
    end
end
