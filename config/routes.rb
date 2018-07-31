Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'ratios', to: 'ratios#index'
  get 'avg_day_ratios', to: 'avg_day_ratios#index'
end
