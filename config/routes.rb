Rails.application.routes.draw do
  resources :comments
  resources :posts
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'ajax_index' => 'posts#ajax_index'
  get 'sql_injection' => 'posts#sql_injection'
  root 'posts#index'
end
