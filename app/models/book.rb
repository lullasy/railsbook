class Book < ActiveRecord::Base
  has_many :reviews
  has_and_belongs_to_many :authors
  has_many :users, through: :reviews
  has_many :memos, as: :memoable

  # after_destroy :history_book
  after_destroy do |b|
    logger.info('deleted: ' + b.inspect)
  end


  scope :gihyo, -> { where(publish: '技術評論社') }
  scope :newer, -> { order(published: :desc) }
  scope :top10, -> { newer.limit(10) }

  validates :isbn,
    presence: { message: 'は必須だよー' },
    uniqueness: { allow_blank: true, message: '%{value}は一意じゃないとダメー' },
    length: { is: 17, allow_blank: true, message: '%{value}は%{count}桁じゃないとだめー' },
    isbn: { allow_old: true }
  validates :title,
    presence: true,
    length: { minimum: 1, maximum:100 }
  validates :price,
    numericality: { only_integer: true, less_than: 10000 }
  validates :publish,
    inclusion: { in: ['技術評論社', '翔泳社', '秀和システム', '日経BP社', 'ソシム'] }


  private
  def history_book
    logger.info('deleted: ' + self.inspect)
  end
end
