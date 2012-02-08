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
    :show_reportable => false,
    :charges_include_maison => false,
    :charges_include_invest => false,
    :charges_include_stock_produit => true
    )

#Factcats
factcat_agri = Factcat.create!({ :code => 'agri', :name => 'Agricole'}) 
factcat_maison = Factcat.create!({ :code => 'maison', :name => 'Maison'}) 
factcat_invest = Factcat.create!({ :code => 'invest', :name => 'Investissement'}) 

#Upcaegories
upcategory_facture = Upcategory.create!({ :name => 'facture'})
upcategory_produit = Upcategory.create!({ :name => 'produit'})
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
cat_agri_semence = Category.create!({:factcat => factcat_agri, :upcategory => upcategory_facture, :name => 'semence', :code => 'semence'})
cat_agri_oligo = Category.create!({:factcat => factcat_agri, :upcategory => upcategory_produit, :name => 'oligo', :code => 'oligo'})
cat_agri_azote = Category.create!({:factcat => factcat_agri, :upcategory => upcategory_produit, :name => 'azote', :code => 'azote'})
cat_agri_engrais = Category.create!({:factcat => factcat_agri, :upcategory => upcategory_produit, :name => 'engrais', :code => 'engrais'})
cat_agri_semis = Category.create!({:factcat => factcat_agri, :upcategory => upcategory_produit, :name => 'semence', :code => 'semis'})
cat_agri_soufre = Category.create!({:factcat => factcat_agri, :upcategory => upcategory_produit, :name => 'soufre', :code => 'soufre'})
cat_agri_fongicide = Category.create!({:factcat => factcat_agri, :upcategory => upcategory_produit, :name => 'fongicide', :code => 'fongicide'})
cat_agri_herbicide = Category.create!({:factcat => factcat_agri, :upcategory => upcategory_produit, :name => 'herbicide', :code => 'herbicide'})
cat_agri_insecticide = Category.create!({:factcat => factcat_agri, :upcategory => upcategory_produit, :name => 'insecticide', :code => 'insecticide'})
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
cat_vente_tournesol = Category.create!({:factcat => factcat_agri, :upcategory => upcategory_vente, :name => 'tournesol', :code => 'tournesol'})


