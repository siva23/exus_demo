class ExusmedMailer < ActionMailer::Base
  default from: "sandbox99335.mailgun.org"
  
  def user_entry_notification(record, pwd)
    @email = record
    @pwd = pwd
    mail to: "#{@email}", subject: "Exusmed Profile created!"
  end

  def invite_provider(email, fname)
  	@fname = fname
  	mail to:"#{email}", subject: "Exusmed invitation"
  end
end
