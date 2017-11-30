Rails.application.routes.draw do
  resources :images do
    collection do
      post :search
    end
  end

  resources :tags
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
