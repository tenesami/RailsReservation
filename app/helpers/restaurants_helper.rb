module RestaurantsHelper

    def index_display_header
        if @user
          content_tag(:h1, "#{@user.username}'s Restaurants:")
        else
          content_tag(:h2, "All Restaurants")
        end
      end
    
      def display_restaurants
        if @user.restaurants.empty?
          tag.h2(link_to('No restaurants yet - write a restaurants here', new_restaurant_path))
        else
          user = @user == current_user ? 'Your' : "#{@user.username}'s"
          content_tag(:h2, "#{user} #{pluralize(@user.restaurants.count, 'Restaurant')}:")
    
        end
      end
end
