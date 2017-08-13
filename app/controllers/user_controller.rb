class UserController < ApplicationController
  def new
    @user = User.new
    render :template => 'vote/confirm_vote'
  end
    
  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to finish_poll_path(:param1 => @user.id)
    else
      render :template => 'vote/confirm_vote'
    end
  end
  
  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name,:email)
    end
end