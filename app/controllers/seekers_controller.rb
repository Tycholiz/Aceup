class SeekersController < ApplicationController
  def new
    @seeker = Seeker.new
  end

  def create
    @seeker = Seeker.new(seeker_params)
    @seeker.user_id = current_user.id

    if @seeker.save
      redirect_to jobs_path, notice: "Welcome aboard"
    else
      render :new
    end
  end

  def show
    @seeker = Seeker.find(params[:id])
    @jobs = Job.all

    seekSkills = @seeker.attributes.select {|key, value| value == true }
    @matchJobs = Array.new
    @jobs.each do |job|
      jobSkills = job.attributes.select {|key, value| value == true }
      jobSkills.delete("temp") #should change temp to something else in database

      @matchJobs.push job if (jobSkills <= seekSkills)

    end
    @matchJobs = Kaminari.paginate_array(@matchJobs).page(params[:page]).per(10) 

  end

  def edit
    @seeker  = Seeker.find(params[:id])
  end

   def update
    @seeker = Seeker.find(params[:id])

    if @seeker.update_attributes(seeker_params)
      redirect_to seeker_path(@seeker)
    else
      render :edit
    end
  end

  def applied
    @seeker  = Seeker.find(params[:id])
    @applications = Application.where(seeker_id: @seeker.id)
    @appliedJobs = Array.new
    @applications.each do |app|
      job = Job.where(id: app.job_id).first
      @appliedJobs.push job
    end
  end

  protected

  def seeker_params
    params.require(:seeker).permit(:postalCode, :educationLevel, :degree, :inSales, :outSales, :inboundSales, :outboundSales, :coldCall, :doorToDoor, :custService, :acctManagment, :negotiation, :presenting, :leadership, :closing, :hunterBased, :farmerBased, :commBased, :B2C, :B2B, :consSales, :directSales, :solutionSales, :certifications, :languages => [])
  end
end