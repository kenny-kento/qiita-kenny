# frozen_string_literal: true

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :validatable
  include DeviseTokenAuth::Concerns::User
  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_one_attached :icon
  enum status: { inactive: 0, active: 1 }
end
