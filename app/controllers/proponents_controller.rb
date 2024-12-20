class ProponentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_proponent, only: %i[show edit update destroy]

  def index
    @proponents = Proponent.page(params[:page]).per(5)
  end

  def calculate_missing_inss
    Proponent.calculate_missing_inss

    redirect_to proponents_path, notice: "Cálculo de INSS iniciado para registros faltantes!"
  end

  def show
  end

  def new
    @proponent = Proponent.new
  end

  def edit
  end

  def create
    @proponent = Proponent.new(proponent_params)

    respond_to do |format|
      if @proponent.save
        format.html { redirect_to proponent_url(@proponent), notice: "Proponent was successfully created." }
        format.json { render :show, status: :created, location: @proponent }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @proponent.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @proponent.update(proponent_params)
        format.html { redirect_to proponent_url(@proponent), notice: "Proponent was successfully updated." }
        format.json { render :show, status: :ok, location: @proponent }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @proponent.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @proponent.destroy

    respond_to do |format|
      format.html { redirect_to proponents_url, notice: "Proponent was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    def set_proponent
      @proponent = Proponent.find(params[:id])
    end

    def proponent_params
      params.require(:proponent)
            .permit(
              :name, :document, :birth_date, :salary,
              addresses_attributes: [:id, :street, :number, :neighborhood, :city, :state, :zip_code, :_destroy],
              contacts_attributes: [:id, :contact_type, :value, :_destroy]
            )
    end
end
