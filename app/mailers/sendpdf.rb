class Sendpdf<ActionMailer::Base
  default :from => "myemail@email.com"

  def send_brief(brief, user)
    @user = user
    filename = "brief_#{@brief.name.parameterize(sep = '_')}_#{Time.now.strftime('%Y%m%d')}.pdf"
    attachments[filename] = BriefPdf.new(@brief, @user).render
    mail(to: @user.email,
         cc: @brief.email,
         subject: "New brief from #{@brief.name}")
  end
end

