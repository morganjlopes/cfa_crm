Rails.application.routes.draw do

  devise_for :users

  constraints(lambda { |request| request.subdomain.empty? or request.subdomain == 'www' }) do
    resources :communities,
              :only => [:index, :new, :create]

    root 'pages#home'
  end

  # *.inspiredcauses.com => Campaign Subdomains
  constraints(lambda { |request| request.subdomain != 'www' }) do
    resources :people do
      resources :notes,
                :except => [:update, :edit]
    end

    resources :companies do
      resources :notes,
                :except => [:update, :edit]
    end

    resources :messages,
              :except => [:edit, :update, :destroy]

    resources :digital_addresses,
              :only => [:destroy]

    resources :communities,
              :only => [:show, :update]

    get '/edit', to: 'communities#edit', as: :owner_edit_community
    root :to => "communities#show", as: :community_home
  end
end
