class RunsController < ApplicationController

  def index
    @runs = Run.most_recent_by_date.page(params[:page]).per(params[:per])
    @run_count = @runs.count
    respond_to do |format|
      format.js
      format.html
    end
  end

  def new
    @new_run = Run.new
  end

  def create
    @runs = Run.most_recent_by_date.page(params[:page]).per(params[:per])
    @run_count = @runs.count
    @new_run = Run.new(run_params)
    if @new_run.save
      respond_to do |format|
        processed_date = pretty_date(@new_run.run_date)
        average_pace = pretty_pace(@new_run.per_mile_pace)
        format.js { render json: { calculated_pace: average_pace, pretty_date: processed_date, data: @new_run} }
        format.html { redirect_to runs_path }
      end 
    else
      respond_to do |format|
        format.js {render plain: '0'}
        format.html { render :new }
      end
    end
  end

  # def create
  #   @runs = Run.most_recent_by_date.page(params[:page]).per(params[:per])
  #   @run_count = @runs.count
  #   @new_run = Run.new(run_params)
  #   if @new_run.save
  #     respond_to do |format|
  #       format.js { render 'runs/index'}
  #       format.html { redirect_to runs_path }
  #     end 
  #   else
  #     respond_to do |format|
  #       format.js {render plain: '0'}
  #       format.html { render :new }
  #     end
  #   end
  # end

  def show
    @run = Run.find(params[:id])
  end

  def edit
    @run = Run.find(params[:id])
    respond_to do |format|
      format.js
      format.html
    end
  end

  def update
    @run = Run.find(params[:id])
    if @run.update(run_params)
      respond_to do |format|
        processed_date = pretty_date(@run.run_date)
        average_pace = pretty_pace(@run.per_mile_pace)
        format.js {render json: { calculated_pace: average_pace, pretty_date: processed_date, data: @run} }
        format.html { redirect_to runs_path }
      end
    else
      respond_to do |format|
        format.js
        format.html { render :edit}
      end
    end
  end

  def destroy
    @run = Run.find(params[:id])
    @id = @run.id
    if @run.destroy
      respond_to do |format|
        format.js {render plain: '1'}
        format.html {redirect_to runs_path}
      end
    else
      respond_to do |format|
        format.js {render plain: "0"}
        format.html {render :back}
      end
    end
  end

  def filter
    filter_type = params[:filter][:type]
    case filter_type
    when "last_seven"
      @filter = "Weekly"
      @filtered_runs = Run.in_the_last_week
    when "last_thirty"
      @filter = "Monthly"
      @filtered_runs = Run.in_the_last_thirty_days
    when "year"
      @filter = "Yearly"
      @filtered_runs = Run.in_the_last_year
    when "lifetime"
      @filter = "Lifetime"
      @filtered_runs = Run.most_recent_by_date
    end

    respond_to do |format|
      format.js
    end

  end

  private

  def run_params
    params.require(:run).permit(:run_date, :run_time, :route_name, :distance, :notes)
  end

  def filter_params
    params.require(:filter).permit(:type)
  end
end
