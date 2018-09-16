Rails.application.routes.draw do
  resources :animals
  get "/api/taxonomy" => "animals#taxonomy"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
