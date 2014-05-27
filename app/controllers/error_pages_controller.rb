class ErrorPagesController < ApplicationController

  def handle_404
    redirect_to root_path, notice: "Sorry! Either that url does not exist or you do not have access to it."
  end

end