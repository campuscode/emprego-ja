class JobPosition < ActiveRecord::Base
  belongs_to :company
  has_many :visits
  validates_presence_of :title, :description, :location, :expiration_date, :job_status
  validates_length_of :title, maximum: 100
  validates :job_status, inclusion: { in: %w(Ativa Desativada Cancelada)}

  def max_expiration
    if created_at == nil
      Date.today + 90
    else
      created_at + 90.days
    end
  end

  def canceled?
    job_status == "Cancelada"
  end

	def new_job_position? 
		created_at >= Date.today - 7
	end

  def last_expiration_days?
    expiration_date < Date.today + 7 &&  expiration_date >= Date.today
  end
end
