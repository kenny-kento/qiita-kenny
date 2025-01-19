# frozen_string_literal: true

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :validatable
  include DeviseTokenAuth::Concerns::User
  
  # NOTE: モデルの関係性についてはここにまとめる
  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_one_attached :icon

  # NOTE: enumはここにまとめる
  enum status: { inactive: 0, active: 1 }

  # def icon_url
  #   icon.attached? ? Rails.application.routes.url_helpers.rails_blob_url(icon, only_path: true) : nil
  # end
end
