class ReservationsController < ApplicationController
    before_action :redirect_if_not_logged_in
    before_action :set_reservation, only: [:show, :edit, :update] 
    before_action :redirect_if_not_reservation_author, only: [:edit, :update]

    def index
        #check the params to find the restaurant id and determine the route based on restaurant ID
        if params[:restaurant_id] && @restaurant = Restaurant.find_by_id(params[:restaurant_id])
         @reservations = @restaurant.reservations 
        else
            #if not found the route it will display error message and desplay all reservations
            @error = "The restaurant doesn't exist" if params[:restaurant_id]
            @reservations = Reservation.all  
        end
    end

    def new
        #if it's nested and we find the restaurant
    if params[:restaurant_id] && @restaurant = Restaurant.find_by_id(params[:restaurant_id])
        @reservation = @restaurant.reservations.build #will select and create reservasion based on z restaurant_id 
      else
        @error = "That restaurant doesn't exist" if params[:restaurant_id]
        @reservation = Reservation.new
      end
    end
 
    def create
        #binding.pry
        @reservation = current_user.reservations.build(reservation_params)
        #@reservation.user_id = session[:user_id] #since reservation belong to user 

        if @reservation.save #validaties the reservation
            redirect_to reservations_path
        else
            #@reservation.build_restaurant
            render :new
        end
    end

    # @reservation.restaurant tells me which restaurant it is. b/c of that 
    # I jsut used shallow routes for reservation. to deslplay which restaurant 
    #reservation it is I used restarant show page and pass 
    #restaurant_reservation_path(@restaurant, r)
    def show
        #@reservation = Reservation.find_by(params[:id])
    end

    #since I used shallow routes for the reservation I don't need to use show method 
    def edit
        #@reservations = Reservation.find_by(params[:id])
    end

    def update
        if @reservation.update(reservation_params)
          redirect_to reservation_path(@reservation)
        else
          render :edit
        end
      end


        private 
        def reservation_params
            params.require(:reservation).permit(:num_tables, :checkin_date, :restaurant_id)
        end

        def set_reservation
            @reservation = Reservation.find_by(id: params[:id])
            if !@reservation
                flash[:message] = "Reservation was not found"
                redirect_to reservations_path
            end
        end
        
        def redirect_if_not_reservation_author
            redirect_to reservations_path if @reservation.user != current_user
        end
end
