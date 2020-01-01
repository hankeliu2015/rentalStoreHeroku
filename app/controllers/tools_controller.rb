class ToolsController < ApplicationController
before_action :set_tool, only: [:show, :edit, :update, :destroy]

  def index
    @tools = Tool.all
  end

  def show
    @rental_in_progress_message = "This tool is not available right now. Please scheulde rentals date base on tool return date:"
    @rental_overdued_message = "This tool is overdued, not available for rent. Sorry!"
    @in_progress = @tool.rentals.in_progress

    if current_user
      #
      # if there are tools one day away from return.
      # NotifyMailer.rental_confirmation()
      #
    end

    respond_to do |f|
      f.html {render :show}
      f.json {render json: @tool}
    end
  end

  private

  def set_tool
    @tool = Tool.find_by(id: params[:id])
  end

end