# Typecultures
  ble = Typeculture.create!({:name => "Ble", :code => "ble"})
  bleble = Typeculture.create!({:name => "2eme Ble", :code => "bleble"})
  tournesol = Typeculture.create!({:name => "Tournesol", :code => "tournesol"})
  colza = Typeculture.create!({:name => "Colza", :code => "colza"})
  jachere = Typeculture.create!({:name => "Jachere", :code => "jachere"})
  luzerne = Typeculture.create!({:name => "Luzerne", :code => "luzerne"})
  foin = Typeculture.create!({:name => "Foin", :code => "foin"})
  gel = Typeculture.create!({:name => "Gel", :code => "gel"})
  trefle = Typeculture.create!({:name => "Trefle", :code => "trefle"})
  autre = Typeculture.create!({:name => "autre", :code => "autre"})
  miscanthus = Typeculture.create!({:name => "Miscanthus", :code => "miscanthus"})
  typeculture = Typeculture.find(:first)

  factypes = Factype.create!([
    {:name => "diff", :display => "diff", :desc => "test desc"},
    {:name => "total", :display => "total", :desc => "test desc"},
    {:name => "null", :display => "null", :desc => "test desc"}])

  users = User.create!([
    # code genere USERS
    {:name => 'Agro-Service', :code => 'agro_service', :tel_fixe => '01 42 65 08 92', :tel_portable => '06 88 64 91 02', :tel_3 => '01 42 65 08 92', :adresse_1 => '14 rue de segur', :adresse_2 => '', :adresse_cp => '75000', :adresse_ville => 'paris', :societe => 'sci mlv', :desc => 'description du client.'},
    {:name => 'AIP systems', :code => 'aip_systems', :tel_fixe => '', :tel_portable => '', :tel_3 => '', :adresse_1 => '', :adresse_2 => '', :adresse_cp => '', :adresse_ville => '', :societe => '', :desc => ''},
    {:name => 'ASTM', :code => 'astm', :tel_fixe => '', :tel_portable => '', :tel_3 => '', :adresse_1 => '', :adresse_2 => '', :adresse_cp => '', :adresse_ville => '', :societe => '', :desc => ''},
    {:name => 'Aubrun carburants', :code => 'aubrun_carburants', :tel_fixe => '', :tel_portable => '', :tel_3 => '', :adresse_1 => '', :adresse_2 => '', :adresse_cp => '', :adresse_ville => '', :societe => '', :desc => ''},
    {:name => 'Aucun', :code => 'aucun', :tel_fixe => '', :tel_portable => '', :tel_3 => '', :adresse_1 => '', :adresse_2 => '', :adresse_cp => '', :adresse_ville => '', :societe => '', :desc => ''},
    {:name => 'Auroy', :code => 'auroy', :tel_fixe => '', :tel_portable => '', :tel_3 => '', :adresse_1 => '', :adresse_2 => '', :adresse_cp => '', :adresse_ville => '', :societe => '', :desc => ''},
    {:name => 'Aussourd', :code => 'aussourd', :tel_fixe => '', :tel_portable => '', :tel_3 => '', :adresse_1 => '', :adresse_2 => '', :adresse_cp => '', :adresse_ville => '', :societe => '', :desc => ''},
    {:name => 'Bastard et Fils', :code => 'bastard', :tel_fixe => '', :tel_portable => '', :tel_3 => '', :adresse_1 => '', :adresse_2 => '', :adresse_cp => '', :adresse_ville => '', :societe => '', :desc => ''},
    {:name => 'Batiloisirs', :code => 'batiloisirs', :tel_fixe => '', :tel_portable => '', :tel_3 => '', :adresse_1 => '', :adresse_2 => '', :adresse_cp => '', :adresse_ville => '', :societe => '', :desc => ''},
    {:name => 'Beauvais', :code => 'beauvais', :tel_fixe => '', :tel_portable => '', :tel_3 => '', :adresse_1 => '', :adresse_2 => '', :adresse_cp => '', :adresse_ville => '', :societe => '', :desc => ''},
    {:name => 'Bernard Peres', :code => 'bernard_peres', :tel_fixe => '', :tel_portable => '', :tel_3 => '', :adresse_1 => '', :adresse_2 => '', :adresse_cp => '', :adresse_ville => '', :societe => '', :desc => ''},
    {:name => 'Bonnin', :code => 'bonnin', :tel_fixe => '', :tel_portable => '', :tel_3 => '', :adresse_1 => '', :adresse_2 => '', :adresse_cp => '', :adresse_ville => '', :societe => '', :desc => ''},
    {:name => 'Bricodepot', :code => 'bricodepot', :tel_fixe => '', :tel_portable => '', :tel_3 => '', :adresse_1 => '', :adresse_2 => '', :adresse_cp => '', :adresse_ville => '', :societe => '', :desc => ''},
    {:name => 'Bricomarche', :code => 'bricomarche', :tel_fixe => '', :tel_portable => '', :tel_3 => '', :adresse_1 => '', :adresse_2 => '', :adresse_cp => '', :adresse_ville => '', :societe => '', :desc => ''},
    {:name => 'Bricopro', :code => 'bricopro', :tel_fixe => '', :tel_portable => '', :tel_3 => '', :adresse_1 => '', :adresse_2 => '', :adresse_cp => '', :adresse_ville => '', :societe => '', :desc => ''},
    {:name => 'C le Mobile', :code => 'c_le_mobile', :tel_fixe => '', :tel_portable => '', :tel_3 => '', :adresse_1 => '', :adresse_2 => '', :adresse_cp => '', :adresse_ville => '', :societe => '', :desc => ''},
    {:name => 'CACI36', :code => 'caci36', :tel_fixe => '', :tel_portable => '', :tel_3 => '', :adresse_1 => '', :adresse_2 => '', :adresse_cp => '', :adresse_ville => '', :societe => '', :desc => ''},
    {:name => 'CBM', :code => 'cbm', :tel_fixe => '', :tel_portable => '', :tel_3 => '', :adresse_1 => '', :adresse_2 => '', :adresse_cp => '', :adresse_ville => '', :societe => '', :desc => ''},
    {:name => 'Centragri', :code => 'centragri', :tel_fixe => '', :tel_portable => '', :tel_3 => '', :adresse_1 => '', :adresse_2 => '', :adresse_cp => '', :adresse_ville => '', :societe => '', :desc => ''},
    {:name => 'CGA 36', :code => 'cga36', :tel_fixe => '', :tel_portable => '', :tel_3 => '', :adresse_1 => '', :adresse_2 => '', :adresse_cp => '', :adresse_ville => '', :societe => '', :desc => ''},
    {:name => 'Chambre Agriculture', :code => 'chambre_agriculture', :tel_fixe => '', :tel_portable => '', :tel_3 => '', :adresse_1 => '', :adresse_2 => '', :adresse_cp => '', :adresse_ville => '', :societe => '', :desc => ''},
    {:name => 'Charrier', :code => 'charrier', :tel_fixe => '', :tel_portable => '', :tel_3 => '', :adresse_1 => '', :adresse_2 => '', :adresse_cp => '', :adresse_ville => '', :societe => '', :desc => ''},
    {:name => 'Chirrault', :code => 'chirrault', :tel_fixe => '', :tel_portable => '', :tel_3 => '', :adresse_1 => '', :adresse_2 => '', :adresse_cp => '', :adresse_ville => '', :societe => '', :desc => ''},
    {:name => 'CMD', :code => 'cmd', :tel_fixe => '', :tel_portable => '', :tel_3 => '', :adresse_1 => '', :adresse_2 => '', :adresse_cp => '', :adresse_ville => '', :societe => '', :desc => ''},
    {:name => 'Communaute de communes', :code => 'communaute_de_communes', :tel_fixe => '', :tel_portable => '', :tel_3 => '', :adresse_1 => '', :adresse_2 => '', :adresse_cp => '', :adresse_ville => '', :societe => '', :desc => ''},
    {:name => 'Compta Centre', :code => 'compta_centre', :tel_fixe => '', :tel_portable => '', :tel_3 => '', :adresse_1 => '', :adresse_2 => '', :adresse_cp => '', :adresse_ville => '', :societe => '', :desc => ''},
    {:name => 'Coutillet', :code => 'coutillet', :tel_fixe => '', :tel_portable => '', :tel_3 => '', :adresse_1 => '', :adresse_2 => '', :adresse_cp => '', :adresse_ville => '', :societe => '', :desc => ''},
    {:name => 'Credit Agricole Assurances', :code => 'credit_agricole_assurances', :tel_fixe => '', :tel_portable => '', :tel_3 => '', :adresse_1 => '', :adresse_2 => '', :adresse_cp => '', :adresse_ville => '', :societe => '', :desc => ''},
    {:name => 'Dauger', :code => 'dauger', :tel_fixe => '', :tel_portable => '', :tel_3 => '', :adresse_1 => '', :adresse_2 => '', :adresse_cp => '', :adresse_ville => '', :societe => '', :desc => ''},
    {:name => 'Daugeron Garage', :code => 'daugeron_garage', :tel_fixe => '', :tel_portable => '', :tel_3 => '', :adresse_1 => '', :adresse_2 => '', :adresse_cp => '', :adresse_ville => '', :societe => '', :desc => ''},
    {:name => 'DDA', :code => 'dda', :tel_fixe => '', :tel_portable => '', :tel_3 => '', :adresse_1 => '', :adresse_2 => '', :adresse_cp => '', :adresse_ville => '', :societe => '', :desc => ''},
    {:name => 'Dechansiaud', :code => 'dechansiaud', :tel_fixe => '', :tel_portable => '', :tel_3 => '', :adresse_1 => '', :adresse_2 => '', :adresse_cp => '', :adresse_ville => '', :societe => '', :desc => ''},
    {:name => 'Demanus', :code => 'demanus', :tel_fixe => '', :tel_portable => '', :tel_3 => '', :adresse_1 => '', :adresse_2 => '', :adresse_cp => '', :adresse_ville => '', :societe => '', :desc => ''},
    {:name => 'Denormandie Jardinerie', :code => 'denormandie', :tel_fixe => '', :tel_portable => '', :tel_3 => '', :adresse_1 => '', :adresse_2 => '', :adresse_cp => '', :adresse_ville => '', :societe => '', :desc => ''},
    {:name => 'divers', :code => 'divers', :tel_fixe => '', :tel_portable => '', :tel_3 => '', :adresse_1 => '', :adresse_2 => '', :adresse_cp => '', :adresse_ville => '', :societe => '', :desc => ''},
    {:name => 'Dumont', :code => 'dumont', :tel_fixe => '', :tel_portable => '', :tel_3 => '', :adresse_1 => '', :adresse_2 => '', :adresse_cp => '', :adresse_ville => '', :societe => '', :desc => ''},
    {:name => 'EARL Prinet', :code => 'earl_prinet', :tel_fixe => '', :tel_portable => '', :tel_3 => '', :adresse_1 => '', :adresse_2 => '', :adresse_cp => '', :adresse_ville => '', :societe => '', :desc => ''},
    {:name => 'EBT', :code => 'ebt', :tel_fixe => '', :tel_portable => '', :tel_3 => '', :adresse_1 => '', :adresse_2 => '', :adresse_cp => '', :adresse_ville => '', :societe => '', :desc => ''},
    {:name => 'EDF bleu ciel', :code => 'edf_bleu_ciel', :tel_fixe => '', :tel_portable => '', :tel_3 => '', :adresse_1 => '', :adresse_2 => '', :adresse_cp => '', :adresse_ville => '', :societe => '', :desc => ''},
    {:name => 'France Telecom', :code => 'France_telecom', :tel_fixe => '', :tel_portable => '', :tel_3 => '', :adresse_1 => '', :adresse_2 => '', :adresse_cp => '', :adresse_ville => '', :societe => '', :desc => ''},
    {:name => 'Groupama', :code => 'groupama', :tel_fixe => '', :tel_portable => '', :tel_3 => '', :adresse_1 => '', :adresse_2 => '', :adresse_cp => '', :adresse_ville => '', :societe => '', :desc => ''},
    {:name => 'Isagri', :code => 'isagri', :tel_fixe => '', :tel_portable => '', :tel_3 => '', :adresse_1 => '', :adresse_2 => '', :adresse_cp => '', :adresse_ville => '', :societe => '', :desc => ''},
    {:name => 'Jamase', :code => 'jamase', :tel_fixe => '', :tel_portable => '', :tel_3 => '', :adresse_1 => '', :adresse_2 => '', :adresse_cp => '', :adresse_ville => '', :societe => '', :desc => ''},
    {:name => 'Jouve', :code => 'jouve', :tel_fixe => '', :tel_portable => '', :tel_3 => '', :adresse_1 => '', :adresse_2 => '', :adresse_cp => '', :adresse_ville => '', :societe => '', :desc => ''},
    {:name => 'Kestoloot', :code => 'kesteloot', :tel_fixe => '', :tel_portable => '', :tel_3 => '', :adresse_1 => '', :adresse_2 => '', :adresse_cp => '', :adresse_ville => '', :societe => '', :desc => ''},
    {:name => 'La France agricole', :code => 'France_agricole', :tel_fixe => '', :tel_portable => '', :tel_3 => '', :adresse_1 => '', :adresse_2 => '', :adresse_cp => '', :adresse_ville => '', :societe => '', :desc => ''},
    {:name => 'La Poste', :code => 'la_poste', :tel_fixe => '', :tel_portable => '', :tel_3 => '', :adresse_1 => '', :adresse_2 => '', :adresse_cp => '', :adresse_ville => '', :societe => '', :desc => ''},
    {:name => 'Lapeyre', :code => 'lapeyre', :tel_fixe => '', :tel_portable => '', :tel_3 => '', :adresse_1 => '', :adresse_2 => '', :adresse_cp => '', :adresse_ville => '', :societe => '', :desc => ''},
    {:name => 'Lapeyre', :code => 'lapeyre', :tel_fixe => '', :tel_portable => '', :tel_3 => '', :adresse_1 => '', :adresse_2 => '', :adresse_cp => '', :adresse_ville => '', :societe => '', :desc => ''},
    {:name => 'Medard', :code => 'medard', :tel_fixe => '', :tel_portable => '', :tel_3 => '', :adresse_1 => '', :adresse_2 => '', :adresse_cp => '', :adresse_ville => '', :societe => '', :desc => ''},
    {:name => 'MF de la Cot', :code => 'mflacot', :tel_fixe => '', :tel_portable => '', :tel_3 => '', :adresse_1 => '', :adresse_2 => '', :adresse_cp => '', :adresse_ville => '', :societe => '', :desc => ''},
    {:name => 'Moulin', :code => 'moulin', :tel_fixe => '', :tel_portable => '', :tel_3 => '', :adresse_1 => '', :adresse_2 => '', :adresse_cp => '', :adresse_ville => '', :societe => '', :desc => ''},
    {:name => 'MSA', :code => 'msa', :tel_fixe => '', :tel_portable => '', :tel_3 => '', :adresse_1 => '', :adresse_2 => '', :adresse_cp => '', :adresse_ville => '', :societe => '', :desc => ''},
    {:name => 'PAC', :code => 'pac', :tel_fixe => '', :tel_portable => '', :tel_3 => '', :adresse_1 => '', :adresse_2 => '', :adresse_cp => '', :adresse_ville => '', :societe => '', :desc => ''},
    {:name => 'Pierre Auroy Sarl', :code => 'pierre_auroy_sarl', :tel_fixe => '', :tel_portable => '', :tel_3 => '', :adresse_1 => '', :adresse_2 => '', :adresse_cp => '', :adresse_ville => '', :societe => '', :desc => ''},
    {:name => 'Pneu Europe Service', :code => 'pneu_europe_service', :tel_fixe => '', :tel_portable => '', :tel_3 => '', :adresse_1 => '', :adresse_2 => '', :adresse_cp => '', :adresse_ville => '', :societe => '', :desc => ''},
    {:name => 'Raffault', :code => 'raffault', :tel_fixe => '', :tel_portable => '', :tel_3 => '', :adresse_1 => '', :adresse_2 => '', :adresse_cp => '', :adresse_ville => '', :societe => '', :desc => ''},
    {:name => 'Raffault freres', :code => 'raffault_freres', :tel_fixe => '', :tel_portable => '', :tel_3 => '', :adresse_1 => '', :adresse_2 => '', :adresse_cp => '', :adresse_ville => '', :societe => '', :desc => ''},
    {:name => 'Renaud', :code => 'renaud', :tel_fixe => '', :tel_portable => '', :tel_3 => '', :adresse_1 => '', :adresse_2 => '', :adresse_cp => '', :adresse_ville => '', :societe => '', :desc => ''},
    {:name => 'Seelec', :code => 'seelec', :tel_fixe => '', :tel_portable => '', :tel_3 => '', :adresse_1 => '', :adresse_2 => '', :adresse_cp => '', :adresse_ville => '', :societe => '', :desc => ''},
    {:name => 'SIAEP Igneraie', :code => 'siaep', :tel_fixe => '', :tel_portable => '', :tel_3 => '', :adresse_1 => '', :adresse_2 => '', :adresse_cp => '', :adresse_ville => '', :societe => '', :desc => ''},
    {:name => 'Sodibe', :code => 'sodibe', :tel_fixe => '', :tel_portable => '', :tel_3 => '', :adresse_1 => '', :adresse_2 => '', :adresse_cp => '', :adresse_ville => '', :societe => '', :desc => ''},
    {:name => 'Sotramat', :code => 'sotramat', :tel_fixe => '', :tel_portable => '', :tel_3 => '', :adresse_1 => '', :adresse_2 => '', :adresse_cp => '', :adresse_ville => '', :societe => '', :desc => ''},
    {:name => 'Super U', :code => 'super_u', :tel_fixe => '', :tel_portable => '', :tel_3 => '', :adresse_1 => '', :adresse_2 => '', :adresse_cp => '', :adresse_ville => '', :societe => '', :desc => ''},
    {:name => 'Trochet', :code => 'trochet', :tel_fixe => '', :tel_portable => '', :tel_3 => '', :adresse_1 => '', :adresse_2 => '', :adresse_cp => '', :adresse_ville => '', :societe => '', :desc => ''}
  ])
  
  trochet = User.find_by_name('Trochet')

  myuser = Myuser.create!([
    {:login => "admin",     :password => "admin",       :admin => true},
    {:login => "matthieu",  :password => "matthieu",    :admin => false},
    {:login => "elisabeth", :password => "elisabeth",   :admin => false},
    {:login => "thierry",   :password => "thierry",     :admin => false}
  ])

