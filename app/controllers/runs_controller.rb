class RunsController < ApplicationController

  def index
    @runs = current_user.runs.most_recent_by_date.page(params[:page]).per(params[:per])
    @run_count = @runs.count
    @user = current_user
    respond_to do |format|
      format.js
      format.html
      format.json {render @user}
    end
  end

  def new
    @run = Run.new
  end

  def create
    @runs = Run.most_recent_by_date.page(params[:page]).per(params[:per])
    @current_user = current_user
    @run_count = @runs.count
    @new_run = Run.new(run_params)
    if @new_run.save
      respond_to do |format|
        format.js { render @new_run }
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
    respond_to do |format|
        format.js {render @run}
        format.json {render @run}
        format.html { redirect_to runs_path }
      end
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
        # processed_date = pretty_date(@run.run_date)
        # average_pace = pretty_pace(@run.per_mile_pace)
        format.js {render @run}
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
      @filtered_runs = current_user.runs.in_the_last_week
    when "last_thirty"
      @filter = "Monthly"
      @filtered_runs = current_user.runs.in_the_last_thirty_days
    when "year"
      @filter = "Yearly"
      @filtered_runs = current_user.runs.in_the_last_year
    when "lifetime"
      @filter = "Lifetime"
      @filtered_runs = current_user.runs.most_recent_by_date
    end

    respond_to do |format|
      format.js
    end

  end

  private

  def run_params
    params.require(:run).permit(:run_date, :run_time, :route_name, :distance, :notes, :user_id)
  end

end
