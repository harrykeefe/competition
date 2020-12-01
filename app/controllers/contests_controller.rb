class ContestsController < ApplicationController
  before_action :authenticate_user!

  def new
    @contest = Contest.new
    number_of_prizes.times { @contest.prizes.build }
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
        format.html { render :edit }
        format.json { render json @contest.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def contest_params
    params.require(:contest).permit(:name, prizes_attributes: [:name, :value, :id])
  end

  def number_of_prizes
    case current_user.account_type
    when "paid"
      User::PAID_TIER_PRIZE_DEFAULT
    when "free"
      User::FREE_TIER_PRIZE_LIMIT
    end
  end
end
