class RentalsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
    # user current_user to identify user_id.
    @user = User.find_by(id: current_user.id)
    # if current_user.id != @user.id
    #   flash[:alert] = "You can not access other user's profile. Here is the information under your profile"
    #   @user = current_user #make sure @user consistancy in show.html.erb
    # end

    @user = current_user
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

  def create

    @tool = Tool.find_by(id: params[:tool_id])

      @rental = current_user.rentals.build(rental_params)
      @rental.tool_id = @tool.id

      if @rental.valid?
        # rental.start_date = Date.strptime(params[:rental][:start_date], "%m/%d/%Y")

        @rental.start_date = Date.parse(params[:rental][:start_date])
        @rental.return_date = Date.parse(params[:rental][:return_date])
        if @rental.save
          redirect_to profile_path #user_path(@rental.user)
        else
          redirect_to root_path
        end
      else
        render :new #"/tools/#{@tool.id}/rentals/new"
      end
    # else
    #   redirect_to root_path, {alert: "Sorry, this #{@tool.name} is curretly rented"}
    # end


  end # end of method

  def update

    @rental = Rental.find_by(tool_id: params[:tool_id], user_id: current_user.id, return: false)

    if @rental.return_date >= Date.today
      @rental.update(actual_return_date: Date.today, return: true)
      redirect_to profile_path, {alert: "Thank you for return #{@rental.tool.name}. Here is the rental cost: $123456"}
    else

      @rental.update(actual_return_date: Date.today, return: true)
      redirect_to profile_path, {alert: "Thank you for return #{@rental.tool.name}. To avoid furture overdue charge, please return on time. Thanks!"}
    end
  end #end of method

  def reschedule_return

    @rental = Rental.find_by(id: params[:id])
    # binding.pry
    if @rental.update(rental_params)
      redirect_to profile_path ##user_path(current_user)
    else
      render :edit
    end
  end

  def checkout_update #not hit by checkout button

    @rental = Rental.find_by(id: params[:id])
    @rental.update(checkout: true)
  end

  private
  def rental_params
    params.require(:rental).permit(:start_date, :return_date, :checkout)
  end

end
