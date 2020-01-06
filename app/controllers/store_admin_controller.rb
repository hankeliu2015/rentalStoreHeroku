class StoreAdminController < ApplicationController
  def dashboard
    @users = User.all
    @tools = Tool.all 
  end
end
