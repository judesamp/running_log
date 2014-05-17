class RunsController < ApplicationController

  def index
    @runs = Run.most_recent_by_date
  end

  def new
    @new_run = Run.new
  end

  def create
    @new_run = Run.new(run_params)
    if @new_run.save
      respond_to do |format|
        format.js
        format.html { redirect_to runs_path }
      end 
    else
      respond_to do |format|
        format.js {render plain: '0'}
        format.html { render :new }
      end
    end
  end

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
        format.js
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
        format.js
        format.html {redirect_to runs_path}
      end
    else
      respond_to do |format|
        format.js {render plain: "0"}
        format.html {render :back}
      end
    end
  end

  private

  def run_params
    params.require(:run).permit(:run_date, :run_time, :route_name, :distance, :notes)
  end 
end
