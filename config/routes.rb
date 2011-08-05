ActionController::Routing::Routes.draw do |map|

  map.resources :verifs, :collection => { :list_labtofactures => :get,
                                          :delete_labtofacture => :any,
                                          :list_putofactures => :get,
                                          :delete_putofacture => :any,
                                          :list_putoproduits => :get,
                                          :delete_putoproduit => :any,
                                          :list_putoparcelles => :get,
                                          :delete_putoparcelle => :any,
                                          :list_labtoparcelles => :get,
                                          :delete_labtoparcelle => :any,
                                          :list_factoparcelles => :get,
                                          :delete_factoparcelle => :any
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

  map.resources :pulves, :collection => { :index => :any,
                                          :export => :any}

  map.resources :parcelles

  map.resources :labtoparcelles

  map.resources :labours

  map.resources :produits

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

  map.resources :categories, :collection => { :test => :any}
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
