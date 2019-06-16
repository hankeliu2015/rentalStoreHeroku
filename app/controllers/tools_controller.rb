class ToolsController < ApplicationController
before_action :set_tool, only: [:show, :edit, :update, :destroy]

  def index
    @tools = Tool.all
  end

  def show
    @in_progress = @tool.rentals.in_progress
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
