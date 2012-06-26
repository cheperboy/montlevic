ActionController::Routing::Routes.draw do |map|

  map.resources :verifs, :collection => { :list_labtofactures => :get,
                                          :delete_labtofacture  => :any,
                                          :list_putofactures    => :get,
                                          :delete_putofacture   => :any,
                                          :list_protofactures   => :get,
                                          :delete_protofacture  => :any,
                                          :list_putoproduits    => :get,
                                          :delete_putoproduit   => :any,
                                          :list_putoparcelles   => :get,
                                          :delete_putoparcelle  => :any,
                                          :list_labtoparcelles  => :get,
                                          :delete_labtoparcelle => :any,
                                          :list_factoparcelles  => :get,
                                          :delete_factoparcelle => :any,
                                          :factures             => :get
  }

  map.resource :session
  
  map.resources :ventes, :collection => { :update_adu => :put,
                                            :update_star => :put}
  

  map.resources :myusers

  map.resources :settings

  map.resources :saisons
  
  map.resources :zones

  map.resources :users, :collection => { :test => :any}

  map.resources :typecultures

  map.resources :saisons

  map.resources :pulves, :collection => { 
    :index => :any,
    :export => :any,
    :import => :any,
    :update_adu => :put,
    :update_star => :put
  }

  map.resources :parcelles, :collection => { :index_edit => :get}

  map.resources :labtoparcelles

  map.resources :labours, :collection => {:update_adu => :put,
                                          :update_star => :put}

  map.resources :produits, :collection => { :update_adu => :put,
                                            :update_star => :put,
                                            :export => :any}
  

  map.resources :factypes

  map.resources :factures, :collection => { 
    :new_debit_to_reportable    => :any,
    :create_debit_to_reportable => :any,
    :reports        => :get,
    :new_report     => :get,
    :create_report  => :post,
    :new_diverse    => :get,
    :create_diverse => :post,
    :index_types    => :get,
    :index_paye     => :get,
    :edit_facdiv    => :get,
    :diverses       => :get,
    :modif          => :any,
    :update_adu     => :put,
    :update_star    => :put,
    :export         => :get
    }

  map.resources :categories, :collection => { :test => :any}
  map.resources :upcategories do |upcat|
    upcat.resources :categories
  end
  
  map.resources :facdivs
  map.resources :factures do |facture|
    facture.resources :facdivs
  end
    
  map.resources :import, :collection => { 
    :import_pulves   => :get,
    :import_factures => :get,
    :import_produits => :get,
    :prepare         => :any,
    :store_file      => :any
  }

  map.resources :cr, :collection => { 
    :test   => :get,
  }

  map.resources :diverses,    :as => :factures, :controller => :factures
  map.resources :debits,      :as => :factures, :controller => :factures    
  map.resources :reports,     :as => :factures, :controller => :factures
  map.resources :reportables, :as => :factures, :controller => :factures

  map.root :factures

  map.connect ':controller/:action/'

end
