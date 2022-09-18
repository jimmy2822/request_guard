Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  namespace 'api' do
    get 'hello'

    resources :issues do
      member do
        post :agree
        post :disagree
      end
    end
  end
end
