class SeoMailer < ApplicationMailer
#   def compose_mail(user)
#     @user = user
#     mail(to: @user.email, subject: 'Sample Email')
#
#     #recipients      recipient.email_address_with_name
#     #subject         "New account information"
#     #from            "system@example.com"
#     #content_type    "multipart/alternative"
#
#     part "text/plain" do |p|
#       p.body = render_message("email_plain", :message => "text content")
#     end
#
#     attachment "seo/download_pdf" do |a|
#       a.body = generate_your_pdf_here()
#     end
#
#     attachment "seo/download.xlsx/axlsx" do |a|
#       a.body = generate_your_excel_here()
#     end
#   end
# end

default :from => "Awesome App <support@example.com>",
        :content_type => 'multipart/alternative',
        :parts_order => [ "text/html",  "text/plain", "application/pdf", "application/xlsx" ]

def pdf_email(email, subject, pdfname, pdfpath)
  attachments[pdfname] = File.read(seo/download_pdf)
  mail(:to => email, :subject => subject)
end

def excel_email(email, subject, excelname, excelpath)
  attachments[excelname] = File.read(seo/download.xlsx.axlsx)
  mail(:to => email, :subject => subject)
end
end
