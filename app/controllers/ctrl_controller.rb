require 'kconv'

class CtrlController < ApplicationController

  # before_action :start_logger, only: [:index, :index2]
  # after_action :end_logger, except: :index
  # around_action :around_logger
  # skip_action_callback :mylogging

  before_action :auth, only: :index

  def index
    # sleep 3
    render text: 'index だよー'
  end

  def index2
    # sleep 3
    render text: 'index2 だよー'
  end

  def para
    render text: 'idぱらめた：' + params[:id]
  end

  def para_array
    render text: 'categoryぱらめた：' + params[:category].inspect
  end

  def req_head
    render text: request.headers['User-Agent']
  end

  def req_head2
    @headers = request.headers
  end

  def upload_process
    file = params[:upfile]
    name = file.original_filename
    perms = ['.jpg', '.jpeg', '.gif', '.png']
    if !perms.include?(File.extname(name).downcase)
      result = '画像だけおっけーだよ〜'
    elsif file.size > 1.megabyte
      resilt = 'ファイルサイズは1MBまでだよ〜'
    else
      name = name.kconv(Kconv::SJIS, Kconv::UTF8)
      File.open("public/docs/#{name}", 'wb') { |f| f.write(file.read) }
      result = "#{name.toutf8}をあげたよー"
    end

    render text: result
  end

  def updb
    @author = Author.find(params[:id])
  end

  def updb_process
    @author = Author.find(params[:id])
    if @author.update(params.require(:author).permit(:data))
      render text: 'ほぞんおっけー'
    else
      render text: @author.errors.full_messages[0]
    end
  end

  def show_photo
    id = params[:id] ? params[:id] : 1
    @author = Author.find(id)
    send_data @author.photo, type: @author.ctype, disposition: :inline
  end

  def log
    logger.unknown('unknown')
    logger.fatal('fatal')
    logger.error('error')
    logger.warn('warn')
    logger.info('info')
    logger.debug('debug')
    render text: 'ろぐみてー'
  end

  def get_xml
    @books = Book.all
    render xml: @books
  end

  def get_json
    @books = Book.all
    render json: @books
  end

  def download
    @books = Book.all
  end

  def cookie
    @email = cookies[:email]
  end

  def cookie_rec
    cookies[:email] = { value: params[:email], expires: 3.months.from_now, http_only: true }
    render text: 'くっきーたべたよ'
  end

  def session_show
    @email = session[:email]
  end

  def session_rec
    session[:email] = params[:email]
    render text: 'せっしょんのこしたよー'
  end

  private
  def start_logger
    logger.debug('[Start] ' + Time.now.to_s)
  end

  def end_logger
    logger.debug('[Finish] ' + Time.now.to_s)
  end

  def around_logger
    logger.debug('[Start] ' + Time.now.to_s)
    yield
    logger.debug('[Finish] ' + Time.now.to_s)
  end

  def auth
    name = 'yyamada'
    passwd = '8cb2237d0679ca88db6464eac60da96345513964'
    authenticate_or_request_with_http_basic('Railsbook') do |n, p|
      n == name && Digest::SHA1.hexdigest(p) == passwd
    end
  end
end