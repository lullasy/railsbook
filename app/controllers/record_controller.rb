class RecordController < ApplicationController
  def find
    @books = Book.find([2, 5, 10])
    render 'hello/list'
  end

  def where
    @books = Book.where(publish:'翔泳社')
    render 'hello/list'
  end

  def ph1
    @books = Book.where('publish = ? AND price >= ?', params[:publish], params[:price])
    render 'hello/list'
  end
end