require "rails_helper"

RSpec.describe ProponentsController, type: :controller do
  include Devise::Test::ControllerHelpers

  let!(:user) { create(:user) }
  let!(:proponent) { create(:proponent) }

  before { sign_in user }

  describe "GET #index" do
    it "renders the index template" do
      get :index
      expect(response).to render_template(:index)
    end
  end

  describe "POST #calculate_missing_inss" do
    it "calculates the missing INSS for proponents" do
      allow(Proponent).to receive(:calculate_missing_inss).and_return(true)

      post :calculate_missing_inss

      expect(Proponent).to have_received(:calculate_missing_inss)
      expect(response).to redirect_to(proponents_path)
      expect(flash[:notice]).to eq("Cálculo de INSS iniciado para registros faltantes!")
    end
  end

  describe "GET #show" do
    it "assigns the requested proponent to @proponent" do
      get :show, params: { id: proponent.id }
      expect(assigns(:proponent)).to eq(proponent)
    end

    it "renders the show template" do
      get :show, params: { id: proponent.id }
      expect(response).to render_template(:show)
    end
  end

  describe "GET #new" do
    it "assigns a new proponent to @proponent" do
      get :new
      expect(assigns(:proponent)).to be_a_new(Proponent)
    end

    it "renders the new template" do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe "GET #edit" do
    it "assigns the requested proponent to @proponent" do
      get :edit, params: { id: proponent.id }
      expect(assigns(:proponent)).to eq(proponent)
    end

    it "renders the edit template" do
      get :edit, params: { id: proponent.id }
      expect(response).to render_template(:edit)
    end
  end

  describe "POST #create" do
    context "with valid attributes" do
      it "creates a new proponent" do
        expect {
          post :create, params: { proponent: { name: "John Doe", document: "123456789", birth_date: "1990-01-01", salary: 3000 } }
        }.to change(Proponent, :count).by(1)
      end

      it "redirects to the show page with a success notice" do
        post :create, params: { proponent: { name: "John Doe", document: "123456789", birth_date: "1990-01-01", salary: 3000 } }
        expect(response).to redirect_to(proponent_url(assigns(:proponent)))
        expect(flash[:notice]).to eq("Proponent was successfully created.")
      end
    end

    context "with invalid attributes" do
      it "does not create a new proponent" do
        expect {
          post :create, params: { proponent: { name: "", document: "", birth_date: "", salary: nil } }
        }.not_to change(Proponent, :count)
      end

      it "renders the new template with an error message" do
        post :create, params: { proponent: { name: "", document: "", birth_date: "", salary: nil } }
        expect(response).to render_template(:new)
      end
    end
  end

  describe "PATCH #update" do
    context "with valid attributes" do
      it "updates the proponent" do
        patch :update, params: { id: proponent.id, proponent: { name: "Jane Doe" } }
        proponent.reload
        expect(proponent.name).to eq("Jane Doe")
      end

      it "redirects to the show page with a success notice" do
        patch :update, params: { id: proponent.id, proponent: { name: "Jane Doe" } }
        expect(response).to redirect_to(proponent_url(proponent))
        expect(flash[:notice]).to eq("Proponent was successfully updated.")
      end
    end

    context "with invalid attributes" do
      it "does not update the proponent" do
        patch :update, params: { id: proponent.id, proponent: { name: "" } }
        proponent.reload
        expect(proponent.name).not_to eq("")
      end

      it "renders the edit template with an error message" do
        patch :update, params: { id: proponent.id, proponent: { name: "" } }
        expect(response).to render_template(:edit)
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the proponent" do
      proponent_to_destroy = create(:proponent)
      expect {
        delete :destroy, params: { id: proponent_to_destroy.id }
      }.to change(Proponent, :count).by(-1)
    end

    it "redirects to the index page with a success notice" do
      proponent_to_destroy = create(:proponent)
      delete :destroy, params: { id: proponent_to_destroy.id }
      expect(response).to redirect_to(proponents_url)
      expect(flash[:notice]).to eq("Proponent was successfully destroyed.")
    end
  end
end
