class Notifier < ActionMailer::Base
  default :from => "bntu.edu.by"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notifier.email_student.subject
  #
  def email_student(student,loans)
    @user = student
  	@loans = loans  	

    mail :to => student.email, :subject => "BNTU - Book delivery reminder"
  end
end
