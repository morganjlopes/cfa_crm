# Preview all emails at http://localhost:3000/rails/mailers/people_mailer
class PeopleMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/people_mailer/new_message
  def new_message
    PeopleMailer.new_message
  end

end
