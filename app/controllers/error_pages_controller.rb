class ErrorPagesController < ApplicationController

  def handle_404
    redirect_to root_path, notice: "Sorry! That url doesn't exist or you don't have access to it."
  end

end