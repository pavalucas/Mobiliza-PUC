class MobilizationsController < ApplicationController
  before_action :signed_in_user, only: [:new, :create, :show, :press]
  before_action :owner_user, only: [:edit, :update]
  before_action :admin_user, only: :destroy
  before_action :complete_user, only: [:new, :press]

  $qntCategories = 5
  $categories = ["Ciclo Básico Engenharia", "Ciclo Profissional", "Direito", "Economia", "Outros"]
  $statuses = ["Em progresso", "Em pausa", "Terminada", "Inativa"]

  # GET /mobilizations
  # GET /mobilizations.json
  def index
    @mobilizations = Mobilization.all.page params[:page]
  end

  # GET /mobilizations/1
  # GET /mobilizations/1.json
  def show
    @user = current_user
    @mobilization = Mobilization.find(params[:id])
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
    @mobilization = current_user.mobilizations.build(mobilization_params)
    @mobilization.status = 0

    if @mobilization.save
      Delayed::Job.enqueue(PressureTargetsJob.new(@mobilization.id))
      UserMailer.delay(:queue => 'greating_mail').creation_mail(current_user)
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
      mobPressions = Vote.where('voteable_id = ? AND voter_id != ?', @mobilization.id, @mobilization.user_id)
      mobPressions.each do |pression|
        if User.where(id: pression.voter_id).present?
          user = User.find(pression.voter_id)
          UserMailer.delay(:queue => 'update_mail').edited_mail(@mobilization, user)
        end
      end
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
    @mobilization = Mobilization.find(params[:id])
    if !(current_user.voted_on? @mobilization) then
      current_user.vote_for @mobilization
      UserMailer.delay(:queue => 'greating_mail').supportMob_mail(@mobilization, current_user)
    end

    mob_pressures = @mobilization.votes_for
    if (mob_pressures <= 50) and (mob_pressures%10 == 0) and (DateTime.now - 1.day > @mobilization.last_sent_email) then
      Delayed::Job.enqueue(PressureTargetsJob.new(@mobilization.id))
    elsif mob_pressures == 51
      Delayed::Job.enqueue(TwoDayPressureJob.new(@mobilization.id))
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
    # Never trust parameters from the scary internet, only allow the white list through.
    def mobilization_params
      params.require(:mobilization).permit(:title, :category, :description, :goal, :status, :mail_content, :target_ids  => [])
    end

    def signed_in_user
      store_location
      redirect_to "/auth/facebook" unless signed_in?
    end

    def owner_user
      @mobilization = Mobilization.find(params[:id])
      redirect_to @mobilization unless @mobilization.user_id == current_user.id
    end

    def admin_user
      redirect_to root_url unless current_user.admin?
    end

    def complete_user
      user_is_complete = !(current_user.email.to_s == '') and !(current_user.registration.to_s == '')
      redirect_to edit_user_path(current_user) unless user_is_complete
    end

end
