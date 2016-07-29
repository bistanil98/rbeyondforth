class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.password_reset.subject
  #
  def password_reset(user)
    @user = user
    mail :to => @user.email, :subject => "Password Reset"
  end

  # def compose_mail(user)
  #   @user = user
  #   mail(to: @user.email, subject: 'Sample Email')
  #
  #   #recipients      recipient.email_address_with_name
  #   #subject         "New account information"
  #   #from            "system@example.com"
  #   #content_type    "multipart/alternative"
  #
  #   part "text/plain" do |p|
  #     p.body = render_message("email_plain", :message => "text content")
  #   end
  #
  #   attachment "seo/download_pdf" do |a|
  #     a.body = generate_your_pdf_here()
  #   end
  #
  #   attachment "seo/download.xlsx/axlsx" do |a|
  #     a.body = generate_your_excel_here()
  #   end
  # end

end
