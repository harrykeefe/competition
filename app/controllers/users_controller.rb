class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @user = current_user
    @contests = current_user.contests.includes(:prizes)
  end

end
