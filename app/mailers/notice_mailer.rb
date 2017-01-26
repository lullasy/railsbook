class NoticeMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notice_mailer.sendmail_confirm.subject
  #
  default from: 'saku.71125@gmail.com'

  def sendmail_confirm(user)
    @user = user
    mail(to: user.email, subject: 'ゆーざ登録ありです')
  end
end
