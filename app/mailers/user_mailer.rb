class UserMailer < ApplicationMailer
  default from: 'test@gmail.com'

  def create_email(user)
    @user = user
    mail(
      to: 'nagano@samubuc.co.jp',
      subject: 'メールテスト',
      from: '16e0334@gmail.com'
    )
  end
end
