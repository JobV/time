class Client < ActiveRecord::Base
  has_many :projects
  has_many :timers, through: :projects
  has_and_belongs_to_many :users

  validates :company_name, presence: true
  
  # totale waarde van onderhanden werk voor deze klant
  def total_uninvoiced
  end

  # totale waarde van gefactureerd werk
  def invoiced
  end

  # totale waarde van betaald werk
  def paid
  end
end
