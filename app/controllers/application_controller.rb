class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.

  # protect_from_forgery : http://blog.willnet.in/entry/20080509/1210338845
  protect_from_forgery with: :exception
  before_action :check_logined
  rescue_from ActiveRecord::RecordNotFound, with: :id_invalid

  add_flash_types :info

  private
  def check_logined
    if session[:usr] then
      begin
        @usr = User.find(session[:usr])
      rescue ActiveRecord::RecordNotFound
        reset_session
      end
    end

    unless @usr
      # ログイン成功したときにもともと要求したページにリダイレクトするのでrefererに渡している
      # request fullpath はいまのページのフルURL
      flash[:referer] = request.fullpath
      redirect_to controller: :login, action: :index
    end
  end

  def id_invalid(e)
    render 'shared/record_not_found', status: 404
  end
end
