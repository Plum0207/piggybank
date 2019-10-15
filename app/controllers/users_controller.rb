class UsersController < ApplicationController

  def index
    @users = User.where('nickname LIKE(?)', "%#{params[:search]}%").where.not(id: current_user.id)
    respond_to do |format|
      format.html
      format.json
    end
  end

end
