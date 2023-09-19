# frozen_string_literal: true

# == Schema Information
#
# Table name: customers
#
#  id                     :bigint           not null, primary key
#  birthday               :date
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  first_name             :string(255)
#  last_name              :string(255)
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string(255)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_customers_on_email                 (email) UNIQUE
#  index_customers_on_reset_password_token  (reset_password_token) UNIQUE
#
class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  attr_accessor :birthday

  def self.fullname
    "#{first_name} #{last_name}"
  end

  scope :search, ->(fullname) { where("CONCAT(first_name, ' ', last_name) LIKE ?", "%#{fullname}%") }
end
