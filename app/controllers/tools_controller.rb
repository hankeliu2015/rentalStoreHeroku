class ToolsController < ApplicationController
  def index
    binding.pry
    @tools = Tool.all
  end

  def show
  end
end
