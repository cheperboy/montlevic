# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
SEEDS_BASIC = true # do not set to false
SAISON_2010_2011 = false
SAISON_2009_2010 = false

#===== SEEDS_BASIC ========
if SEEDS_BASIC
  setting = Setting.create!(
    :saison_id => 1, 
    :float_precision => 0, 
    :value_parcelle => false, 
    :detail_desc => false, 
    :detail_ref => false,
    :text_area_size => '25x6',
    :facture_diff_to_null => false,
    :facture_presta_to_null => false)

  upcategories = Upcategory.create!([
    { :name => 'facture'}, 
    { :name => 'pulve' }, 
    { :name => 'labour' },
    { :name => 'vente' }
  ])

  pulve = Upcategory.find_by_name('pulve')
  facture = Upcategory.find_by_name('facture')
  labour = Upcategory.find_by_name('labour')
  vente = Upcategory.find_by_name('vente')
  diverse = Upcategory.find_by_name('diverse')

  categories = Category.create!([
    { :name => 'frais generaux', :upcategory => facture}, 
    { :name => 'produits phyto', :upcategory => facture}, 
    { :name => 'semences', :upcategory => facture}, 
    { :name => 'mecanique', :upcategory => facture}, 
    { :name => 'batiments', :upcategory => facture}, 
    { :name => 'deplacement', :upcategory => facture}, 
    { :name => 'frais de gestion', :upcategory => facture },
    { :name => 'service agricole', :upcategory => facture },

    { :name => 'divers', :upcategory => pulve },
    { :name => 'azote', :upcategory => pulve },
    { :name => 'desherbant', :upcategory => pulve },
    { :name => 'engrais', :upcategory => pulve },
    { :name => 'fongicide', :upcategory => pulve },
    { :name => 'herbicide', :upcategory => pulve },
    { :name => 'insecticide', :upcategory => pulve },
    { :name => 'oligo', :upcategory => pulve },
    { :name => 'semis', :upcategory => pulve },
    { :name => 'soufre', :upcategory => pulve },

    { :name => 'moisson', :upcategory => labour },
    { :name => 'covercrop', :upcategory => labour },
    { :name => 'vibro', :upcategory => labour },
    { :name => 'herse', :upcategory => labour },

    { :name => 'foin', :upcategory => vente },
    { :name => 'PAC', :upcategory => vente },
    { :name => 'Avoir', :upcategory => vente }
  ])

  factcats = Factcat.create!([
    { :name => 'agri'}, 
    { :name => 'maison' }, 
    { :name => 'invest' }
  ])

  ble = Typeculture.create!({:name => "Ble"})
  bleble = Typeculture.create!({:name => "2eme Ble"})
  tournesol = Typeculture.create!({:name => "Tournesol"})
  colza = Typeculture.create!({:name => "Colza"})
  jachere = Typeculture.create!({:name => "Jachere"})
  luzerne = Typeculture.create!({:name => "Luzerne"})
  typeculture = Typeculture.find(:first)

  factypes = Factype.create!([
    {:name => "diff", :display => "diff", :desc => "test desc"},
    {:name => "total", :display => "total", :desc => "test desc"},
    {:name => "null", :display => "null", :desc => "test desc"}])

  users = User.create!([
    {:name => "Jouve"},
    {:name => "Trochet"},
    {:name => "Dauger"},
    {:name => "Raffault"},
    {:name => "C le Mobile"},
    {:name => "Credit Agricole Assurances"},
    {:name => "Bastard"},
    {:name => "Daugeron Garage"},
    {:name => "Communaute de communes"},
    {:name => "SIAEP de l'Igneraie"},
    {:name => "France Telecom"},
    {:name => "Dechansiaud"},
    {:name => "Renaud"},
    {:name => "EDF"},
    {:name => "Compta Centre"},
    {:name => "Pneu Europe Service"},
    {:name => "Sodibe"},
    {:name => "Lapeyre"},
    {:name => "Seelec"},
    {:name => "Denormandie Jardinerie"},
    {:name => "MSA"},
    {:name => "Agro-Service"},
    {:name => "CBM"},
    {:name => "Super U"},
    {:name => "DDA"},
    {:name => "PAC"},
    {:name => "Charrier"},
    {:name => "La Poste"},
    {:name => "Brico Depot"},
    {:name => "divers"},
    {:name => "Auroy"},
    {:name => "Bernard Peres"},
    {:name => "Bricomarche"},
    {:name => "Aucun"}
  ])
  trochet = User.find_by_name('Trochet')

  myuser = Myuser.create!([
    {:login => "admin",     :password => "admin",     :admin => true},
    {:login => "matthieu",  :password => "",          :admin => false},
    {:login => "elisabeth", :password => "elisabeth", :admin => false},
    {:login => "thierry",   :password => "thierry",   :admin => false}
  ])

end # if SEEDS_BASIC

zones = Zone.create!([
  {:name => "Bruneau",          :surface => 14},    #/1/
  {:name => "Mitant",           :surface => 5},     #/2/     
  {:name => "La Rue",           :surface => 46.55}, #/3/
  {:name => "Basse-cour",       :surface => 2},     #/4/
  {:name => "Vallees",          :surface => 11},    #/5/

  {:name => "Guiberons",        :surface => 2.5},   #/6/
  {:name => "La cote",          :surface => 2},     #/7/
  {:name => "Feuillets",        :surface => 16},    #/8/
  {:name => "Brandes",          :surface => 2.97},  #/9/
  {:name => "Taillis",          :surface => 19.32}, #/10/
  {:name => "Varennes",         :surface => 15.86}, #/11/
  {:name => "Patureaux",        :surface => 8.87},  #/12/
  {:name => "Prairie Chevaux",  :surface => 13.26}, #/13/
  {:name => "Sous l'eglise",    :surface => 1.35},  #/14/

  {:name => "Reserve",          :surface => 2.55},  #/15/
  {:name => "Lavernier",        :surface => 0.75},  #/16/
  {:name => "Le Bourg-1",       :surface => 0.52},   #/17/
  {:name => "zoneA",            :surface => 10},     # a supprimer
  {:name => "zoneB",            :surface => 100},    # a supprimer
  {:name => "zoneC",            :surface => 200}    # a supprimer
])

