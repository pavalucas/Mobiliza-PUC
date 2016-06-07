class MobilizationsController < ApplicationController
  before_action :signed_in_user, only: [:new, :create, :show]
  $categories = ["Petição", "Reclamação", "Sugestão", "Outros"]
  $statuses = ["Em progresso", "Em pausa", "Terminada", "Inativa"]

  # GET /mobilizations
  # GET /mobilizations.json
  def index
    @mobilizations = Mobilization.all
  end

  # GET /mobilizations/1
  # GET /mobilizations/1.json
  def show
    @user = current_user
    @mobilization = Mobilization.find(params[:id])
  end

  # GET /mobilizations/new
  def new
    if current_user.email.to_s == ''
       redirect_to edit_user_path(current_user)
    else
      @mobilization = Mobilization.new
    end
  end

  # GET /mobilizations/1/edit
  def edit
    @mobilization = Mobilization.find(params[:id])
    if @mobilization.user_id != current_user.id
      redirect_to @mobilization
    end
  end

  # POST /mobilizations
  # POST /mobilizations.json
  def create
    @mobilization = current_user.mobilizations.build(mobilization_params)

    if @mobilization.save
      Delayed::Job.enqueue(PressureTargetsJob.new(@mobilization.id))
      UserMailer.delay.creation_mail(current_user)
      @mobilization.last_sent_email = DateTime.now - 1.day
      flash[:success] = "Moblização criada!"
      current_user.vote_for @mobilization
      redirect_to @mobilization
    else
      render 'new'
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

  def press
    if current_user.email.to_s == ''
      redirect_to edit_user_path(current_user)
    else
      @mobilization = Mobilization.find(params[:id])
      if !(current_user.voted_on? @mobilization) then
        current_user.vote_for @mobilization
        UserMailer.delay.supportMob_mail(@mobilization, current_user)
      end

      mob_pressures = @mobilization.votes_for
      if (mob_pressures <= 50) and (mob_pressures%10 == 0) and (DateTime.now - 1.day > @mobilization.last_sent_email) then
        Delayed::Job.enqueue(PressureTargetsJob.new(@mobilization.id))
      elsif mob_pressures == 51
        Delayed::Job.enqueue(TwoDayPressureJob.new(@mobilization.id))
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
      params.require(:mobilization).permit(:title, :category, :description, :status, :goal, :mail_content, :target_ids  => [])

    end

    def signed_in_user
      store_location
      redirect_to "/auth/facebook" unless signed_in?
    end
end
