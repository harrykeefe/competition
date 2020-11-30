class ContestsController < ApplicationController
  before_action :authenticate_user!

  def new
    @contest = Contest.new
  end

  def create
    @contest = current_user.contests.build(contest_params)

    respond_to do |format|
      if @contest.save
        format.html { redirect_to root_path, notice: "Contest successfully created" }
        format.json { }
      else
        format.html { render :new }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def contest_params
    params.require(:contest).permit(:name)
  end
end
