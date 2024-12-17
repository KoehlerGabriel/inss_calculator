# spec/models/contact_spec.rb
require "rails_helper"

RSpec.describe Contact, type: :model do
  it { should validate_presence_of(:contact_type) }
  it { should validate_presence_of(:value) }

  context "with valid attributes" do
    let(:proponent) { create(:proponent) }
    let(:contact) do
      build(:contact, proponent: proponent, contact_type: "email", value: "example@example.com")
    end

    it "is valid with valid attributes" do
      expect(contact).to be_valid
    end
  end

  context "with missing attributes" do
    let(:contact) { build(:contact) }

    it "is invalid without a contact_type" do
      contact.contact_type = nil
      expect(contact).to_not be_valid
    end

    it "is invalid without a value" do
      contact.value = nil
      expect(contact).to_not be_valid
    end
  end
end
