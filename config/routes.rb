ActionController::Routing::Routes.draw do |map|
  map.resources :verifs, :collection => { :list_labtofactures => :get,
                                          :delete_labtofacture => :any
  }

  map.resource :session
  
  map.resources :ventes

  map.resources :myusers

  map.resources :settings

  map.resources :saisons
  
  map.resources :zones

  map.resources :users

  map.resources :typecultures

  map.resources :saisons

  map.resources :pulves

  map.resources :parcelles

  map.resources :labtoparcelles

  map.resources :labours

  map.resources :factypes

  map.resources :factures, :collection => { :reports => :get,
                                            :new_report => :get,
                                            :create_report => :post,
                                            :new_debit_to_reportable => :any,
                                            :create_debit_to_reportable => :any,
                                            :new_diverse => :get,
                                            :create_diverse => :post,
                                            :index_types => :get,
                                            :edit_facdiv => :get,
                                            :diverses => :get,
                                            :modif => :any }

  map.resources :categories
  map.resources :upcategories do |upcat|
    upcat.resources :categories
  end
  
  map.resources :facdivs
  map.resources :factures do |facture|
    facture.resources :facdivs
  end
    
  map.resources :diverses,    :as => :factures, :controller => :factures
  map.resources :debits,      :as => :factures, :controller => :factures    
  map.resources :reports,     :as => :factures, :controller => :factures
  map.resources :reportables, :as => :factures, :controller => :factures

  map.root :factures

  map.connect ':controller/:action/'

end
