class RestaurantsController < ApplicationController
    before_action :redirect_if_not_logged_in
    
    def new
        if params[:user_id] && @user = User.find_by_id(params[:user_id])
            @restaurant = @user.restaurants.build
          else
            @restaurant = Restaurant.new
          end
    end

    def index
        
        if params[:user_id] && @user = User.find_by_id(params[:user_id])
               
            #@restaurants = @user.restaurants.most_reservations
            @restaurants = @user.restaurants.search(params[:search])
            #binding.pry 
        else
            @error = "These user doesn't exist" if params[:user_id]
                #@restaurants = Restaurant.most_reservations.includes(:user)
                @restaurants = Restaurant.search(params[:search])
            end
       
    end

    def create
        @restaurant = current_user.restaurants.build(restaurant_params)
        if @restaurant.save
            redirect_to restaurants_path(@restaurant)
        else
            render :new
        end
    end

    def edit
        @restaurant = Restaurant.find_by_id(params[:id])
        redirect_to restaurants_path if !@restaurant || @restaurant.user != current_user
      end
    
    def update
    @restaurant = Restaurant.find_by(id: params[:id])
    redirect_to restaurants_path if !@restaurant || @restaurant.user != current_user
        if @restaurant.update(restaurant_params)
        redirect_to restaurant_path(@restaurant)
        else
        render :edit
        end
    end

    def show
        @restaurant = Restaurant.find_by_id(params[:id])
        redirect_to restaurants_path if !@restaurant
    end

    private
    def restaurant_params
        params.require(:restaurant).permit(:restaurant_name, :available_table, :search)
    end

end
