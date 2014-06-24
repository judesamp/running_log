class RunsController < ApplicationController
  before_filter :ensure_run_ownership

  # GET users/:id/runs
  # returns all runs connected to current user
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

  # GET users/:id/runs/new
  # returns a blank new run, connected to form shown here
  def new
    @run = Run.new
  end

  # POST users/:id/runs
  # creates and return a run, overall run count, and current user
  def create
    @runs = Run.most_recent_by_date.page(params[:page]).per(params[:per])
    @current_user = current_user
    @run_count = @runs.count
    @new_run = Run.new(run_params)
    if @new_run.save
      respond_to do |format|
        format.js { render @new_run }
        format.html { redirect_to user_runs_path }
      end 
    else
      respond_to do |format|
        format.js {render plain: '0'}
        format.html { render :new }
      end
    end
  end

  # GET users/:id/runs/:id
  # returns specific run, based on id
  def show
    @run = Run.find(params[:id])
    respond_to do |format|
      format.js {render @run}
      format.json {render @run}
      format.html { redirect_to user_runs_path }
    end
  end

  # GET users/:id/runs/edit
  # find a run, ready for update (through form)
  def edit
    @run = Run.find(params[:id])
    respond_to do |format|
      format.js
      format.html { redirect_to user_runs_path }
    end
  end

  # PUT users/:id/runs/:id
  # updates specific run based on id
  def update
    @run = Run.find(params[:id])
    if @run.update_attributes(run_params)
      respond_to do |format|
        # processed_date = pretty_date(@run.run_date)
        # average_pace = pretty_pace(@run.per_mile_pace)
        format.js {render @run}
        format.html { redirect_to user_runs_path }
      end
    else
      respond_to do |format|
        format.js
        format.html { render :edit}
      end
    end
  end

  # DELETE users/:id/runs/:id
  # destroys specific run based on id
  def destroy
    @run = Run.find(params[:id])
    @id = @run.id
    if @run.destroy
      respond_to do |format|
        format.js {render plain: '1'}
        format.html {redirect_to user_runs_path}
      end
    else
      respond_to do |format|
        format.js {render plain: "0"}
        format.html {render :back}
      end
    end
  end

  #GET users/:id/runs/filter
  #filters all runs based on user-selected criteria
  def filter
    filter_type = params[:filter][:type]
    case filter_type
    when "last_seven", "weekly"
      @filter = "Weekly"
      @filtered_runs = current_user.runs.in_the_last_week
    when "last_thirty", "monthly"
      @filter = "Monthly"
      @filtered_runs = current_user.runs.in_the_last_thirty_days
    when "year", "yearly"
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

  def ensure_run_ownership
    if params[:user_id] != current_user.id.to_s
      redirect_to root_path, notice: "You don't have permission to view this page."
    end
  end

end
