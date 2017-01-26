class ExtraController < ApplicationController
  def sendmail
    user = User.find(6)
    @mail = NoticeMailer.sendmail_confirm(user).deliver
    render text: 'めーるおくたよ'
  end
end
