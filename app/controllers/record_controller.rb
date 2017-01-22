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

  def order
    @books = Book.where(publish: '技術評論社').order(price: :desc)
    render 'hello/list'
  end

  def page
    page_size = 3
    page_num = params[:id] == nil ? 0 : params[:id].to_i - 1
    @books = Book.order(published: :desc).limit(page_size).offset(page_size * page_num)
    render 'hello/list'
  end

  def groupby
    @books = Book.select('publish, AVG(price) AS avg_price').group(:publish)
  end

  def havingby
    @books = Book.select('publish, AVG(price) AS avg_price').group(:publish).having('AVG(price) >= ?', 2500)
    render 'record/groupby'
  end

  def none
    case params[:id]
    when 'all'
      @books = Book.all
    when 'new'
      @books = Book.order('published DESC').limit(5)
    when 'cheap'
      @books = Book.order(:price).limit(5)
    else
      @books = Book.none
    end
    render 'books/index'
  end
end