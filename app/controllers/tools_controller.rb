class ToolsController < ApplicationController
before_action :set_tool, only: [:show, :edit, :update, :destroy]

  def index
    #binding.pry
    @tools = Tool.all
  end

  def show
    #binding.pry
    #@tool = Tool.find_by(id: params[:id])
    @in_progress = @tool.rentals.in_progress
    respond_to do |f|
      f.html {render :show}
      f.json {render json: @tool}
      # f.json {render json: @in_progress}
    end
  end

  private

  def set_tool
    @tool = Tool.find_by(id: params[:id])
  end

end #end of class.
