class MuseumsController < ApplicationController
    def index
        @params = params.permit(:location, :kind_of_museum, :search, :sort).to_h
        @museums = Museum.fetch_by_location(params[:location], current_user).filter_by_params(@params)
      end
    
      def show
        
        @museum = Museum.find(params[:id])
        @review = Review.find_or_initialize_by(user: current_user, museum: @museum)
        
      end
end
