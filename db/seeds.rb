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
    :facture_presta_to_null => false,
    :show_reportable => false)

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
    { :name => 'service agricole', :upcategory => facture }, #ne pas modifier
    { :name => 'materiel', :upcategory => facture },
    { :name => 'fermage', :upcategory => facture },
    { :name => 'bricolage', :upcategory => facture },

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

    { :name => 'Paille foin', :upcategory => vente },
    { :name => 'Paille ble', :upcategory => vente },
    { :name => 'Paille colza', :upcategory => vente },
    { :name => 'Assurance', :upcategory => vente },
    { :name => 'PAC', :upcategory => vente },
    { :name => 'Avoir', :upcategory => vente }
  ])

  factcats = Factcat.create!([
    { :name => 'agri'}, 
    { :name => 'maison' }, 
    { :name => 'invest' }
  ])

  ble = Typeculture.create!({:name => "Ble", :code => "ble"})
  bleble = Typeculture.create!({:name => "2eme Ble", :code => "bleble"})
  tournesol = Typeculture.create!({:name => "Tournesol", :code => "tournesol"})
  colza = Typeculture.create!({:name => "Colza", :code => "colza"})
  jachere = Typeculture.create!({:name => "Jachere", :code => "jachere"})
  luzerne = Typeculture.create!({:name => "Luzerne", :code => "luzerne"})
  foin = Typeculture.create!({:name => "Foin", :code => "foin"})
  typeculture = Typeculture.find(:first)

  factypes = Factype.create!([
    {:name => "diff", :display => "diff", :desc => "test desc"},
    {:name => "total", :display => "total", :desc => "test desc"},
    {:name => "null", :display => "null", :desc => "test desc"}])

  users = User.create!([
    # code genere USERS
    {:name => 'Agro-Service', :code => 'agro_service'},
    {:name => 'AIP systems', :code => 'aip_systems'},
    {:name => 'ASTM', :code => 'astm'},
    {:name => 'Aubrun carburants', :code => 'aubrun_carburants'},
    {:name => 'Aucun', :code => 'aucun'},
    {:name => 'Auroy', :code => 'auroy'},
    {:name => 'Aussourd', :code => 'aussourd'},
    {:name => 'Bastard et Fils', :code => 'bastard'},
    {:name => 'Batiloisirs', :code => 'batiloisirs'},
    {:name => 'Beauvais', :code => 'beauvais'},
    {:name => 'Bernard Peres', :code => 'bernard_peres'},
    {:name => 'Bonnin', :code => 'bonnin'},
    {:name => 'Bricodepot', :code => 'bricodepot'},
    {:name => 'Bricomarche', :code => 'bricomarche'},
    {:name => 'Bricopro', :code => 'bricopro'},
    {:name => 'C le Mobile', :code => 'c_le_mobile'},
    {:name => 'CACI36', :code => 'caci36'},
    {:name => 'CBM', :code => 'cbm'},
    {:name => 'Centragri', :code => 'centragri'},
    {:name => 'CGA 36', :code => 'cga36'},
    {:name => 'Chambre Agriculture', :code => 'chambre_agriculture'},
    {:name => 'Charrier', :code => 'charrier'},
    {:name => 'Chirrault', :code => 'chirrault'},
    {:name => 'CMD', :code => 'cmd'},
    {:name => 'Communaute de communes', :code => 'communaute_de_communes'},
    {:name => 'Compta Centre', :code => 'compta_centre'},
    {:name => 'Coutillet', :code => 'coutillet'},
    {:name => 'Credit Agricole Assurances', :code => 'credit_agricole_assurances'},
    {:name => 'Dauger', :code => 'dauger'},
    {:name => 'Daugeron Garage', :code => 'daugeron_garage'},
    {:name => 'DDA', :code => 'dda'},
    {:name => 'Dechansiaud', :code => 'dechansiaud'},
    {:name => 'Demanus', :code => 'demanus'},
    {:name => 'Denormandie Jardinerie', :code => 'denormandie'},
    {:name => 'divers', :code => 'divers'},
    {:name => 'Dumont', :code => 'dumont'},
    {:name => 'EARL Prinet', :code => 'earl_prinet'},
    {:name => 'EBT', :code => 'ebt'},
    {:name => 'EDF bleu ciel', :code => 'edf_bleu_ciel'},
    {:name => 'La France agricole', :code => 'France_agricole'},
    {:name => 'France Telecom', :code => 'France_telecom'},
    {:name => 'Groupama', :code => 'groupama'},
    {:name => 'Isagri', :code => 'isagri'},
    {:name => 'Jamase', :code => 'jamase'},
    {:name => 'Jouve', :code => 'jouve'},
    {:name => 'Kestoloot', :code => 'kesteloot'},
    {:name => 'La Poste', :code => 'la_poste'},
    {:name => 'Lapeyre', :code => 'lapeyre'},
    {:name => 'Lapeyre', :code => 'lapeyre'},
    {:name => 'Medard', :code => 'medard'},
    {:name => 'MF de la Cot', :code => 'mflacot'},
    {:name => 'Moulin', :code => 'moulin'},
    {:name => 'MSA', :code => 'msa'},
    {:name => 'PAC', :code => 'pac'},
    {:name => 'Pierre Auroy Sarl', :code => 'pierre_auroy_sarl'},
    {:name => 'Pneu Europe Service', :code => 'pneu_europe_service'},
    {:name => 'Raffault', :code => 'raffault'},
    {:name => 'Raffault freres', :code => 'raffault_freres'},
    {:name => 'Renaud', :code => 'renaud'},
    {:name => 'Seelec', :code => 'seelec'},
    {:name => 'SIAEP Igneraie', :code => 'siaep'},
    {:name => 'Sodibe', :code => 'sodibe'},
    {:name => 'Sotramat', :code => 'sotramat'},
    {:name => 'Super U', :code => 'super_u'},
    {:name => 'Trochet', :code => 'trochet'}
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
  {:name => 'Bons Pains', :code => 'bruneau', :surface => 14},
  {:name => 'Mitant', :code => 'mitant', :surface => 5},
  {:name => 'La Rue', :code => 'la_rue', :surface => 46.55},

  {:name => 'Basse-cour', :code => 'basse_cour', :surface => 2},
  {:name => 'Vallees', :code => 'valles', :surface => 11},
  {:name => 'Guiberons', :code => 'guiberons', :surface => 2.5},
  {:name => 'La cote', :code => 'la_cote', :surface => 2},
  {:name => 'Feuillets', :code => 'feuillets', :surface => 16},


  {:name => 'Brandes', :code => 'brandes', :surface => 2.97},
  {:name => 'Taillis', :code => 'taillis', :surface => 19.32},
  {:name => 'Varennes', :code => 'varennes', :surface => 15.86},
  {:name => 'Patureaux', :code => 'patureaux', :surface => 8.87},
  {:name => 'Chevaux', :code => 'chevaux', :surface => 13.26},
  {:name => 'Sous Eglise', :code => 'sous_eglise', :surface => 1.35},
  {:name => 'Reserve', :code => 'reserve', :surface => 2.55},
  {:name => 'Lavernier', :code => 'lavernier', :surface => 0.75},
  {:name => 'Le bourg', :code => 'le_bourg', :surface => 0.52},
  
])

