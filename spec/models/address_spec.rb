# spec/models/address_spec.rb
require "rails_helper"

RSpec.describe Address, type: :model do
  it { should validate_presence_of(:street) }
  it { should validate_presence_of(:number) }
  it { should validate_presence_of(:neighborhood) }
  it { should validate_presence_of(:city) }
  it { should validate_presence_of(:state) }
  it { should validate_presence_of(:zip_code) }

  context "with valid attributes" do
    let(:proponent) { create(:proponent) }
    let(:address) do
      build(:address, proponent: proponent, street: "Main St", number: "123", neighborhood: "Downtown", city: "Cityville", state: "State", zip_code: "12345")
    end

    it "is valid with valid attributes" do
      expect(address).to be_valid
    end
  end

  context "with missing attributes" do
    let(:address) { build(:address) }

    it "is invalid without a street" do
      address.street = nil
      expect(address).to_not be_valid
    end

    it "is invalid without a number" do
      address.number = nil
      expect(address).to_not be_valid
    end

    it "is invalid without a neighborhood" do
      address.neighborhood = nil
      expect(address).to_not be_valid
    end

    it "is invalid without a city" do
      address.city = nil
      expect(address).to_not be_valid
    end

    it "is invalid without a state" do
      address.state = nil
      expect(address).to_not be_valid
    end

    it "is invalid without a zip_code" do
      address.zip_code = nil
      expect(address).to_not be_valid
    end
  end
end
