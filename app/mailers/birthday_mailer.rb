# frozen_string_literal: true

class BirthdayMailer < ApplicationMailer
  def birthday_email(student)
    @student = student

    mail to: student.email, subject: 'Chúc mừng sinh nhật!'
  end
end
