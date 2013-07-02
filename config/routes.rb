ActionController::Routing::Routes.draw do |map|

  map.resource :session
  
  map.resources :ventes, :collection => { 
    :update_adu  => :put,
    :update_star => :put}
  

  map.resources :myusers

  map.resources :settings

  map.resources :saisons, :collection => { 
    :init_serialized => :any}
  
  map.resources :zones

  map.resources :users, :collection => { 
    :index_raw => :any, 
    :test => :any, 
    :analytic => :any}

  map.resources :typecultures, :collection => { 
    :set_cache => :any}

  map.resources :pulves, :collection => { 
    :index => :any,
    :export => :any,
    :import => :any,
    :update_adu => :put,
    :update_star => :put
  }

  map.resources :parcelles, :collection => { 
    :index_raw => :any,
    :index_edit => :get,
    :export     => :get}

  map.resources :labtoparcelles

  map.resources :labours, :collection => {
    :update_adu  => :put,
    :update_star => :put}

  map.resources :produits, :collection => { 
    :index_raw => :any,
    :update_adu  => :put,
    :update_star => :put,
    :export      => :get}
  

  map.resources :factypes

  map.resources :factures, :collection => { 
    :new_debit_to_reportable    => :any,
    :create_debit_to_reportable => :any,
    :index_multiple => :any,
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
    :update_multiple    => :any,
    :export         => :get,
    :export_invest  => :get
    }

  map.resources :categories, :collection => { 
    :export => :any, 
    :index_raw => :any
  }
  map.resources :upcategories do |upcat|
    upcat.resources :categories
  end
  
  map.resources :facdivs
  map.resources :factures do |facture|
    facture.resources :facdivs
  end
    
  map.resources :import, :collection => { 
    :import_pulves   => :get,
    :import_labours  => :get,
    :import_factures => :get,
    :import_produits => :get,
    :import_ventes   => :get,
    :prepare         => :any,
    :test            => :any,
    :store_file      => :any
  }

  map.resources :cr, :collection => { 
    :test   => :get,
  }

  map.resources :diverses,    :as => :factures, :controller => :factures
  map.resources :debits,      :as => :factures, :controller => :factures    
  map.resources :reports,     :as => :factures, :controller => :factures
  map.resources :reportables, :as => :factures, :controller => :factures
  map.resources :invests,     :as => :factures, :controller => :factures

  map.resources :verifs, :collection => { 
    :list_labtofactures   => :get,
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

  map.root :factures

  map.connect ':controller/:action/'
  
  map.connect 'users/analytic/:id', :controller	=>	"users", :action => "analytic"

  map.connect "/:controller/:action/:id.:format", :id => nil, :format => nil

end
