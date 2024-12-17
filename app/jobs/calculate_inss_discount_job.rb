class CalculateInssDiscountJob < ApplicationJob
  queue_as :default

  def perform(proponent_id)
    proponent = Proponent.find_by(id: proponent_id)
    return if proponent.nil? || proponent.salary.nil?

    inss_discount = calculate_inss(proponent.salary)

    proponent.update_column(:inss_discount, inss_discount)
  end

  private

  def calculate_inss(salary)
    return 0 if salary <= 0

    inss = 0

    if salary <= 1412.00
      inss = salary * 0.075
    elsif salary <= 2666.68
      inss = 1412.00 * 0.075 + (salary - 1412.00) * 0.09
    elsif salary <= 4000.03
      inss = 1412.00 * 0.075 + (2666.68 - 1412.00) * 0.09 + (salary - 2666.68) * 0.12
    elsif salary <= 7786.02
      inss = 1412.00 * 0.075 + (2666.68 - 1412.00) * 0.09 + (4000.03 - 2666.68) * 0.12 + (salary - 4000.03) * 0.14
    else
      inss = 1412.00 * 0.075 + (2666.68 - 1412.00) * 0.09 + (4000.03 - 2666.68) * 0.12 + (7786.02 - 4000.03) * 0.14
    end

    inss.round(2)
  end
end
