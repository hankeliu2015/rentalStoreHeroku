class ToolsController < ApplicationController
  def index
    #binding.pry
    @tools = Tool.all
  end

  def show
    #binding.pry
    @tool = Tool.find_by(id: params[:id])
  end
end
