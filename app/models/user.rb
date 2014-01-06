class User < ActiveRecord::Base
  has_many :activities
  has_many :timers
  has_and_belongs_to_many :projects
  has_and_belongs_to_many :clients, -> { uniq }

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
