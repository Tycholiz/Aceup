class Admin::SeekersController < Admin::BaseAdminController

  def new
    @seeker = Seeker.new
  end

  # def create
  #   @seeker = seeker.new(seeker_params)
  #   @seeker.user_id = current_user.id

  #   if @seeker.save       
  #         redirect_to admin_seekers_path, notice: "User #{@seeker.compName} successfully!"
  #   else
  #     render :new,  notice: "Could not be created."
  #   end
  # end

  # def show
  #   @seeker = seeker.find(params[:id])
  #   @jobs = Job.where(seeker_id: @seeker.id)
  # end

  def index
    @seekers = Seeker.all
    @seekers = @seekers.order(:updated_at).reverse_order.page(params[:page]).per(15) 
  end

  def edit
    @seeker = Seeker.find(params[:id])
  end

  #  def update
  #   @seeker = seeker.find(params[:id])

  #   if @seeker.update_attributes(seeker_params)
  #     redirect_to admin_seekers_path, notice: "Updated successfully!"
  #   else
  #     flash[:error] = @seeker.errors.full_messages.to_sentence
  #     redirect_to admin_seekers_path
  #   end
  # end

  def destroy
      @seeker  = Seeker.find(params[:id])
      @seeker.destroy
      redirect_to admin_seekers_path, notice: "#{@seeker.id} was deleted successfully!"
  end

  def applications
    @seeker = Seeker.find(params[:id])
    @jobs = Job.where(seeker_id: @seeker.id)
    @applications = Array.new
    @jobs.each do |job|
      @applied = Application.where(job_id: job.id)
      @applied.each do |app|
        @applications.push app if @applied.length > 0
      end
    end

  end

  protected

  def seeker_params
    params.require(:seeker).permit(:compName, :compSize, :city, :logo, :compDesc)
  end
end