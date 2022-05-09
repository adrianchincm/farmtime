# frozen_string_literal: true
require 'sidekiq/web'

Rails.application.routes.draw do
  # get 'home/index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  get 'portfolio/:name', to: 'portfolio#show'
  get 'portfolio/:name/pool/:pool_id/active', to: 'pool_details#active'
  get 'portfolio/:name/pool/:pool_id', to: 'pool_details#show'  
  mount Sidekiq::Web => "/sidekiq"
  root 'home#index'
end
