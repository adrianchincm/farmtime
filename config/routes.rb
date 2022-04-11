# frozen_string_literal: true

Rails.application.routes.draw do
  # get 'home/index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  get 'portfolio/:name', to: 'portfolio#show'
  get 'portfolio/:portfolio_name/pool/:pool_id', to: 'pool_details#show'
  root 'home#index'
end
