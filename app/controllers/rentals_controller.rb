class RentalsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
#binding.pry
    @user = User.find_by(id: params[:user_id])
    if current_user.id != @user.id
      flash[:alert] = "You can not access other user's profile. Here is the information under your profile"
      @user = current_user #make sure @user consistancy in show.html.erb
    end

    @user = current_user
    # @in_progress = @user.rentals.in_progress #replaced by in_prossession
    @in_prossession = @user.rentals.in_possession
    @overdue_items = @user.rentals.overdue
    @past_rented_tools = @user.rentals.past_rentals
  end #end of method

  def new
    @rental = Rental.new(tool_id: params[:tool_id])
    # need the rental instance, which scheduled for the future.
    # to have the condition to highlight the calendar dates.
  end

  def edit
    #@rental = Rental.new(tool_id: params[:tool_id])
    #binding.pry
    @rental = Rental.find_by(id: params[:id])
  end

  def reschdulereturn

  end

  def create

    @tool = Tool.find_by(id: params[:tool_id])

    #if @tool.available_for_rent? #rentals.available_to_rent? #where(return: false).empty? #count == 0

      # @rental = Rental.new(rental_params)
      # @rental.user_id = current_user.id
      # @rental.tool_id = @tool.id

      @rental = current_user.rentals.build(rental_params)
      @rental.tool_id = @tool.id

      if @rental.valid?
        # rental.start_date = Date.strptime(params[:rental][:start_date], "%m/%d/%Y")

        @rental.start_date = Date.parse(params[:rental][:start_date])
        @rental.return_date = Date.parse(params[:rental][:return_date])
        if @rental.save
          redirect_to user_path(@rental.user)
        else
          redirect_to root_path
        end
      else
        render :new #"/tools/#{@tool.id}/rentals/new"
        #redirect_to new_tool_rental_path(@tool) #, #{alert: "#{rental.errors.full_messages}" }
      end
    # else
    #   redirect_to root_path, {alert: "Sorry, this #{@tool.name} is curretly rented"}
    # end


  end # end of method

  def update
#binding.pry
    @rental = Rental.find_by(tool_id: params[:tool_id], user_id: current_user.id, return: false)

    if @rental.return_date >= Date.today

      @rental.update(actual_return_date: Date.today, return: true)

      redirect_to user_path(current_user), {alert: "Thank you for return #{@rental.tool.name}. Here is the rental cost: $123456"}

    else
      @rental.update(actual_return_date: Date.today, return: true)
      redirect_to user_path(current_user), {alert: "Thank you for return #{@rental.tool.name}. To avoid furture overdue charge, please return on time. Thanks!"}
    end

  end #end of method


  private
  def rental_params
    params.require(:rental).permit(:start_date, :return_date, :return) #:user_id, :tool_id, removed from form_for hidden_fields
  end

end
