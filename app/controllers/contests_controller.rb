class ContestsController < ApplicationController
  before_action :authenticate_user!

  DEFAULT_NUMBER_OF_PRIZES = 8

  def new
    @contest = Contest.new
    DEFAULT_NUMBER_OF_PRIZES.times { @contest.prizes.build }
  end

  def create
    @contest = current_user.contests.build(contest_params)

    respond_to do |format|
      if @contest.save
        format.html { redirect_to root_path, notice: "Contest successfully created" }
        format.json { }
      else
        format.html { render :new }
        format.json { render json: @contest.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
    @contest = Contest.find params[:id]
  end

  def update
    @contest = Contest.find params[:id]

    respond_to do |format|
      if @contest.update(contest_params)
        format.html { redirect_to root_path, notice: "Contest was successfully updated" }
        format.json { }
      else
        format.html { render :new }
        format.json { render json @contest.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def contest_params
    params.require(:contest).permit(:name, prizes_attributes: [:name, :value, :id])
  end
end
