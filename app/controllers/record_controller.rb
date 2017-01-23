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

  def groupby2
    @books = Book.group(:publish).average(:price)
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

  def scope
    @books = Book.gihyo.top10
    render 'hello/list'
  end

  def def_scope
    render text: Review.all.inspect
  end

  def count
    cnt = Book.where(publish: '技術評論社').count
    render text: "#{cnt}件です。"
  end

  def average
    price = Book.where(publish: '技術評論社').average(:price)
    render text: "平均価格は#{price}円です"
  end

  def update_all
    cnt = Book.where(publish: 'Gihyo').update_all(publish: '技術評論社')
    render text: "#{cnt}件のデータを更新しました"
  end

  def update_all2
    cnt = Book.order(:published).limit(5).update_all('price = price * 0.8')
    render text: "#{cnt}件のデータを更新しました"
  end

  def keywd
    @search = SearchKeyword.new
  end

  def keywd_process
    @search = SearchKeyword.new(params[:search_keyword])
    if @search.valid?
      render text: @search.keyword
    else
      render text: @search.errors.full_messages[0]
    end
  end

  def transact
    Book.transaction do
      b1 = Book.new({isbn: '12345', title: 'Rubyぽけっと', price: 2000, publish: '技術評論社', published: '2011-01-01'})
      b1.save!
      # raise 'error: 処理はキャンセルされました'
      b2 = Book.new({isbn: '123456', title: 'Tomcatぽけっと', price: 2500, publish: '技術評論社', published: '2011-01-01'})
      b2.save!
    end
    render text: 'とらんざくしょん　おっけー'
  rescue => e
    render text: e.message
  end

  def hasmany
    @book = Book.find_by(isbn: '978-4-7741-5878-5')
  end

  def hasone
    @user = User.find_by(username: 'yyamada')
  end

  def has_and_belongs
    @book = Book.find_by(isbn: '978-4-7741-5611-8')
  end

  def has_many_through
    @user = User.find_by(username: 'yyamada')
  end

  def cache_counter
    @user = User.find(1)
    render text: @user.reviews.size
  end

  def memorize
    @book = Book.find(1)
    # 本にかんするめも
    @memo = @book.memos.build({ body: 'あとでかう' })
    if @memo.save
      render text: 'めもつくったよ'
    else
      render text: @memo.errors.full_messages[0]
    end
  end

  def assoc_join
    @books = Book.joins(:reviews, :authors).order('books.title, reviews.updated_at').select('books.*, reviews.body, authors.name')
  end

  def assoc_includes
    @books = Book.includes(:authors).all
  end
end