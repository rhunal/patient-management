class AppointmentsController < ApplicationController
  before_action :set_appointment, only: [:edit, :update, :destroy]

  def index
    @appointments = current_user.appointments.page(params[:page]).per(10)
  end

  def new
    @appointment = current_user.appointments.new
  end

  def create
    @appointment = current_user.appointments.new(appointment_params)
    @appointment.user = current_user

    if @appointment.save
      redirect_to appointments_path, notice: 'Appointment was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @appointment.update(appointment_params)
      redirect_to appointments_path, notice: 'Appointment was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @appointment.destroy
    redirect_to appointments_path, notice: 'Appointment was successfully deleted.'
  end

  private
  def set_appointment
    @appointment = current_user.appointments.find(params[:id])
  end

  def appointment_params
    params.require(:appointment).permit(:appointment_date, :appointment_time, :patient_id)
  end
end
