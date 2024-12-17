require "rails_helper"

RSpec.describe CalculateInssDiscountJob, type: :job do
  describe "#perform" do
    it "calculates and updates the INSS discount for the proponent in tier 1" do
      proponent = create(:proponent, salary: 1000.00)

      expect {
        CalculateInssDiscountJob.perform_later(proponent.id)
      }.to have_enqueued_job.with(proponent.id)

      perform_enqueued_jobs do
        CalculateInssDiscountJob.perform_later(proponent.id)
      end

      proponent.reload
      expected_inss = (1000.00 * 0.075).round(2)
      expect(proponent.inss_discount).to eq(expected_inss)
    end

    it "calculates and updates the INSS discount for the proponent in tier 2" do
      proponent = create(:proponent, salary: 2000.00)

      expect {
        CalculateInssDiscountJob.perform_later(proponent.id)
      }.to have_enqueued_job.with(proponent.id)

      perform_enqueued_jobs do
        CalculateInssDiscountJob.perform_later(proponent.id)
      end

      proponent.reload
      expected_inss = (1412.00 * 0.075 + (proponent.salary - 1412.00) * 0.09).round(2)
      expect(proponent.inss_discount).to eq(expected_inss)
    end

    it "calculates and updates the INSS discount for the proponent in tier 3" do
      proponent = create(:proponent, salary: 3500.00)

      expect {
        CalculateInssDiscountJob.perform_later(proponent.id)
      }.to have_enqueued_job.with(proponent.id)

      perform_enqueued_jobs do
        CalculateInssDiscountJob.perform_later(proponent.id)
      end

      proponent.reload
      expected_inss = (1412.00 * 0.075 + (2666.68 - 1412.00) * 0.09 + (proponent.salary - 2666.68) * 0.12).round(2)
      expect(proponent.inss_discount).to eq(expected_inss)
    end

    it "calculates and updates the INSS discount for the proponent in tier 4" do
      proponent = create(:proponent, salary: 5000.00)

      expect {
        CalculateInssDiscountJob.perform_later(proponent.id)
      }.to have_enqueued_job.with(proponent.id)

      perform_enqueued_jobs do
        CalculateInssDiscountJob.perform_later(proponent.id)
      end

      proponent.reload
      expected_inss = (1412.00 * 0.075 + (2666.68 - 1412.00) * 0.09 + (4000.03 - 2666.68) * 0.12 + (proponent.salary - 4000.03) * 0.14).round(2)
      expect(proponent.inss_discount).to eq(expected_inss)
    end

    it "calculates and updates the INSS discount for the proponent in tier 5" do
      proponent = create(:proponent, salary: 8000.00)

      expect {
        CalculateInssDiscountJob.perform_later(proponent.id)
      }.to have_enqueued_job.with(proponent.id)

      perform_enqueued_jobs do
        CalculateInssDiscountJob.perform_later(proponent.id)
      end

      proponent.reload
      expected_inss = (1412.00 * 0.075 + (2666.68 - 1412.00) * 0.09 + (4000.03 - 2666.68) * 0.12 + (7786.02 - 4000.03) * 0.14).round(2)
      expect(proponent.inss_discount).to eq(expected_inss)
    end
  end
end
