class ReviewsController < ApplicationController

  def new
    @restaurant = Restaurant.find(params[:restaurant_id])
    @review = Review.new
  end

  def create
    @restaurant = Restaurant.find(params[:restaurant_id])
    @review = @restaurant.build_review(review_params, current_user)

    if @review.save
      redirect_to restaurants_path
    else
      if current_user.nil?
        flash[:notice] = 'You need to log in'
        redirect_to restaurants_path
      elsif @review.errors[:user]
        flash[:notice] = 'You have already reviewed this restaurant'
        redirect_to restaurants_path
      else
        render :new
      end
    end
  end

  def destroy
    p @review = Review.find(params[:id])
    if current_user
    if @review.user_id == current_user.id
      @review.destroy
      redirect_to restaurants_path
      flash[:notice] = 'Review successfully deleted'
    else
      flash[:notice] = 'You cannot delete this review'
      redirect_to restaurants_path
    end
  else
    flash[:notice] = "Please log in"
    redirect_to restaurants_path
  end
  end

  def review_params
    params.require(:review).permit(:thoughts, :rating)
  end
end
