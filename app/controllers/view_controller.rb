class ViewController < ApplicationController
  def group_select
    @review = Review.new
    @authors = Author.all
  end

  def fields
    @user = User.find(1)
  end
end