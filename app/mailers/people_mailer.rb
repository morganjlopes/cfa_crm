class PeopleMailer < ActionMailer::Base
  default from: "from@example.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.people_mailer.new_message.subject
  #
  def new_message(message, person, from)
    @greeting = "Hi"
    @message  = message
    @person   = person
    
    mail to: @person.email, subject: @message.subject, from: from.email
  end
end
