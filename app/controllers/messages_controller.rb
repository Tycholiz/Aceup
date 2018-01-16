class MessagesController < ApplicationController
	def new
		@message = Message.new
	end

	def create
	    @message = Message.new message_params

	    if @message.valid?
	      MessageMailer.contact_me(@message).deliver_now
	      flash[:success] = "Message received, thanks!"
	      redirect_to root_path
	    else
	      flash[:error] = "There was an error sending your message."
	      render :new
	    end
	  end

  private

  def message_params
    params.require(:message).permit(:name, :email, :body)
  end

end
