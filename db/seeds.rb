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

#Factcats
factcat_agri = Factcat.create!({ :code => 'agri', :name => 'Agricole'}) 
factcat_maison = Factcat.create!({ :code => 'maison', :name => 'Maison'}) 
factcat_invest = Factcat.create!({ :code => 'invest', :name => 'Investissement'}) 

#Upcaegories
upcategory_facture = Upcategory.create!({ :name => 'facture'})
upcategory_pulve = Upcategory.create!({ :name => 'pulve'})
upcategory_labour = Upcategory.create!({ :name => 'labour'})
upcategory_vente = Upcategory.create!({ :name => 'vente'})

# generation auto Categories
cat_agri_produits_phyto = Category.create!({:factcat => factcat_agri, :upcategory => upcategory_facture, :name => 'produits phyto', :code => 'produits_phyto'})
cat_agri_mecanique = Category.create!({:factcat => factcat_agri, :upcategory => upcategory_facture, :name => 'mecanique', :code => 'mecanique'})
cat_agri_batiment = Category.create!({:factcat => factcat_agri, :upcategory => upcategory_facture, :name => 'batiment', :code => 'batiment'})
cat_agri_service_agricole = Category.create!({:factcat => factcat_agri, :upcategory => upcategory_facture, :name => 'service agricole', :code => 'service_agricole'})
cat_agri_services_divers = Category.create!({:factcat => factcat_agri, :upcategory => upcategory_facture, :name => 'services divers', :code => 'services_divers'})
cat_agri_comptabilite = Category.create!({:factcat => factcat_agri, :upcategory => upcategory_facture, :name => 'comptabilite', :code => 'comptabilite'})
cat_agri_assurance = Category.create!({:factcat => factcat_agri, :upcategory => upcategory_facture, :name => 'assurance', :code => 'assurance'})
cat_agri_frais_generaux = Category.create!({:factcat => factcat_agri, :upcategory => upcategory_facture, :name => 'frais generaux', :code => 'frais_generaux'})
cat_agri_materiel = Category.create!({:factcat => factcat_agri, :upcategory => upcategory_facture, :name => 'materiel', :code => 'materiel'})
cat_agri_fermage = Category.create!({:factcat => factcat_agri, :upcategory => upcategory_facture, :name => 'fermage', :code => 'fermage'})
cat_agri_divers = Category.create!({:factcat => factcat_agri, :upcategory => upcategory_facture, :name => 'divers', :code => 'divers'})
cat_agri_oligo = Category.create!({:factcat => factcat_agri, :upcategory => upcategory_pulve, :name => 'oligo', :code => 'oligo'})
cat_agri_azote = Category.create!({:factcat => factcat_agri, :upcategory => upcategory_pulve, :name => 'azote', :code => 'azote'})
cat_agri_engrais = Category.create!({:factcat => factcat_agri, :upcategory => upcategory_pulve, :name => 'engrais', :code => 'engrais'})
cat_agri_semis = Category.create!({:factcat => factcat_agri, :upcategory => upcategory_pulve, :name => 'semis', :code => 'semis'})
cat_agri_soufre = Category.create!({:factcat => factcat_agri, :upcategory => upcategory_pulve, :name => 'soufre', :code => 'soufre'})
cat_agri_desherbant = Category.create!({:factcat => factcat_agri, :upcategory => upcategory_pulve, :name => 'desherbant', :code => 'desherbant'})
cat_agri_fongicide = Category.create!({:factcat => factcat_agri, :upcategory => upcategory_pulve, :name => 'fongicide', :code => 'fongicide'})
cat_agri_herbicide = Category.create!({:factcat => factcat_agri, :upcategory => upcategory_pulve, :name => 'herbicide', :code => 'herbicide'})
cat_agri_insecticide = Category.create!({:factcat => factcat_agri, :upcategory => upcategory_pulve, :name => 'insecticide', :code => 'insecticide'})
cat_agri_moisson = Category.create!({:factcat => factcat_agri, :upcategory => upcategory_labour, :name => 'moisson', :code => 'moisson'})
cat_agri_covercrop = Category.create!({:factcat => factcat_agri, :upcategory => upcategory_labour, :name => 'covercrop', :code => 'covercrop'})
cat_agri_vibro = Category.create!({:factcat => factcat_agri, :upcategory => upcategory_labour, :name => 'vibro', :code => 'vibro'})
cat_agri_herse = Category.create!({:factcat => factcat_agri, :upcategory => upcategory_labour, :name => 'herse', :code => 'herse'})
cat_maison_bricolage = Category.create!({:factcat => factcat_maison, :upcategory => upcategory_facture, :name => 'bricolage', :code => 'bricolage'})
cat_maison_deplacement = Category.create!({:factcat => factcat_maison, :upcategory => upcategory_facture, :name => 'deplacement', :code => 'deplacement'})
cat_maison_frais_generaux = Category.create!({:factcat => factcat_maison, :upcategory => upcategory_facture, :name => 'frais generaux', :code => 'frais_generaux'})
cat_maison_batiment = Category.create!({:factcat => factcat_maison, :upcategory => upcategory_facture, :name => 'batiment', :code => 'batiment'})
cat_maison_telephone = Category.create!({:factcat => factcat_maison, :upcategory => upcategory_facture, :name => 'telephone', :code => 'telephone'})
cat_maison_edf = Category.create!({:factcat => factcat_maison, :upcategory => upcategory_facture, :name => 'edf', :code => 'edf'})
cat_invest_materiel = Category.create!({:factcat => factcat_invest, :upcategory => upcategory_facture, :name => 'materiel', :code => 'materiel'})
cat_invest_batiment = Category.create!({:factcat => factcat_invest, :upcategory => upcategory_facture, :name => 'batiment', :code => 'batiment'})

#Categories Vente
cat_vente_paille_foin = Category.create!({:factcat => factcat_agri, :upcategory => upcategory_vente, :name => 'paille foin', :code => 'paille_foin'})
cat_vente_paille_ble = Category.create!({:factcat => factcat_agri, :upcategory => upcategory_vente, :name => 'paille ble', :code => 'paille_ble'})
cat_vente_paille_colza = Category.create!({:factcat => factcat_agri, :upcategory => upcategory_vente, :name => 'paille colza', :code => 'paille_colza'})
cat_vente_foin = Category.create!({:factcat => factcat_agri, :upcategory => upcategory_vente, :name => 'foin', :code => 'foin'})
cat_vente_ble = Category.create!({:factcat => factcat_agri, :upcategory => upcategory_vente, :name => 'ble', :code => 'ble'})
cat_vente_colza = Category.create!({:factcat => factcat_agri, :upcategory => upcategory_vente, :name => 'colza', :code => 'colza'})
cat_vente_assurance = Category.create!({:factcat => factcat_agri, :upcategory => upcategory_vente, :name => 'Assurance', :code => 'assurance'})
cat_vente_pac = Category.create!({:factcat => factcat_agri, :upcategory => upcategory_vente, :name => 'PAC', :code => 'pac'})
cat_vente_avoir = Category.create!({:factcat => factcat_agri, :upcategory => upcategory_vente, :name => 'avoir', :code => 'avoir'})

# Typecultures
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
# zones pour test
  {:name => 'test - 1', :code => 'zone_test_1', :surface => 10},
  {:name => 'test - 2', :code => 'zone_test_2', :surface => 10},
  
])

