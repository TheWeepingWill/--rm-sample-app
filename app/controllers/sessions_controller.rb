class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: login_params[:email].downcase)
    if user && user.authenticate(login_params[:password])
      reset_session
      log_in user
      redirect_to user
    else
      flash.now[:danger] = 'Incorrect User or Password'
      render 'new', status: :unprocessable_entity
    end
  end
  
  def destroy
    log_out
    redirect_to root_url, status: :see_other
  end

  # PRIVATE 
  
  private
  
  def login_params 
    params.require(:session).permit(:email, :password)
  end
end
