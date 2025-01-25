# frozen_string_literal: true

class PatientsController < ApplicationController
  before_action :set_patient, only: %i[show edit update]

  def index
    # Filter by "soon" patients with upcoming appointments
    @patients = params[:soon] ? Patient.soon(current_user.upcoming_business_days) : Patient.all

    # Search by name or email (case-insensitive)
    @patients = @patients.search(params[:search]) if params[:search].present?
  
    # Apply pagination
    @patients = @patients.page(params[:page]).per(5)
  end

  def show
    @appointments = @patient.appointments.where(user_id: current_user.id)
  end  

  def new
    @patient = Patient.new
  end

  def create
    @patient = Patient.new(patient_params)

    if @patient.save
      @patient.set_next_appointment(patient_params[:next_appointment], current_user.id)
      redirect_to patients_path, notice: 'Patient was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @patient.update(patient_params)
      @patient.set_next_appointment(patient_params[:next_appointment], current_user.id)
      redirect_to edit_patient_path(@patient), notice: 'Patient was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def patient_params
    params.require(:patient).permit(:first_name, :last_name, :email, :next_appointment)
  end

  def set_patient
    @patient = Patient.find(params[:id])
  end
end
