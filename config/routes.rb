# frozen_string_literal: true

Rails.application.routes.draw do
  resources :appointments
  resources :patients
  devise_for :users

  root to: 'patients#index'
end
