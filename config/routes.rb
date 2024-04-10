Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :text_generators, only: [:create]
    end
  end
end
