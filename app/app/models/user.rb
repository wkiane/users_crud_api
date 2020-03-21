# frozen_string_literal: true

class User < ActiveRecord::Base
  include Discard::Model
  extend Devise::Models
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  include DeviseTokenAuth::Concerns::User


  def active_for_authentication?  
    super && !discarded_at  
  end

  validates :first_name, :last_name, presence: true
end

