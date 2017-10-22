class PlansController < ApplicationController
  def index
    year, month, day = ymd(params[:date])
    @selectedDate = Date.new(year, month, day)
    @firstDate = Date.new(@selectedDate.year, @selectedDate.month, 1)
    @lastDate = Date.new(@selectedDate.year, @selectedDate.month, -1)
    @week = {}

    # 各日にちの曜日を得る
    (@firstDate.day..@lastDate.day).each do |day|
      @date = Date.new(@selectedDate.year, @selectedDate.month, day)
      @week[day] = @date.wday
    end

    # その日の @plans を取り出す
    @plans = Plan.where(date: params[:date]).order(:start_time)
  end

  def show
    @plan = Plan.find(params[:id])
  end

  def new
    @plan = Plan.new(date: params[:date])
  end

  def edit
    @plan = Plan.find(params[:id])
  end

  def create
    y, m, d = ymd(params[:date])
    start_time = Time.utc(y, m, d, params[:start_hour], params[:start_min], 0)
    end_time = Time.utc(y, m, d, params[:end_hour], params[:end_min], 0)
    @plan = Plan.new(date: params[:date])
    @plan.start_time = start_time
    @plan.end_time = end_time
    @plan.title = params[:title]
    @plan.detail = params[:detail]

    if @plan.save
      redirect_to "/plans/#{@plan.date}", notice: "予定を追加しました"
    else
      render "new"
    end
  end

  def update
    @plan = Plan.find(params[:id])
    y, m, d = ymd(params[:date])
    start_time = Time.utc(y, m, d, params[:start_hour], params[:start_min], 0)
    end_time = Time.utc(y, m, d, params[:end_hour], params[:end_min], 0)

    @plan.date = params[:date]
    @plan.start_time = start_time
    @plan.end_time = end_time
    @plan.title = params[:title]
    @plan.detail = params[:detail]

    if @plan.save
      redirect_to "/plans/#{@plan.date}/#{@plan.id}", notice: "予定を編集しました"
    else
      render "edit"
    end
  end

  def destroy
    @plan = Plan.find(params[:id])
    @plan.destroy
    redirect_to "/plans/#{params[:date]}", notice: "予定を削除しました"
  end

  def changeMonths
    year = params[:year]
    month = params[:month]
    redirect_to "/plans/#{year}-#{month}-1" # 初めは1日を表示
  end

  private
    def ymd(date)
      return date.split("-").map { |s| s.to_i }
    end
end