end # if SEEDS_BASIC

zones = Zone.create!([
  {:name => 'Bons Pains', :code => 'bons_pains', :surface => 14.03},
  {:name => 'Mitant', :code => 'mitant', :surface => 5.1},
  {:name => 'La Rue', :code => 'la_rue', :surface => 46.63},

  {:name => 'Vallees', :code => 'vallees', :surface => 13.7},

  {:name => 'Guiberons', :code => 'guiberons', :surface => 3},
  {:name => 'Feuillets', :code => 'feuillets', :surface => 16.08},

  {:name => 'Brandes', :code => 'brandes', :surface => 2.97},

  {:name => 'Taillis', :code => 'taillis', :surface => 19.35},

  {:name => 'Varennes', :code => 'varennes', :surface => 15.89},

  {:name => 'Patureaux', :code => 'patureaux', :surface => 8.88},
  {:name => 'Prairies Chevaux', :code => 'chevaux', :surface => 13.28},

  {:name => 'Le bourg', :code => 'le_bourg', :surface => 1.36},
  {:name => 'Reserve', :code => 'reserve', :surface => 2.55},

  {:name => 'Lavernier', :code => 'lavernier', :surface => 0.75},
    
    # zones pour test
  {:name => 'test - 1', :code => 'zone_test_1', :surface => 10},
  {:name => 'test - 2', :code => 'zone_test_2', :surface => 10},
  
])

