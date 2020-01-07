class RentalsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index

    @rentals = Rental.all.page params[:page]   #testing pagination pages settings


    @user = current_user
    # @user = User.find_by(id: current_user.id)

    @in_prossession = @user.rentals.in_progress
    @overdue_items = @user.rentals.overdued
    @past_rented_tools = @user.rentals.completed


    respond_to do |format|
      format.html {render :index}
      format.json {render json: @past_rented_tools }
    end

  end

  def new
    @rental = Rental.new(tool_id: params[:tool_id])
    # need the rental instance, which scheduled for the future.
    # to have the condition to highlight the calendar dates.
    respond_to do |format|
      format.html {render :new}
      format.json {render json: @rental}
    end
  end

  def edit
    @rental = Rental.find_by(id: params[:id])
  end

  def create

    @tool = Tool.find_by(id: params[:tool_id])
    @rental = current_user.rentals.build(rental_params)
    @rental.tool_id = @tool.id
    @rental.start_date = Date.parse(params[:rental][:start_date])
    @rental.return_date = Date.parse(params[:rental][:return_date])

    if @rental.save
      # NotifyMailer.rental_confirmation(@rental).deliver_now
      respond_to do |format|
        format.html {redirect_to profile_path}
        format.json {render json: @rental}
      end
    else
      respond_to do |f|
        f.html {render :new}
        f.json {render json: @rental.errors, status: :unprocessable_entity}
      end
    end

      # else
      #   render :new #"/tools/#{@tool.id}/rentals/new"
      # end

  end

  def update

    @rental = Rental.find_by(tool_id: params[:tool_id], user_id: current_user.id, return: false)

    if @rental.return_date >= Date.today
      @rental.update(actual_return_date: Date.today, return: true)
      redirect_to profile_path, {alert: "Thank you for return #{@rental.tool.name}. Here is the rental cost: $123456"}
    else

      @rental.update(actual_return_date: Date.today, return: true)
      redirect_to profile_path, {alert: "Thank you for return #{@rental.tool.name}. To avoid furture overdue charge, please return on time. Thanks!"}
    end
  end

  def reschedule_return

    @rental = Rental.find_by(id: params[:id])
    if @rental.update(rental_params)
      redirect_to profile_path
    else
      render :edit
    end
  end

  def checkout_update #wip, not test yet. Might not need it.

    @rental = Rental.find_by(id: params[:id])
    @rental.update(checkout: true)
  end

  private
  def rental_params
    params.require(:rental).permit(:start_date, :return_date, :checkout)
  end

end
