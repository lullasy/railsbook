class ViewController < ApplicationController
  def group_select
    @review = Review.new
    @authors = Author.all
  end

  def fields
    @user = User.find(1)
  end

  def partial_basic
    @book = Book.find(2)
  end

  def partial_param
    @book = Book.find(2)
  end

  def partial_col
    @books = Book.all
  end

  def partial_spacer
    @books = Book.all
  end
end