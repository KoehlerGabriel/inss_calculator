require "rails_helper"

RSpec.describe Proponent, type: :model do
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:document) }
  it { should validate_presence_of(:birth_date) }
  it { should validate_presence_of(:salary) }

  describe "associations with dependent destroy" do
    it "destroys associated addresses when proponent is destroyed" do
      proponent = create(:proponent)
      address = create(:address, proponent: proponent)
      
      expect {
        proponent.destroy
      }.to change(Address, :count).by(-1)
    end
    
    it "destroys associated contacts when proponent is destroyed" do
      proponent = create(:proponent)
      contact = create(:contact, proponent: proponent)
      
      expect {
        proponent.destroy
      }.to change(Contact, :count).by(-1)
    end
  end

  describe "callbacks" do
    it "enqueues CalculateInssDiscountJob before saving" do
      proponent = build(:proponent)
      expect {
        proponent.save
      }.to have_enqueued_job(CalculateInssDiscountJob).with(proponent.id)
    end
  end

  describe ".calculate_missing_inss" do
    let!(:proponent_with_inss) { create(:proponent, inss_discount: 100) }
    let!(:proponent_without_inss) { create(:proponent, inss_discount: nil) }

    it "enqueues CalculateInssDiscountJob for proponents with missing inss_discount" do
      expect {
        Proponent.calculate_missing_inss
      }.to have_enqueued_job(CalculateInssDiscountJob).with(proponent_without_inss.id)
    end

    it "does not enqueue job for proponents with inss_discount" do
      expect {
        Proponent.calculate_missing_inss
      }.not_to have_enqueued_job(CalculateInssDiscountJob).with(proponent_with_inss.id)
    end
  end
end
