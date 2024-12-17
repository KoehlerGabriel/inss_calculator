class Proponent < ApplicationRecord
  has_many :addresses, dependent: :destroy
  has_many :contacts, dependent: :destroy
  
  accepts_nested_attributes_for :addresses, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :contacts, reject_if: :all_blank, allow_destroy: true
  
  before_save :enqueue_inss_job

  validates :name, :document, :birth_date, :salary, presence: true

  private

  def self.calculate_missing_inss
    where(inss_discount: nil).find_each do |proponent|
      CalculateInssDiscountJob.perform_later(proponent.id)
    end
  end

  def enqueue_inss_job
    CalculateInssDiscountJob.perform_later(self.id)
  end
end
