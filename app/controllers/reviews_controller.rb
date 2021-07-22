class ReviewsController < ApplicationController
    before_action :set_museum
  before_action :set_review, only: [:update]

  def create
    @review = current_user.reviews.build(review_params)
    @review.museum = @museum
    if @review.save
      redirect_to @museum
    else
      render :"museums/show"
    end
  end

  def update
    if @review.update(review_params)
      redirect_to @museum
    else
      render :"museums/show"
    end
  end

  private

  def set_review
    @review = Review.find(params[:id])
  end

  def set_museum
    @museum = Museum.find(params[:museum_id]) if params[:museum_id]
  end

  def review_params
    params.require(:review).permit(:rating, :content)
  end

end
