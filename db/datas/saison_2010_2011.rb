
# Upcategories
cat_pulve = Upcategory.find_by_name('pulve')
cat_facture = Upcategory.find_by_name('facture')
cat_labour = Upcategory.find_by_name('labour')
cat_vente = Upcategory.find_by_name('vente')
cat_diverse = Upcategory.find_by_name('diverse')

# Categories - pulves
cat_fongicide = Category.find_by_name('fongicide')
cat_insecticide = Category.find_by_name('insecticide')
cat_azote = Category.find_by_name('azote')
cat_engrais = Category.find_by_name('engrais')
cat_semis = Category.find_by_name('semis')
cat_oligo = Category.find_by_name('oligo')
cat_soufre = Category.find_by_name('soufre')
cat_desherbant = Category.find_by_name('desherbant')
cat_moisson = Category.find_by_name('moisson')
cat_divers = Category.find_by_name('divers')

# Categories - labours
cat_covercrop = Category.find_by_name('covercrop')

# Categories - factures
cat_service_agri = Category.find_by_name('service agricole')
cat_phyto = Category.find_by_name('produits phyto')
cat_frais_generaux = Category.find_by_name('frais generaux')
cat_frais_gestion = Category.find_by_name('frais de gestion')
cat_materiel = Category.find_by_name('materiel')
cat_batiment = Category.find_by_name('batiments')
cat_fermage = Category.find_by_name('fermage')
cat_bricolage = Category.find_by_name('bricolage')

# Categories - ventes
cat_paille_foin = Category.find_by_name('Paille foin')
cat_paille_ble = Category.find_by_name('Paille ble')
cat_paille_colza = Category.find_by_name('Paille colza')
cat_assurance = Category.find_by_name('Assurance')


# generation auto Categories read
cat_agri_produits_phyto = Category.find(:first, :conditions => { :upcategory_id => Upcategory.find_by_name('facture').id, :code => 'produits_phyto', :factcat_id => Factcat.find_by_code('agri').id})
cat_agri_mecanique = Category.find(:first, :conditions => { :upcategory_id => Upcategory.find_by_name('facture').id, :code => 'mecanique', :factcat_id => Factcat.find_by_code('agri').id})
cat_agri_batiment = Category.find(:first, :conditions => { :upcategory_id => Upcategory.find_by_name('facture').id, :code => 'batiment', :factcat_id => Factcat.find_by_code('agri').id})
cat_agri_service_agricole = Category.find(:first, :conditions => { :upcategory_id => Upcategory.find_by_name('facture').id, :code => 'service_agricole', :factcat_id => Factcat.find_by_code('agri').id})
cat_agri_services_divers = Category.find(:first, :conditions => { :upcategory_id => Upcategory.find_by_name('facture').id, :code => 'services_divers', :factcat_id => Factcat.find_by_code('agri').id})
cat_agri_comptabilite = Category.find(:first, :conditions => { :upcategory_id => Upcategory.find_by_name('facture').id, :code => 'comptabilite', :factcat_id => Factcat.find_by_code('agri').id})
cat_agri_assurance = Category.find(:first, :conditions => { :upcategory_id => Upcategory.find_by_name('facture').id, :code => 'assurance', :factcat_id => Factcat.find_by_code('agri').id})
cat_agri_frais_generaux = Category.find(:first, :conditions => { :upcategory_id => Upcategory.find_by_name('facture').id, :code => 'frais_generaux', :factcat_id => Factcat.find_by_code('agri').id})
cat_agri_materiel = Category.find(:first, :conditions => { :upcategory_id => Upcategory.find_by_name('facture').id, :code => 'materiel', :factcat_id => Factcat.find_by_code('agri').id})
cat_agri_fermage = Category.find(:first, :conditions => { :upcategory_id => Upcategory.find_by_name('facture').id, :code => 'fermage', :factcat_id => Factcat.find_by_code('agri').id})
cat_agri_divers = Category.find(:first, :conditions => { :upcategory_id => Upcategory.find_by_name('facture').id, :code => 'divers', :factcat_id => Factcat.find_by_code('agri').id})
cat_agri_oligo = Category.find(:first, :conditions => { :upcategory_id => Upcategory.find_by_name('pulve').id, :code => 'oligo', :factcat_id => Factcat.find_by_code('agri').id})
cat_agri_azote = Category.find(:first, :conditions => { :upcategory_id => Upcategory.find_by_name('pulve').id, :code => 'azote', :factcat_id => Factcat.find_by_code('agri').id})
cat_agri_engrais = Category.find(:first, :conditions => { :upcategory_id => Upcategory.find_by_name('pulve').id, :code => 'engrais', :factcat_id => Factcat.find_by_code('agri').id})
cat_agri_semis = Category.find(:first, :conditions => { :upcategory_id => Upcategory.find_by_name('pulve').id, :code => 'semis', :factcat_id => Factcat.find_by_code('agri').id})
cat_agri_soufre = Category.find(:first, :conditions => { :upcategory_id => Upcategory.find_by_name('pulve').id, :code => 'soufre', :factcat_id => Factcat.find_by_code('agri').id})
cat_agri_desherbant = Category.find(:first, :conditions => { :upcategory_id => Upcategory.find_by_name('pulve').id, :code => 'desherbant', :factcat_id => Factcat.find_by_code('agri').id})
cat_agri_fongicide = Category.find(:first, :conditions => { :upcategory_id => Upcategory.find_by_name('pulve').id, :code => 'fongicide', :factcat_id => Factcat.find_by_code('agri').id})
cat_agri_herbicide = Category.find(:first, :conditions => { :upcategory_id => Upcategory.find_by_name('pulve').id, :code => 'herbicide', :factcat_id => Factcat.find_by_code('agri').id})
cat_agri_insecticide = Category.find(:first, :conditions => { :upcategory_id => Upcategory.find_by_name('pulve').id, :code => 'insecticide', :factcat_id => Factcat.find_by_code('agri').id})
cat_agri_moisson = Category.find(:first, :conditions => { :upcategory_id => Upcategory.find_by_name('labour').id, :code => 'moisson', :factcat_id => Factcat.find_by_code('agri').id})
cat_agri_covercrop = Category.find(:first, :conditions => { :upcategory_id => Upcategory.find_by_name('labour').id, :code => 'covercrop', :factcat_id => Factcat.find_by_code('agri').id})
cat_agri_vibro = Category.find(:first, :conditions => { :upcategory_id => Upcategory.find_by_name('labour').id, :code => 'vibro', :factcat_id => Factcat.find_by_code('agri').id})
cat_agri_herse = Category.find(:first, :conditions => { :upcategory_id => Upcategory.find_by_name('labour').id, :code => 'herse', :factcat_id => Factcat.find_by_code('agri').id})
cat_maison_bricolage = Category.find(:first, :conditions => { :upcategory_id => Upcategory.find_by_name('facture').id, :code => 'bricolage', :factcat_id => Factcat.find_by_code('maison').id})
cat_maison_deplacement = Category.find(:first, :conditions => { :upcategory_id => Upcategory.find_by_name('facture').id, :code => 'deplacement', :factcat_id => Factcat.find_by_code('maison').id})
cat_maison_frais_generaux = Category.find(:first, :conditions => { :upcategory_id => Upcategory.find_by_name('facture').id, :code => 'frais_generaux', :factcat_id => Factcat.find_by_code('maison').id})
cat_maison_batiment = Category.find(:first, :conditions => { :upcategory_id => Upcategory.find_by_name('facture').id, :code => 'batiment', :factcat_id => Factcat.find_by_code('maison').id})
cat_maison_telephone = Category.find(:first, :conditions => { :upcategory_id => Upcategory.find_by_name('facture').id, :code => 'telephone', :factcat_id => Factcat.find_by_code('maison').id})
cat_maison_edf = Category.find(:first, :conditions => { :upcategory_id => Upcategory.find_by_name('facture').id, :code => 'edf', :factcat_id => Factcat.find_by_code('maison').id})
cat_invest_materiel = Category.find(:first, :conditions => { :upcategory_id => Upcategory.find_by_name('facture').id, :code => 'materiel', :factcat_id => Factcat.find_by_code('invest').id})
cat_invest_batiment = Category.find(:first, :conditions => { :upcategory_id => Upcategory.find_by_name('facture').id, :code => 'batiment', :factcat_id => Factcat.find_by_code('invest').id})


cat_vente_paille_foin = Category.find(:first, :conditions => { :upcategory_id => Upcategory.find_by_name('vente').id, :code => 'paille_foin', :factcat_id => Factcat.find_by_code('agri').id})
cat_vente_paille_ble = Category.find(:first, :conditions => { :upcategory_id => Upcategory.find_by_name('vente').id, :code => 'paille_ble', :factcat_id => Factcat.find_by_code('agri').id})
cat_vente_paille_colza = Category.find(:first, :conditions => { :upcategory_id => Upcategory.find_by_name('vente').id, :code => 'paille_colza', :factcat_id => Factcat.find_by_code('agri').id})
cat_vente_foin = Category.find(:first, :conditions => { :upcategory_id => Upcategory.find_by_name('vente').id, :code => 'foin', :factcat_id => Factcat.find_by_code('agri').id})
cat_vente_ble = Category.find(:first, :conditions => { :upcategory_id => Upcategory.find_by_name('vente').id, :code => 'ble', :factcat_id => Factcat.find_by_code('agri').id})
cat_vente_colza = Category.find(:first, :conditions => { :upcategory_id => Upcategory.find_by_name('vente').id, :code => 'colza', :factcat_id => Factcat.find_by_code('agri').id})
cat_vente_assurance = Category.find(:first, :conditions => { :upcategory_id => Upcategory.find_by_name('vente').id, :code => 'assurance', :factcat_id => Factcat.find_by_code('agri').id})
cat_vente_pac = Category.find(:first, :conditions => { :upcategory_id => Upcategory.find_by_name('vente').id, :code => 'pac', :factcat_id => Factcat.find_by_code('agri').id})
cat_vente_avoir = Category.find(:first, :conditions => { :upcategory_id => Upcategory.find_by_name('vente').id, :code => 'avoir', :factcat_id => Factcat.find_by_code('agri').id})



#Users
trochet = User.find_by_name('Trochet')
renaud = User.find_by_name('Renaud')
dauger = User.find_by_name('Dauger')
auroy = User.find_by_name('Auroy')
bernard_peres = User.find_by_name('Bernard Peres')

#Typecultures
ble = Typeculture.find_by_name("Ble")
bleble = Typeculture.find_by_name("2eme Ble")
tournesol = Typeculture.find_by_name("Tournesol")
colza = Typeculture.find_by_name("Colza")
jachere = Typeculture.find_by_name("Jachere")
luzerne = Typeculture.find_by_name("Luzerne")
foin = Typeculture.find_by_name("Foin")
typeculture = Typeculture.find(:first)

# Factypes
factype_diff = Factype.find_by_name("diff")
factype_null = Factype.find_by_name("null")
factype_total = Factype.find_by_name("total")

# Factcat
factcat_agri = Factcat.find_by_code("agri")
factcat_maison = Factcat.find_by_code("maison")
factcat_invest = Factcat.find_by_code("invest")


#Saison
saison_2010_2011 = Saison.create!(:name => "2010/2011", :year => "2010")
Setting.find(:first).update_attribute(:saison_id,	saison_2010_2011.id )


# PARCELLES

# #Bons pain + mitant
# for zone in Zone.find([1, 2])
#   parcelle = Parcelle.create!(:name => zone.name, :saison => saison_2010_2011, :typeculture => ble, :surface => zone.surface)
#   zonetopa = Zonetopa.create!(:parcelle => parcelle, :zone => zone, :value => zone.surface)
# end
# 
# # Feuillets
# zone = Zone.find(8)
# parcelle = Parcelle.create!(:name => (zone.name + " 1"), :saison => saison_2010_2011, :typeculture => foin, :surface => 7)
# zonetopa = Zonetopa.create!(:parcelle => parcelle, :zone => zone, :value => parcelle.surface)
# parcelle = Parcelle.create!(:name => (zone.name + " 2"), :saison => saison_2010_2011, :typeculture => foin, :surface => 4)
# zonetopa = Zonetopa.create!(:parcelle => parcelle, :zone => zone, :value => parcelle.surface)
# parcelle = Parcelle.create!(:name => (zone.name + " 3"), :saison => saison_2010_2011, :typeculture => foin, :surface => 5)
# zonetopa = Zonetopa.create!(:parcelle => parcelle, :zone => zone, :value => parcelle.surface)
# 
# 
# # Champ de la Rue
# zone = Zone.find(3)
# parcelle = Parcelle.create!(:name => "Pont des champs", :saison => saison_2010_2011, :typeculture => ble, :surface => 10)
# zonetopa = Zonetopa.create!(:parcelle => parcelle, :zone => zone, :value => parcelle.surface)
# parcelle = Parcelle.create!(:name => "Aeromodelisme", :saison => saison_2010_2011, :typeculture => ble, :surface => 14)
# zonetopa = Zonetopa.create!(:parcelle => parcelle, :zone => zone, :value => parcelle.surface)
# parcelle = Parcelle.create!(:name => "Derierre", :saison => saison_2010_2011, :typeculture => colza, :surface => 14)
# zonetopa = Zonetopa.create!(:parcelle => parcelle, :zone => zone, :value => parcelle.surface)
# parcelle = Parcelle.create!(:name => "Champ du Milieu", :saison => saison_2010_2011, :typeculture => tournesol, :surface => 9)
# zonetopa = Zonetopa.create!(:parcelle => parcelle, :zone => zone, :value => parcelle.surface)
# 
# # Basse-cour
# zone = Zone.find(4)
# parcelle = Parcelle.create!(:name => zone.name, :saison => saison_2010_2011, :typeculture => colza, :surface => zone.surface )
# zonetopa = Zonetopa.create!(:parcelle => parcelle, :zone => zone, :value => parcelle.surface)
# 
# # Vallees
# zone = Zone.find(5)
# parcelle = Parcelle.create!(:name => zone.name, :saison => saison_2010_2011, :typeculture => tournesol, :surface => zone.surface )
# zonetopa = Zonetopa.create!(:parcelle => parcelle, :zone => zone, :value => parcelle.surface)
# 

zone = Zone.find(1)
parcelle = Parcelle.create!(:name => zone.name, :code => 'bons_pains', :saison => saison_2010_2011, :typeculture => ble, :surface => 14)
zonetopa = Zonetopa.create!(:parcelle => parcelle, :zone => zone, :value => parcelle.surface)

zone = Zone.find(2)
parcelle = Parcelle.create!(:name => zone.name, :code => 'mitant', :saison => saison_2010_2011, :typeculture => ble, :surface => 5)
zonetopa = Zonetopa.create!(:parcelle => parcelle, :zone => zone, :value => parcelle.surface)

zone = Zone.find(3)
parcelle = Parcelle.create!(:name => 'Pont des champs', :code => 'pont_des_champs', :saison => saison_2010_2011, :typeculture => ble, :surface => 10)
zonetopa = Zonetopa.create!(:parcelle => parcelle, :zone => zone, :value => parcelle.surface)

zone = Zone.find(3)
parcelle = Parcelle.create!(:name => 'Aeromodelisme', :code => 'aeromodelisme', :saison => saison_2010_2011, :typeculture => ble, :surface => 14)
zonetopa = Zonetopa.create!(:parcelle => parcelle, :zone => zone, :value => parcelle.surface)

zone = Zone.find(3)
parcelle = Parcelle.create!(:name => 'Derriere', :code => 'derriere', :saison => saison_2010_2011, :typeculture => colza, :surface => 14)
zonetopa = Zonetopa.create!(:parcelle => parcelle, :zone => zone, :value => parcelle.surface)

zone = Zone.find(3)
parcelle = Parcelle.create!(:name => 'Champ du Milieu', :code => 'champ_du_milieu', :saison => saison_2010_2011, :typeculture => tournesol, :surface => 9)
zonetopa = Zonetopa.create!(:parcelle => parcelle, :zone => zone, :value => parcelle.surface)

zone = Zone.find(4)
parcelle = Parcelle.create!(:name => zone.name, :code => 'basse_cour', :saison => saison_2010_2011, :typeculture => colza, :surface => 2)
zonetopa = Zonetopa.create!(:parcelle => parcelle, :zone => zone, :value => parcelle.surface)

zone = Zone.find(5)
parcelle = Parcelle.create!(:name => zone.name, :code => 'vallees', :saison => saison_2010_2011, :typeculture => tournesol, :surface => 11)
zonetopa = Zonetopa.create!(:parcelle => parcelle, :zone => zone, :value => parcelle.surface)

zone = Zone.find(6)
parcelle = Parcelle.create!(:name => zone.name, :code => 'guiberons', :saison => saison_2010_2011, :typeculture => foin, :surface => 2.5)
zonetopa = Zonetopa.create!(:parcelle => parcelle, :zone => zone, :value => parcelle.surface)

zone = Zone.find(7)
parcelle = Parcelle.create!(:name => zone.name, :code => 'la_cote', :saison => saison_2010_2011, :typeculture => luzerne, :surface => 2)
zonetopa = Zonetopa.create!(:parcelle => parcelle, :zone => zone, :value => parcelle.surface)

zone = Zone.find(8)
parcelle = Parcelle.create!(:name => 'Feuillet-1', :code => 'feuillets_1', :saison => saison_2010_2011, :typeculture => foin, :surface => 7)
zonetopa = Zonetopa.create!(:parcelle => parcelle, :zone => zone, :value => parcelle.surface)

zone = Zone.find(8)
parcelle = Parcelle.create!(:name => 'Feuillet-2', :code => 'feuillets_2', :saison => saison_2010_2011, :typeculture => foin, :surface => 4)
zonetopa = Zonetopa.create!(:parcelle => parcelle, :zone => zone, :value => parcelle.surface)

zone = Zone.find(8)
parcelle = Parcelle.create!(:name => 'Feuillet-3', :code => 'feuillets_3', :saison => saison_2010_2011, :typeculture => foin, :surface => 5)
zonetopa = Zonetopa.create!(:parcelle => parcelle, :zone => zone, :value => parcelle.surface)

zone = Zone.find(9)
parcelle = Parcelle.create!(:name => zone.name, :code => 'brandes', :saison => saison_2010_2011, :typeculture => foin, :surface => 2.97)
zonetopa = Zonetopa.create!(:parcelle => parcelle, :zone => zone, :value => parcelle.surface)

zone = Zone.find(10)
parcelle = Parcelle.create!(:name => zone.name, :code => 'taillis', :saison => saison_2010_2011, :typeculture => foin, :surface => 19.32)
zonetopa = Zonetopa.create!(:parcelle => parcelle, :zone => zone, :value => parcelle.surface)

zone = Zone.find(11)
parcelle = Parcelle.create!(:name => zone.name, :code => 'varennes', :saison => saison_2010_2011, :typeculture => foin, :surface => 15.86)
zonetopa = Zonetopa.create!(:parcelle => parcelle, :zone => zone, :value => parcelle.surface)

zone = Zone.find(12)
parcelle = Parcelle.create!(:name => zone.name, :code => 'patureaux', :saison => saison_2010_2011, :typeculture => foin, :surface => 8.87)
zonetopa = Zonetopa.create!(:parcelle => parcelle, :zone => zone, :value => parcelle.surface)

zone = Zone.find(13)
parcelle = Parcelle.create!(:name => zone.name, :code => 'chevaux', :saison => saison_2010_2011, :typeculture => foin, :surface => 13.26)
zonetopa = Zonetopa.create!(:parcelle => parcelle, :zone => zone, :value => parcelle.surface)

zone = Zone.find(14)
parcelle = Parcelle.create!(:name => zone.name, :code => 'sous_eglise', :saison => saison_2010_2011, :typeculture => foin, :surface => 1.35)
zonetopa = Zonetopa.create!(:parcelle => parcelle, :zone => zone, :value => parcelle.surface)

zone = Zone.find(15)
parcelle = Parcelle.create!(:name => zone.name, :code => 'reserve', :saison => saison_2010_2011, :typeculture => foin, :surface => 2.55)
zonetopa = Zonetopa.create!(:parcelle => parcelle, :zone => zone, :value => parcelle.surface)

zone = Zone.find(16)
parcelle = Parcelle.create!(:name => zone.name, :code => 'lavernier', :saison => saison_2010_2011, :typeculture => foin, :surface => 0.75)
zonetopa = Zonetopa.create!(:parcelle => parcelle, :zone => zone, :value => parcelle.surface)

zone = Zone.find(17)
parcelle = Parcelle.create!(:name => zone.name, :code => 'le_bourg', :saison => saison_2010_2011, :typeculture => foin, :surface => 0.52)
zonetopa = Zonetopa.create!(:parcelle => parcelle, :zone => zone, :value => parcelle.surface)



# set variables parcelles cultures
parcelles_ble = []
ble.parcelles.find_by_saison(:all, saison_2010_2011).each {|parcelle| parcelles_ble << parcelle}
parcelles_colza = []
colza.parcelles.find_by_saison(:all, saison_2010_2011).each {|parcelle| parcelles_colza << parcelle}
parcelles_tournesol = []
tournesol.parcelles.find_by_saison(:all, saison_2010_2011).each {|parcelle| parcelles_tournesol << parcelle}
parcelles_foin = []
foin.parcelles.find_by_saison(:all, saison_2010_2011).each {|parcelle| parcelles_foin << parcelle}


# PRODUITS - (Generation automatique xls)
zero2030 = Produit.create!(:name => '0-20-30', :unit =>'kg', :category => cat_engrais, :saison => saison_2010_2011, :desc => '')
zero2525 = Produit.create!(:name => '0-25-25', :unit =>'kg', :category => cat_engrais, :saison => saison_2010_2011, :desc => '')
cp151515 = Produit.create!(:name => '15-15-15', :unit =>'kg', :category => cat_engrais, :saison => saison_2010_2011, :desc => '')
altigo = Produit.create!(:name => 'Altigo', :unit =>'kg', :category => cat_semis, :saison => saison_2010_2011, :desc => '')
amistar_xtra = Produit.create!(:name => 'Amistar Xtra', :unit =>'L', :category => cat_fongicide, :saison => saison_2010_2011, :desc => '')
ariane = Produit.create!(:name => 'Ariane', :unit =>'L', :category => cat_desherbant, :saison => saison_2010_2011, :desc => '')
autan = Produit.create!(:name => 'Autan', :unit =>'kg', :category => cat_semis, :saison => saison_2010_2011, :desc => '')
azomag = Produit.create!(:name => 'Azomag', :unit =>'kg', :category => cat_soufre, :saison => saison_2010_2011, :desc => '')
azomag20 = Produit.create!(:name => 'Azomag20', :unit =>'kg', :category => cat_soufre, :saison => saison_2010_2011, :desc => '')
azote = Produit.create!(:name => 'Azote', :unit =>'kg', :category => cat_azote, :saison => saison_2010_2011, :desc => '')
bravo_elite = Produit.create!(:name => 'Bravo Elite', :unit =>'L', :category => cat_fongicide, :saison => saison_2010_2011, :desc => '')
campo = Produit.create!(:name => 'Campo', :unit =>'kg', :category => cat_semis, :saison => saison_2010_2011, :desc => '')
campus = Produit.create!(:name => 'Campus', :unit =>'kg', :category => cat_semis, :saison => saison_2010_2011, :desc => '')
catalino = Produit.create!(:name => 'Catalino', :unit =>'kg', :category => cat_semis, :saison => saison_2010_2011, :desc => '')
celtic = Produit.create!(:name => 'Celtic', :unit =>'L', :category => cat_desherbant, :saison => saison_2010_2011, :desc => '')
challenge = Produit.create!(:name => 'Challenge', :unit =>'L', :category => cat_desherbant, :saison => saison_2010_2011, :desc => '')
chardol = Produit.create!(:name => 'Chardol', :unit =>'L', :category => cat_desherbant, :saison => saison_2010_2011, :desc => '')
chrono = Produit.create!(:name => 'Chrono', :unit =>'L', :category => cat_desherbant, :saison => saison_2010_2011, :desc => '')
cline = Produit.create!(:name => 'Cline', :unit =>'L', :category => cat_desherbant, :saison => saison_2010_2011, :desc => '')
colzamid = Produit.create!(:name => 'Colzamid', :unit =>'L', :category => cat_desherbant, :saison => saison_2010_2011, :desc => '')
comet_player = Produit.create!(:name => 'Comet Player', :unit =>'L', :category => cat_fongicide, :saison => saison_2010_2011, :desc => '')
folyr = Produit.create!(:name => 'Folyr', :unit =>'L', :category => cat_desherbant, :saison => saison_2010_2011, :desc => '')
fury = Produit.create!(:name => 'Fury', :unit =>'L', :category => cat_insecticide, :saison => saison_2010_2011, :desc => '')
glifonet = Produit.create!(:name => 'Glifonet', :unit =>'L', :category => cat_desherbant, :saison => saison_2010_2011, :desc => '')
harmony = Produit.create!(:name => 'Harmony', :unit =>'L', :category => cat_desherbant, :saison => saison_2010_2011, :desc => 'MAISON - pour le jardin')
huile = Produit.create!(:name => 'Huile', :unit =>'L', :category => cat_divers, :saison => saison_2010_2011, :desc => '')
imperio = Produit.create!(:name => 'Imperio', :unit =>'kg', :category => cat_semis, :saison => saison_2010_2011, :desc => '')
karate = Produit.create!(:name => 'Karate', :unit =>'L', :category => cat_insecticide, :saison => saison_2010_2011, :desc => '')
lontrel = Produit.create!(:name => 'Lontrel', :unit =>'L', :category => cat_desherbant, :saison => saison_2010_2011, :desc => '')
mas91 = Produit.create!(:name => 'MAS 91', :unit =>'L', :category => cat_semis, :saison => saison_2010_2011, :desc => '')
novrel = Produit.create!(:name => 'Novrel', :unit =>'kg', :category => cat_semis, :saison => saison_2010_2011, :desc => '')
nuvagrain = Produit.create!(:name => 'Nuvagrain', :unit =>'L', :category => cat_insecticide, :saison => saison_2010_2011, :desc => 'STOCKAGE SILO')
ovation = Produit.create!(:name => 'Ovation', :unit =>'kg', :category => cat_semis, :saison => saison_2010_2011, :desc => 'pour ble')
paledor = Produit.create!(:name => 'Paledor', :unit =>'kg', :category => cat_semis, :saison => saison_2010_2011, :desc => 'MAISON - pour arbres fruitiers')
picabore = Produit.create!(:name => 'Picabore', :unit =>'kg', :category => cat_oligo, :saison => saison_2010_2011, :desc => '')
picosolo = Produit.create!(:name => 'Picosolo', :unit =>'kg', :category => cat_desherbant, :saison => saison_2010_2011, :desc => '')
pr = Produit.create!(:name => 'Pr', :unit =>'kg', :category => cat_semis, :saison => saison_2010_2011, :desc => '')
proca = Produit.create!(:name => 'proca', :unit =>'L', :category => cat_fongicide, :saison => saison_2010_2011, :desc => '')
proteus = Produit.create!(:name => 'Proteus', :unit =>'L', :category => cat_insecticide, :saison => saison_2010_2011, :desc => '')
pulsar = Produit.create!(:name => 'Pulsar', :unit =>'L', :category => cat_desherbant, :saison => saison_2010_2011, :desc => 'GLYPHOSATE')
radar = Produit.create!(:name => 'Radar', :unit =>'L', :category => cat_desherbant, :saison => saison_2010_2011, :desc => '')
richepain = Produit.create!(:name => 'Richepain', :unit =>'kg', :category => cat_semis, :saison => saison_2010_2011, :desc => '')
spartan = Produit.create!(:name => 'spartan', :unit =>'L', :category => cat_divers, :saison => saison_2010_2011, :desc => 'ammonitrate')
springbok = Produit.create!(:name => 'Springbok', :unit =>'L', :category => cat_desherbant, :saison => saison_2010_2011, :desc => '')
stratos = Produit.create!(:name => 'Stratos', :unit =>'L', :category => cat_desherbant, :saison => saison_2010_2011, :desc => '')
super45 = Produit.create!(:name => 'Super45', :unit =>'kg', :category => cat_engrais, :saison => saison_2010_2011, :desc => 'pour ble')
surnog = Produit.create!(:name => 'Surnog', :unit =>'L', :category => cat_fongicide, :saison => saison_2010_2011, :desc => '')
traxos = Produit.create!(:name => 'Traxos', :unit =>'L', :category => cat_desherbant, :saison => saison_2010_2011, :desc => '')
vip = Produit.create!(:name => 'Vip', :unit =>'L', :category => cat_desherbant, :saison => saison_2010_2011, :desc => '')
vitavax = Produit.create!(:name => 'Vitavax', :unit =>'L', :category => cat_divers, :saison => saison_2010_2011, :desc => '')
aubisque = Produit.create!(:name => 'aubisque', :unit =>'L', :category => cat_divers, :saison => saison_2010_2011, :desc => 'pour prairies?')



# FACTURES - from xls

facture = Debit.create!(:name => 'Sacs B.B Adivalor', :date => '2010-11-30', :cout => 2.5, :ref_client => '01-2010-1187', :ref => '001', :user => User.find_by_code('dauger'), :factype => factype_diff,:factcat => factcat_agri,:category => cat_agri_produits_phyto, :desc => '1 sac big bag',:saison => saison_2010_2011, :star => 0, :adu => 0)
facture = Debit.create!(:name => 'Super 45% BB', :date => '2011-01-21', :cout => 3069, :ref_client => '01-2010-1429', :ref => '002', :user => User.find_by_code('dauger'), :factype => factype_diff,:factcat => factcat_agri,:category => cat_agri_produits_phyto, :desc => '',:saison => saison_2010_2011, :star => 0, :adu => 0)
protofacture = Protofacture.create!(:facture => facture, :produit => super45, :prix_unit => 0.465, :quantite => 6600, :saison => saison_2010_2011)
facture = Debit.create!(:name => 'engrais 0-20-30', :date => '2011-01-24', :cout => 1260.8, :ref_client => '01-2011-1448', :ref => '003', :user => User.find_by_code('dauger'), :factype => factype_diff,:factcat => factcat_agri,:category => cat_agri_produits_phyto, :desc => '',:saison => saison_2010_2011, :star => 0, :adu => 0)
protofacture = Protofacture.create!(:facture => facture, :produit => zero2030, :prix_unit => 0.394, :quantite => 3200, :saison => saison_2010_2011)
facture = Debit.create!(:name => 'Sacs B.B Adivalor', :date => '2011-04-30', :cout => 5, :ref_client => '01-2010-2593', :ref => '004', :user => User.find_by_code('dauger'), :factype => factype_diff,:factcat => factcat_agri,:category => cat_agri_produits_phyto, :desc => '2 sac big bag',:saison => saison_2010_2011, :star => 0, :adu => 0)
facture = Debit.create!(:name => 'engrais 0-20-30', :date => '2011-03-29', :cout => 2000, :ref_client => '01-2010-1982', :ref => '005', :user => User.find_by_code('dauger'), :factype => factype_diff,:factcat => factcat_agri,:category => cat_agri_produits_phyto, :desc => '',:saison => saison_2010_2011, :star => 0, :adu => 0)
protofacture = Protofacture.create!(:facture => facture, :produit => zero2030, :prix_unit => 0.4, :quantite => 5000, :saison => saison_2010_2011)
facture = Debit.create!(:name => 'Semance Campus', :date => '2011-03-11', :cout => 994, :ref_client => '01-2010-1767', :ref => '006', :user => User.find_by_code('dauger'), :factype => factype_diff,:factcat => factcat_agri,:category => cat_agri_produits_phyto, :desc => '',:saison => saison_2010_2011, :star => 1, :adu => 0)
protofacture = Protofacture.create!(:facture => facture, :produit => campus, :prix_unit => 142, :quantite => 7, :saison => saison_2010_2011)
facture = Debit.create!(:name => 'produits phyto 1', :date => '2011-03-11', :cout => 4402.2, :ref_client => '01-2010-1767', :ref => '007', :user => User.find_by_code('dauger'), :factype => factype_diff,:factcat => factcat_agri,:category => cat_agri_produits_phyto, :desc => 'pas de prix HT. Verifier la somme.',:saison => saison_2010_2011, :star => 1, :adu => 0)
protofacture = Protofacture.create!(:facture => facture, :produit => amistar_xtra, :prix_unit => 43.9, :quantite => 10, :saison => saison_2010_2011)
protofacture = Protofacture.create!(:facture => facture, :produit => cline, :prix_unit => 20.9, :quantite => 15, :saison => saison_2010_2011)
protofacture = Protofacture.create!(:facture => facture, :produit => pulsar, :prix_unit => 56.6, :quantite => 10, :saison => saison_2010_2011)
protofacture = Protofacture.create!(:facture => facture, :produit => glifonet, :prix_unit => 3.8, :quantite => 200, :saison => saison_2010_2011)
protofacture = Protofacture.create!(:facture => facture, :produit => glifonet, :prix_unit => 3.8, :quantite => 100, :saison => saison_2010_2011)
protofacture = Protofacture.create!(:facture => facture, :produit => huile, :prix_unit => 2.4, :quantite => 60, :saison => saison_2010_2011)
protofacture = Protofacture.create!(:facture => facture, :produit => lontrel, :prix_unit => 52.95, :quantite => 12, :saison => saison_2010_2011)
protofacture = Protofacture.create!(:facture => facture, :produit => chrono, :prix_unit => 37.9, :quantite => 15, :saison => saison_2010_2011)
protofacture = Protofacture.create!(:facture => facture, :produit => mas91, :prix_unit => 198.6, :quantite => 3, :saison => saison_2010_2011)
facture = Debit.create!(:name => 'azomag', :date => '2011-02-28', :cout => 1680, :ref_client => '01-2010-1737', :ref => '008', :user => User.find_by_code('dauger'), :factype => factype_diff,:factcat => factcat_agri,:category => cat_agri_produits_phyto, :desc => 'azomag 16 BB',:saison => saison_2010_2011, :star => 0, :adu => 0)
protofacture = Protofacture.create!(:facture => facture, :produit => azomag, :prix_unit => 0.28, :quantite => 6000, :saison => saison_2010_2011)
facture = Debit.create!(:name => 'produits phyto 2', :date => '2011-04-30', :cout => 1654, :ref_client => '01-2010-2594', :ref => '009', :user => User.find_by_code('dauger'), :factype => factype_diff,:factcat => factcat_agri,:category => cat_agri_produits_phyto, :desc => 'avoir de 2% sous condition. Le karate a-t-il ete rendu a dauger?',:saison => saison_2010_2011, :star => 1, :adu => 0)
protofacture = Protofacture.create!(:facture => facture, :produit => cp151515, :prix_unit => 50, :quantite => 0.5, :saison => saison_2010_2011)
protofacture = Protofacture.create!(:facture => facture, :produit => huile, :prix_unit => 2.4, :quantite => 20, :saison => saison_2010_2011)
protofacture = Protofacture.create!(:facture => facture, :produit => vip, :prix_unit => 67, :quantite => 10, :saison => saison_2010_2011)
protofacture = Protofacture.create!(:facture => facture, :produit => ariane, :prix_unit => 15.4, :quantite => 30, :saison => saison_2010_2011)
protofacture = Protofacture.create!(:facture => facture, :produit => traxos, :prix_unit => 31.65, :quantite => 10, :saison => saison_2010_2011)
protofacture = Protofacture.create!(:facture => facture, :produit => karate, :prix_unit => 132.5, :quantite => 1, :saison => saison_2010_2011)
facture = Debit.create!(:name => 'produits phyto 3', :date => '2011-03-11', :cout => 6314.35, :ref_client => '01-2010-1767', :ref => '010', :user => User.find_by_code('dauger'), :factype => factype_diff,:factcat => factcat_agri,:category => cat_agri_produits_phyto, :desc => 'avoir de 2% + 3% sauf glifonet -0,30€',:saison => saison_2010_2011, :star => 0, :adu => 0)
protofacture = Protofacture.create!(:facture => facture, :produit => stratos, :prix_unit => 18.8, :quantite => 10, :saison => saison_2010_2011)
protofacture = Protofacture.create!(:facture => facture, :produit => radar, :prix_unit => 212.5, :quantite => 12, :saison => saison_2010_2011)
protofacture = Protofacture.create!(:facture => facture, :produit => spartan, :prix_unit => 33.9, :quantite => 5, :saison => saison_2010_2011)
protofacture = Protofacture.create!(:facture => facture, :produit => lontrel, :prix_unit => 52.95, :quantite => 1, :saison => saison_2010_2011)
protofacture = Protofacture.create!(:facture => facture, :produit => huile, :prix_unit => 2.4, :quantite => 20, :saison => saison_2010_2011)
protofacture = Protofacture.create!(:facture => facture, :produit => radar, :prix_unit => 212.5, :quantite => 2.2, :saison => saison_2010_2011)
protofacture = Protofacture.create!(:facture => facture, :produit => proca, :prix_unit => 10.2, :quantite => 45, :saison => saison_2010_2011)
protofacture = Protofacture.create!(:facture => facture, :produit => bravo_elite, :prix_unit => 18.3, :quantite => 60, :saison => saison_2010_2011)
protofacture = Protofacture.create!(:facture => facture, :produit => comet_player, :prix_unit => 159.9, :quantite => 6, :saison => saison_2010_2011)
protofacture = Protofacture.create!(:facture => facture, :produit => surnog, :prix_unit => 32.2, :quantite => 10, :saison => saison_2010_2011)
facture = Debit.create!(:name => 'Ammonitrate', :date => '2010-08-31', :cout => 9204, :ref_client => '01-2010-250', :ref => '011', :user => User.find_by_code('dauger'), :factype => factype_diff,:factcat => factcat_agri,:category => cat_agri_produits_phyto, :desc => 'voire indications manuscrites sur la facture',:saison => saison_2010_2011, :star => 1, :adu => 0)
protofacture = Protofacture.create!(:facture => facture, :produit => azote, :prix_unit => 0.26, :quantite => 25200, :saison => saison_2010_2011)
protofacture = Protofacture.create!(:facture => facture, :produit => azote, :prix_unit => 0.26, :quantite => 10200, :saison => saison_2010_2011)
facture = Debit.create!(:name => 'produits phyto 4', :date => '2010-10-31', :cout => 998.99, :ref_client => '01-2010-975', :ref => '012', :user => User.find_by_code('dauger'), :factype => factype_diff,:factcat => factcat_agri,:category => cat_agri_produits_phyto, :desc => 'avoir de 13,25 à prendre en compte',:saison => saison_2010_2011, :star => 1, :adu => 0)
protofacture = Protofacture.create!(:facture => facture, :produit => fury, :prix_unit => 44.5, :quantite => 5, :saison => saison_2010_2011)
protofacture = Protofacture.create!(:facture => facture, :produit => huile, :prix_unit => 2.65, :quantite => 20, :saison => saison_2010_2011)
protofacture = Protofacture.create!(:facture => facture, :produit => folyr, :prix_unit => 30.8, :quantite => 10, :saison => saison_2010_2011)
protofacture = Protofacture.create!(:facture => facture, :produit => paledor, :prix_unit => 61.8, :quantite => 2, :saison => saison_2010_2011)
protofacture = Protofacture.create!(:facture => facture, :produit => altigo, :prix_unit => 63.8, :quantite => 2, :saison => saison_2010_2011)
protofacture = Protofacture.create!(:facture => facture, :produit => pr, :prix_unit => 23.47, :quantite => 7, :saison => saison_2010_2011)
facture = Debit.create!(:name => 'produits phyto 5', :date => '2010-09-27', :cout => 4907.4, :ref_client => '01-2010-471', :ref => '013', :user => User.find_by_code('dauger'), :factype => factype_diff,:factcat => factcat_agri,:category => cat_agri_produits_phyto, :desc => 'produits non associes = jachere? A DETERMINER',:saison => saison_2010_2011, :star => 1, :adu => 0)
#protofacture = Protofacture.create!(:facture => facture, :produit => dactyle, :prix_unit => 5.2, :quantite => 130, :saison => saison_2010_2011)
#protofacture = Protofacture.create!(:facture => facture, :produit => anglais_calibra, :prix_unit => 2.9, :quantite => 120, :saison => saison_2010_2011)
#protofacture = Protofacture.create!(:facture => facture, :produit => italie_turtetra, :prix_unit => 1.7, :quantite => 100, :saison => saison_2010_2011)
#protofacture = Protofacture.create!(:facture => facture, :produit => fet_elevee_noria, :prix_unit => 5.2, :quantite => 110, :saison => saison_2010_2011)
#protofacture = Protofacture.create!(:facture => facture, :produit => tref_violet_valente, :prix_unit => 4.2, :quantite => 20, :saison => saison_2010_2011)
#protofacture = Protofacture.create!(:facture => facture, :produit => kali, :prix_unit => 5.2, :quantite => 80, :saison => saison_2010_2011)
#protofacture = Protofacture.create!(:facture => facture, :produit => tref_blanc_regal, :prix_unit => 7.9, :quantite => 25, :saison => saison_2010_2011)
#protofacture = Protofacture.create!(:facture => facture, :produit => oxyfertil, :prix_unit => 19.15, :quantite => 36, :saison => saison_2010_2011)
protofacture = Protofacture.create!(:facture => facture, :produit => ovation, :prix_unit => 139.5, :quantite => 1, :saison => saison_2010_2011)
protofacture = Protofacture.create!(:facture => facture, :produit => colzamid, :prix_unit => 19.3, :quantite => 30, :saison => saison_2010_2011)
protofacture = Protofacture.create!(:facture => facture, :produit => springbok, :prix_unit => 25.9, :quantite => 40, :saison => saison_2010_2011)
facture = Debit.create!(:name => 'produits phyto 6', :date => '2010-09-30', :cout => 246, :ref_client => '01-2010-689', :ref => '014', :user => User.find_by_code('dauger'), :factype => factype_diff,:factcat => factcat_agri,:category => cat_agri_produits_phyto, :desc => '',:saison => saison_2010_2011, :star => 0, :adu => 0)
protofacture = Protofacture.create!(:facture => facture, :produit => aubisque, :prix_unit => 3.7, :quantite => 10, :saison => saison_2010_2011)
protofacture = Protofacture.create!(:facture => facture, :produit => chardol, :prix_unit => 7.85, :quantite => 10, :saison => saison_2010_2011)
protofacture = Protofacture.create!(:facture => facture, :produit => chardol, :prix_unit => 7.85, :quantite => 10, :saison => saison_2010_2011)
protofacture = Protofacture.create!(:facture => facture, :produit => huile, :prix_unit => 2.6, :quantite => 20, :saison => saison_2010_2011)
facture = Debit.create!(:name => 'vitavax + BB', :date => '2010-10-20', :cout => 746.58, :ref_client => '22269', :ref => '015', :user => User.find_by_code('renaud'), :factype => factype_diff,:factcat => factcat_agri,:category => cat_agri_produits_phyto, :desc => 'vitavax + Big BagsBB : 8x9,41=75,24€ à répartir',:saison => saison_2010_2011, :star => 1, :adu => 0)
protofacture = Protofacture.create!(:facture => facture, :produit => vitavax, :prix_unit => 10.05, :quantite => 66.8, :saison => saison_2010_2011)
facture = Debit.create!(:name => 'Fury 5L', :date => '2011-03-31', :cout => 163.7, :ref_client => 'FCT-1305', :ref => '016', :user => User.find_by_code('auroy'), :factype => factype_diff,:factcat => factcat_agri,:category => cat_agri_produits_phyto, :desc => '',:saison => saison_2010_2011, :star => 1, :adu => 0)
protofacture = Protofacture.create!(:facture => facture, :produit => fury, :prix_unit => 32.74, :quantite => 5, :saison => saison_2010_2011)
facture = Debit.create!(:name => 'Picabore + Challenge', :date => '2011-02-28', :cout => 1221.81, :ref_client => '24302', :ref => '017', :user => User.find_by_code('renaud'), :factype => factype_diff,:factcat => factcat_agri,:category => cat_agri_produits_phyto, :desc => '',:saison => saison_2010_2011, :star => 1, :adu => 0)
protofacture = Protofacture.create!(:facture => facture, :produit => picabore, :prix_unit => 2.1, :quantite => 40, :saison => saison_2010_2011)
protofacture = Protofacture.create!(:facture => facture, :produit => challenge, :prix_unit => 18.96, :quantite => 60, :saison => saison_2010_2011)
protofacture = Protofacture.create!(:facture => facture, :produit => challenge, :prix_unit => 1.2, :quantite => 60, :saison => saison_2010_2011)
facture = Debit.create!(:name => 'produits phyto 7', :date => '2011-06-28', :cout => 389.9, :ref_client => 'FCC-1629', :ref => '018', :user => User.find_by_code('auroy'), :factype => factype_diff,:factcat => factcat_agri,:category => cat_agri_produits_phyto, :desc => 'produits + Bib Bag 1,50x1,60 : 10x10=100€ a répartir',:saison => saison_2010_2011, :star => 1, :adu => 0)
protofacture = Protofacture.create!(:facture => facture, :produit => nuvagrain, :prix_unit => 36, :quantite => 5, :saison => saison_2010_2011)
protofacture = Protofacture.create!(:facture => facture, :produit => karate, :prix_unit => 109.9, :quantite => 1, :saison => saison_2010_2011)
facture = Debit.create!(:name => 'nuvagrain', :date => '2010-07-10', :cout => 51.26, :ref_client => 'FCC-44', :ref => '019', :user => User.find_by_code('auroy'), :factype => factype_diff,:factcat => factcat_agri,:category => cat_agri_produits_phyto, :desc => '',:saison => saison_2010_2011, :star => 0, :adu => 0)
protofacture = Protofacture.create!(:facture => facture, :produit => nuvagrain, :prix_unit => 25.63, :quantite => 2, :saison => saison_2010_2011)
facture = Debit.create!(:name => 'semis tournesol', :date => '2011-03-27', :cout => 260, :ref_client => '015-2011', :ref => '020', :user => User.find_by_code('bernard_peres'), :factype => factype_diff,:factcat => factcat_agri,:category => cat_agri_service_agricole, :desc => '20ha x 13€/ha = 260€',:saison => saison_2010_2011, :star => 0, :adu => 0)
parcelles_tournesol.each {|p| factoparcelle = Factoparcelle.create!(:parcelle => p, :facture => facture)}

reportable = Reportable.create!(:name => 'facture 19', :date => '2011-01-30', :cout => 3537.5, :ref_client => '19', :ref => '021', :user => User.find_by_code('trochet'), :factype => factype_null,:factcat => factcat_agri,:category => cat_agri_service_agricole, :desc => '',:saison => saison_2010_2011, :star => 0, :adu => 0)
fac_pulve = Report.create!(:reportable => reportable, :name => 'Pulvérisation', :date => '2011-01-30', :cout => 955, :ref_client => '19', :ref => '021', :user => User.find_by_code('trochet'), :factype => factype_diff,:factcat => factcat_agri,:category => cat_agri_service_agricole, :desc => '95,5Ha x 10€ = 955€',:saison => saison_2010_2011, :star => 0, :adu => 0)
facture = Report.create!(:reportable => reportable, :name => 'Broyage haies', :date => '2011-01-30', :cout => 456, :ref_client => '19', :ref => '021', :user => User.find_by_code('trochet'), :factype => factype_diff,:factcat => factcat_agri,:category => cat_agri_service_agricole, :desc => '12h x 38€ = 456€',:saison => saison_2010_2011, :star => 0, :adu => 0)
facture = Report.create!(:reportable => reportable, :name => 'Broyage horizontal', :date => '2011-01-30', :cout => 297.5, :ref_client => '19', :ref => '021', :user => User.find_by_code('trochet'), :factype => factype_diff,:factcat => factcat_agri,:category => cat_agri_service_agricole, :desc => '8h50 x 35€/h = 297,5. Imputer sur le Tournesol',:saison => saison_2010_2011, :star => 0, :adu => 0)
parcelles_tournesol.each {|p| factoparcelle = Factoparcelle.create!(:parcelle => p, :facture => facture)}
fac_semis = Report.create!(:reportable => reportable, :name => 'Semis Colza et Blé', :date => '2011-01-30', :cout => 1829, :ref_client => '19', :ref => '021', :user => User.find_by_code('trochet'), :factype => factype_diff,:factcat => factcat_agri,:category => cat_agri_service_agricole, :desc => '59ha x 31€/ha = 1829€',:saison => saison_2010_2011, :star => 0, :adu => 0)
parcelles_colza.each {|p| factoparcelle = Factoparcelle.create!(:parcelle => p, :facture => fac_semis)}
parcelles_ble.each {|p| factoparcelle = Factoparcelle.create!(:parcelle => p, :facture => fac_semis)}

reportable = Reportable.create!(:name => 'facture 18', :date => '2011-01-30', :cout => 3515, :ref_client => '18', :ref => '022', :user => User.find_by_code('trochet'), :factype => factype_null,:factcat => factcat_agri,:category => cat_agri_service_agricole, :desc => '',:saison => saison_2010_2011, :star => 0, :adu => 0)
facture = Report.create!(:reportable => reportable, :name => 'Roulage', :date => '2011-01-30', :cout => 465, :ref_client => '18', :ref => '022', :user => User.find_by_code('trochet'), :factype => factype_diff,:factcat => factcat_agri,:category => cat_agri_service_agricole, :desc => '15h30 x 30€/h = 465€. Imputer sur Ble et Colza',:saison => saison_2010_2011, :star => 0, :adu => 0)
parcelles_colza.each {|p| factoparcelle = Factoparcelle.create!(:parcelle => p, :facture => fac_semis)}
parcelles_ble.each {|p| factoparcelle = Factoparcelle.create!(:parcelle => p, :facture => fac_semis)}
fac_covercrop = Report.create!(:reportable => reportable, :name => 'Cover-crop', :date => '2011-01-30', :cout => 2240, :ref_client => '18', :ref => '022', :user => User.find_by_code('trochet'), :factype => factype_diff,:factcat => factcat_agri,:category => cat_agri_service_agricole, :desc => '64h x 35€/h = 2240€. Imputer sur Ble, Colza, Tournesol',:saison => saison_2010_2011, :star => 0, :adu => 0)
parcelles_tournesol.each {|p| factoparcelle = Factoparcelle.create!(:parcelle => p, :facture => fac_covercrop)}
parcelles_colza.each {|p| factoparcelle = Factoparcelle.create!(:parcelle => p, :facture => fac_covercrop)}
parcelles_ble.each {|p| factoparcelle = Factoparcelle.create!(:parcelle => p, :facture => fac_covercrop)}
facture = Report.create!(:reportable => reportable, :name => 'Vibro', :date => '2011-01-30', :cout => 810, :ref_client => '18', :ref => '022', :user => User.find_by_code('trochet'), :factype => factype_diff,:factcat => factcat_agri,:category => cat_agri_service_agricole, :desc => '81ha au lieu de 79 x 10€ = 810€',:saison => saison_2010_2011, :star => 1, :adu => 0)

reportable = Reportable.create!(:name => 'facture 20', :date => '2011-01-30', :cout => 2950, :ref_client => '20', :ref => '023', :user => User.find_by_code('trochet'), :factype => factype_null,:factcat => factcat_agri,:category => cat_agri_service_agricole, :desc => '',:saison => saison_2010_2011, :star => 0, :adu => 0)
facture = Report.create!(:reportable => reportable, :name => 'Labour + Herse', :date => '2011-01-30', :cout => 2830, :ref_client => '20', :ref => '023', :user => User.find_by_code('trochet'), :factype => factype_diff,:factcat => factcat_agri,:category => cat_agri_service_agricole, :desc => 'Mise en prairie (semis prairies ~19ha) Imputer sur parcelles_foin',:saison => saison_2010_2011, :star => 0, :adu => 0)
parcelles_foin.each {|p| factoparcelle = Factoparcelle.create!(:parcelle => p, :facture => facture)}
facture = Report.create!(:reportable => reportable, :name => 'Epandage chaux', :date => '2011-01-30', :cout => 120, :ref_client => '20', :ref => '023', :user => User.find_by_code('trochet'), :factype => factype_diff,:factcat => factcat_agri,:category => cat_agri_service_agricole, :desc => 'Imputer sur parcelles_foin',:saison => saison_2010_2011, :star => 0, :adu => 0)
parcelles_foin.each {|p| factoparcelle = Factoparcelle.create!(:parcelle => p, :facture => facture)}

reportable = Reportable.create!(:name => 'facture 24', :date => '2011-07-19', :cout => 5790, :ref_client => '24', :ref => '024', :user => User.find_by_code('trochet'), :factype => factype_null,:factcat => factcat_agri,:category => cat_agri_service_agricole, :desc => 'reste 300e pour semis tournesol 2012',:saison => saison_2010_2011, :star => 0, :adu => 0)
fac_engrais = Report.create!(:reportable => reportable, :name => 'Epandage engrais', :date => '2011-07-19', :cout => 2520, :ref_client => '24', :ref => '024', :user => User.find_by_code('trochet'), :factype => factype_diff,:factcat => factcat_agri,:category => cat_agri_service_agricole, :desc => '252 ha x 10€ = 2520€',:saison => saison_2010_2011, :star => 0, :adu => 0)
fac_pulve_2 = Report.create!(:reportable => reportable, :name => 'Pulvérisation cultures', :date => '2011-07-19', :cout => 2850, :ref_client => '24', :ref => '024', :user => User.find_by_code('trochet'), :factype => factype_diff,:factcat => factcat_agri,:category => cat_agri_service_agricole, :desc => '285 ha x 10€ = 2850€',:saison => saison_2010_2011, :star => 0, :adu => 0)
facture = Report.create!(:reportable => reportable, :name => 'tours de champs', :date => '2011-07-19', :cout => 120, :ref_client => '24', :ref => '024', :user => User.find_by_code('trochet'), :factype => factype_diff,:factcat => factcat_agri,:category => cat_agri_service_agricole, :desc => '4h x 30€/h = 120€ (desherbage)',:saison => saison_2010_2011, :star => 0, :adu => 0)


reportable = Reportable.create!(:name => 'facture 25', :date => '2011-07-19', :cout => 226.4, :ref_client => '25', :ref => '025', :user => User.find_by_code('trochet'), :factype => factype_null,:factcat => factcat_agri,:category => cat_agri_service_agricole, :desc => 'Imputer sur tournesol',:saison => saison_2010_2011, :star => 0, :adu => 0)
facture = Report.create!(:reportable => reportable, :name => 'Vibro', :date => '2011-07-19', :cout => 200, :ref_client => '25', :ref => '025', :user => User.find_by_code('trochet'), :factype => factype_diff,:factcat => factcat_agri,:category => cat_agri_service_agricole, :desc => '20ha x 10€ = 200€',:saison => saison_2010_2011, :star => 0, :adu => 0)
parcelles_tournesol.each {|p| factoparcelle = Factoparcelle.create!(:parcelle => p, :facture => facture)}
facture = Report.create!(:reportable => reportable, :name => 'Orge', :date => '2011-07-19', :cout => 26.4, :ref_client => '25', :ref => '025', :user => User.find_by_code('trochet'), :factype => factype_diff,:factcat => factcat_agri,:category => cat_agri_service_agricole, :desc => '150kg x 176€/t = 26,40€ transport orge',:saison => saison_2010_2011, :star => 0, :adu => 0)

fac_moisson = Debit.create!(:name => 'moisson cultures', :date => '2011-10-26', :cout => 5475, :ref_client => '31', :ref => '026', :user => User.find_by_code('trochet'), :factype => factype_diff,:factcat => factcat_agri,:category => cat_agri_service_agricole, :desc => '',:saison => saison_2010_2011, :star => 0, :adu => 0)
parcelles_tournesol.each {|p| factoparcelle = Factoparcelle.create!(:parcelle => p, :facture => fac_moisson)}
parcelles_colza.each {|p| factoparcelle = Factoparcelle.create!(:parcelle => p, :facture => fac_moisson)}
parcelles_ble.each {|p| factoparcelle = Factoparcelle.create!(:parcelle => p, :facture => fac_moisson)}

facture = Debit.create!(:name => 'PRODUITS MANQUANTS', :date => '2011-02-28', :cout => 1221.81, :ref_client => '0000', :ref => '028', :user => User.find_by_code('dauger'), :factype => factype_diff,:factcat => factcat_agri,:category => cat_agri_produits_phyto, :desc => '',:saison => saison_2010_2011, :star => 1, :adu => 0)
protofacture = Protofacture.create!(:facture => facture, :produit => picabore, :prix_unit => 2.1, :quantite => 40, :saison => saison_2010_2011)
protofacture = Protofacture.create!(:facture => facture, :produit => challenge, :prix_unit => 18.96, :quantite => 60, :saison => saison_2010_2011)
protofacture = Protofacture.create!(:facture => facture, :produit => challenge, :prix_unit => 1.2, :quantite => 60, :saison => saison_2010_2011)
protofacture = Protofacture.create!(:facture => facture, :produit => azomag, :prix_unit => 0.28, :quantite => 700, :saison => saison_2010_2011)


facture = Debit.create!(:name => 'chargeur JCB', :date => '2011-04-15', :cout => 12000, :ref_client => '0049', :ref => '029', :user => User.find_by_code('kesteloot'), :factype => factype_total,:factcat => factcat_invest,:category => cat_invest_materiel, :desc => 'num facture: 403841',:saison => saison_2010_2011, :star => 0, :adu => 0)
facture = Debit.create!(:name => 'compta agricole', :date => '2011-05-31', :cout => 615, :ref_client => '29814', :ref => '030', :user => User.find_by_code('compta_centre'), :factype => factype_total,:factcat => factcat_agri,:category => cat_agri_frais_generaux, :desc => '',:saison => saison_2010_2011, :star => 0, :adu => 0)
facture = Debit.create!(:name => 'SIAEP - compteur eau', :date => '2011-06-25', :cout => 56, :ref_client => '00908', :ref => '031', :user => User.find_by_code('siaep'), :factype => factype_total,:factcat => factcat_maison,:category => cat_maison_frais_generaux, :desc => 'premier semestre 2011',:saison => saison_2010_2011, :star => 0, :adu => 0)
facture = Debit.create!(:name => 'abonnement Terre-net', :date => '2010-08-27', :cout => 130, :ref_client => '966411', :ref => '032', :user => User.find_by_code('isagri'), :factype => factype_total,:factcat => factcat_agri,:category => cat_agri_frais_generaux, :desc => 'moins avoir de 11.80',:saison => saison_2010_2011, :star => 0, :adu => 0)
facture = Debit.create!(:name => 'Silo Jamase', :date => '2011-06-06', :cout => 8124, :ref_client => '1105002', :ref => '033', :user => User.find_by_code('jamase'), :factype => factype_total,:factcat => factcat_invest,:category => cat_invest_materiel, :desc => 'silo et vis a grain',:saison => saison_2010_2011, :star => 0, :adu => 0)
facture = Debit.create!(:name => 'Silo Jamase', :date => '2011-07-07', :cout => 9431, :ref_client => '1107024', :ref => '034', :user => User.find_by_code('jamase'), :factype => factype_total,:factcat => factcat_invest,:category => cat_invest_materiel, :desc => 'silo et vis a grain',:saison => saison_2010_2011, :star => 0, :adu => 0)
facture = Debit.create!(:name => 'forfait ordures agricoles', :date => '2011-04-13', :cout => 18.48, :ref_client => '00003141', :ref => '035', :user => User.find_by_code('communaute_de_communes'), :factype => factype_total,:factcat => factcat_agri,:category => cat_agri_frais_generaux, :desc => '',:saison => saison_2010_2011, :star => 0, :adu => 0)
facture = Debit.create!(:name => 'msa', :date => '2011-02-22', :cout => 991.80, :ref_client => '008350', :ref => '036', :user => User.find_by_code('msa'), :factype => factype_total,:factcat => factcat_agri,:category => cat_agri_frais_generaux, :desc => '',:saison => saison_2010_2011, :star => 0, :adu => 0)
facture = Debit.create!(:name => 'transport sable', :date => '2011-04-30', :cout => 324.74, :ref_client => 'sot110400039', :ref => '037', :user => User.find_by_code('sotramat'), :factype => factype_total,:factcat => factcat_invest,:category => cat_invest_batiment, :desc => '',:saison => saison_2010_2011, :star => 0, :adu => 0)
facture = Debit.create!(:name => 'transp sable et graville', :date => '2011-03-31', :cout => 4520.20, :ref_client => 'sot110300017', :ref => '038', :user => User.find_by_code('sotramat'), :factype => factype_total,:factcat => factcat_invest,:category => cat_invest_batiment, :desc => '',:saison => saison_2010_2011, :star => 0, :adu => 0)
facture = Debit.create!(:name => 'cga36', :date => '2011-03-08', :cout => 186, :ref_client => 'CA005066', :ref => '039', :user => User.find_by_code('cga36'), :factype => factype_total,:factcat => factcat_agri,:category => cat_agri_frais_generaux, :desc => '',:saison => saison_2010_2011, :star => 1, :adu => 0)
facture = Debit.create!(:name => 'reparation covercrop', :date => '2011-03-31', :cout => 179.39, :ref_client => 'BA030320/D', :ref => '040', :user => User.find_by_code('bastard'), :factype => factype_total,:factcat => factcat_agri,:category => cat_agri_materiel, :desc => '',:saison => saison_2010_2011, :star => 0, :adu => 0)
facture = Debit.create!(:name => 'construction hangar', :date => '2011-03-14', :cout => 36705, :ref_client => '1115', :ref => '041', :user => User.find_by_code('cmd'), :factype => factype_total,:factcat => factcat_invest,:category => cat_invest_materiel, :desc => '',:saison => saison_2010_2011, :star => 0, :adu => 0)
facture = Debit.create!(:name => 'peson pour bottes', :date => '2011-05-31', :cout => 360, :ref_client => 'FC7853', :ref => '042', :user => User.find_by_code('aip_systems'), :factype => factype_total,:factcat => factcat_invest,:category => cat_invest_materiel, :desc => '',:saison => saison_2010_2011, :star => 0, :adu => 0)
facture = Debit.create!(:name => 'reparation pneu', :date => '2011-05-24', :cout => 57.68, :ref_client => '55087555', :ref => '043', :user => User.find_by_code('chirrault'), :factype => factype_total,:factcat => factcat_agri,:category => cat_agri_materiel, :desc => '',:saison => saison_2010_2011, :star => 0, :adu => 0)
facture = Debit.create!(:name => 'transport chargeur JCB', :date => '2011-04-12', :cout => 376.25, :ref_client => '4311004', :ref => '044', :user => User.find_by_code('astm'), :factype => factype_total,:factcat => factcat_invest,:category => cat_invest_materiel, :desc => '',:saison => saison_2010_2011, :star => 0, :adu => 0)
facture = Debit.create!(:name => 'Fioul', :date => '2011-04-26', :cout => 1083.14, :ref_client => '36428', :ref => '045', :user => User.find_by_code('raffault'), :factype => factype_total,:factcat => factcat_agri,:category => cat_agri_frais_generaux, :desc => '',:saison => saison_2010_2011, :star => 0, :adu => 0)
facture = Debit.create!(:name => 'abo France agricole', :date => '2011-01-01', :cout => 117.04, :ref_client => 'GFA 212', :ref => '046', :user => User.find_by_code('France_agricole'), :factype => factype_total,:factcat => factcat_agri,:category => cat_agri_frais_generaux, :desc => '',:saison => saison_2010_2011, :star => 0, :adu => 0)
facture = Debit.create!(:name => 'cosses a souder', :date => '2011-01-28', :cout => 13.15, :ref_client => '46059', :ref => '047', :user => User.find_by_code('beauvais'), :factype => factype_total,:factcat => factcat_agri,:category => cat_agri_materiel, :desc => '',:saison => saison_2010_2011, :star => 0, :adu => 0)
facture = Debit.create!(:name => 'Huile 15w40', :date => '2011-01-07', :cout => 148.80, :ref_client => '7490', :ref => '048', :user => User.find_by_code('aubrun_carburants'), :factype => factype_total,:factcat => factcat_agri,:category => cat_agri_frais_generaux, :desc => '',:saison => saison_2010_2011, :star => 0, :adu => 0)
facture = Debit.create!(:name => 'Huile transmission', :date => '2011-01-07', :cout => 172.80, :ref_client => '7489', :ref => '049', :user => User.find_by_code('aubrun_carburants'), :factype => factype_total,:factcat => factcat_agri,:category => cat_agri_frais_generaux, :desc => '',:saison => saison_2010_2011, :star => 0, :adu => 0)
facture = Debit.create!(:name => 'chambre agriculture', :date => '2010-12-09', :cout => 21, :ref_client => '', :ref => '050', :user => User.find_by_code('chambre_agriculture'), :factype => factype_total,:factcat => factcat_agri,:category => cat_agri_frais_generaux, :desc => '',:saison => saison_2010_2011, :star => 0, :adu => 0)
facture = Debit.create!(:name => 'divers materiel', :date => '2010-11-06', :cout => 164.06, :ref_client => '111107814', :ref => '051', :user => User.find_by_code('agro_service'), :factype => factype_total,:factcat => factcat_agri,:category => cat_agri_materiel, :desc => '',:saison => saison_2010_2011, :star => 0, :adu => 0)
facture = Debit.create!(:name => 'divers materiel', :date => '2010-11-06', :cout => 8.63, :ref_client => '111107815', :ref => '052', :user => User.find_by_code('agro_service'), :factype => factype_total,:factcat => factcat_agri,:category => cat_agri_materiel, :desc => '',:saison => saison_2010_2011, :star => 0, :adu => 0)
facture = Debit.create!(:name => 'entretien tracteur', :date => '2010-09-30', :cout => 158.83, :ref_client => 'LC090035/R', :ref => '053', :user => User.find_by_code('centragri'), :factype => factype_total,:factcat => factcat_agri,:category => cat_agri_materiel, :desc => '',:saison => saison_2010_2011, :star => 0, :adu => 0)
facture = Debit.create!(:name => 'reparation giro broyeur', :date => '2010-09-30', :cout => 261.47, :ref_client => 'BA090395/D', :ref => '054', :user => User.find_by_code('bastard'), :factype => factype_total,:factcat => factcat_agri,:category => cat_agri_materiel, :desc => '',:saison => saison_2010_2011, :star => 0, :adu => 0)
facture = Debit.create!(:name => 'Cable electrique', :date => '2010-06-24', :cout => 1127, :ref_client => '', :ref => '055', :user => User.find_by_code('seelec'), :factype => factype_total,:factcat => factcat_agri,:category => cat_agri_materiel, :desc => '',:saison => saison_2010_2011, :star => 0, :adu => 0)
facture = Debit.create!(:name => 'reparation pneu tracteur', :date => '2010-08-31', :cout => 2190.59, :ref_client => '75008102', :ref => '056', :user => User.find_by_code('pneu_europe_service'), :factype => factype_total,:factcat => factcat_agri,:category => cat_agri_materiel, :desc => '',:saison => saison_2010_2011, :star => 0, :adu => 0)
facture = Debit.create!(:name => 'pneu tracteur', :date => '2010-07-31', :cout => 121.30, :ref_client => '75007118', :ref => '057', :user => User.find_by_code('pneu_europe_service'), :factype => factype_total,:factcat => factcat_agri,:category => cat_agri_materiel, :desc => '',:saison => saison_2010_2011, :star => 0, :adu => 0)
facture = Debit.create!(:name => 'Fioul total premier', :date => '2010-10-31', :cout => 1145.18, :ref_client => '27916', :ref => '058', :user => User.find_by_code('raffault'), :factype => factype_total,:factcat => factcat_agri,:category => cat_agri_frais_generaux, :desc => '',:saison => saison_2010_2011, :star => 0, :adu => 0)
facture = Debit.create!(:name => 'Fermage MF la cot', :date => '2010-12-15', :cout => 8500, :ref_client => '', :ref => '059', :user => User.find_by_code('mflacot'), :factype => factype_total,:factcat => factcat_agri,:category => cat_agri_fermage, :desc => '',:saison => saison_2010_2011, :star => 0, :adu => 0)
facture = Debit.create!(:name => 'tuyau pvc', :date => '2010-12-10', :cout => 249.15, :ref_client => '', :ref => '060', :user => User.find_by_code('pierre_auroy_sarl'), :factype => factype_total,:factcat => factcat_maison,:category => cat_maison_batiment, :desc => '',:saison => saison_2010_2011, :star => 0, :adu => 0)
facture = Debit.create!(:name => 'reparation tracteur alternateur', :date => '2010-07-31', :cout => 556, :ref_client => 'LC070040/R', :ref => '061', :user => User.find_by_code('centragri'), :factype => factype_total,:factcat => factcat_agri,:category => cat_agri_materiel, :desc => '',:saison => saison_2010_2011, :star => 0, :adu => 0)
facture = Debit.create!(:name => 'forfait ordures agricoles', :date => '2010-10-02', :cout => 18.21, :ref_client => '00033370', :ref => '062', :user => User.find_by_code('communaute_de_communes'), :factype => factype_total,:factcat => factcat_agri,:category => cat_agri_frais_generaux, :desc => '',:saison => saison_2010_2011, :star => 0, :adu => 0)
facture = Debit.create!(:name => 'SIAEP - compteur eau', :date => '2010-11-20', :cout => 142.39, :ref_client => '02946', :ref => '063', :user => User.find_by_code('siaep'), :factype => factype_total,:factcat => factcat_agri,:category => cat_agri_frais_generaux, :desc => 'compteur 00470. troisieme trimestre 2010',:saison => saison_2010_2011, :star => 0, :adu => 0)
facture = Debit.create!(:name => 'SIAEP - compteur eau', :date => '2010-11-20', :cout => 87.91, :ref_client => '02947', :ref => '064', :user => User.find_by_code('siaep'), :factype => factype_total,:factcat => factcat_maison,:category => cat_maison_frais_generaux, :desc => 'compteur 00530. troisieme trimestre 2010',:saison => saison_2010_2011, :star => 0, :adu => 0)
facture = Debit.create!(:name => 'travaux pierres tractopelle', :date => '2010-11-06', :cout => 239.20, :ref_client => '43', :ref => '065', :user => User.find_by_code('earl_prinet'), :factype => factype_total,:factcat => factcat_agri,:category => cat_agri_service_agricole, :desc => '',:saison => saison_2010_2011, :star => 0, :adu => 0)
facture = Debit.create!(:name => 'bricolage', :date => '2011-04-07', :cout => 9.79, :ref_client => '3022', :ref => '066', :user => User.find_by_code('caci36'), :factype => factype_total,:factcat => factcat_maison,:category => cat_maison_bricolage, :desc => '',:saison => saison_2010_2011, :star => 0, :adu => 0)
facture = Debit.create!(:name => 'electricite EDF', :date => '2011-03-21', :cout => 36.34, :ref_client => '', :ref => '067', :user => User.find_by_code('edf_bleu_ciel'), :factype => factype_total,:factcat => factcat_maison,:category => cat_maison_frais_generaux, :desc => '',:saison => saison_2010_2011, :star => 0, :adu => 0)
facture = Debit.create!(:name => 'Assurance voiture c4 picasso', :date => '2010-07-08', :cout => 552.74, :ref_client => '', :ref => '068', :user => User.find_by_code('credit_agricole_assurances'), :factype => factype_total,:factcat => factcat_maison,:category => cat_maison_frais_generaux, :desc => '',:saison => saison_2010_2011, :star => 0, :adu => 0)
facture = Debit.create!(:name => 'poste a souder', :date => '2010-11-27', :cout => 391, :ref_client => 'FA09VC/2818', :ref => '069', :user => User.find_by_code('caci36'), :factype => factype_total,:factcat => factcat_maison,:category => cat_maison_bricolage, :desc => '',:saison => saison_2010_2011, :star => 0, :adu => 0)
facture = Debit.create!(:name => 'Batterie 12v', :date => '2010-12-21', :cout => 129.43, :ref_client => '', :ref => '070', :user => User.find_by_code('ebt'), :factype => factype_total,:factcat => factcat_agri,:category => cat_agri_materiel, :desc => '',:saison => saison_2010_2011, :star => 0, :adu => 0)
facture = Debit.create!(:name => 'telephone montlevic', :date => '2011-06-16', :cout => 26.99, :ref_client => '83220', :ref => '071', :user => User.find_by_code('France_telecom'), :factype => factype_total,:factcat => factcat_maison,:category => cat_maison_telephone, :desc => '',:saison => saison_2010_2011, :star => 0, :adu => 0)
facture = Debit.create!(:name => 'telephone paris', :date => '2011-06-21', :cout => 28.85, :ref_client => '', :ref => '072', :user => User.find_by_code('France_telecom'), :factype => factype_total,:factcat => factcat_maison,:category => cat_maison_telephone, :desc => '',:saison => saison_2010_2011, :star => 0, :adu => 0)
facture = Debit.create!(:name => 'telephone portable', :date => '2011-06-23', :cout => 15.05, :ref_client => '', :ref => '073', :user => User.find_by_code('c_le_mobile'), :factype => factype_total,:factcat => factcat_maison,:category => cat_maison_telephone, :desc => '',:saison => saison_2010_2011, :star => 0, :adu => 0)
facture = Debit.create!(:name => 'telephone portable', :date => '2011-04-19', :cout => 15.05, :ref_client => '', :ref => '074', :user => User.find_by_code('c_le_mobile'), :factype => factype_total,:factcat => factcat_maison,:category => cat_maison_telephone, :desc => '',:saison => saison_2010_2011, :star => 0, :adu => 0)
facture = Debit.create!(:name => 'telephone paris', :date => '2011-06-21', :cout => 28.59, :ref_client => '', :ref => '075', :user => User.find_by_code('France_telecom'), :factype => factype_total,:factcat => factcat_maison,:category => cat_maison_telephone, :desc => '',:saison => saison_2010_2011, :star => 0, :adu => 0)
facture = Debit.create!(:name => 'quincaillerie bonnin', :date => '2010-11-27', :cout => 13.04, :ref_client => '', :ref => '076', :user => User.find_by_code('bonnin'), :factype => factype_total,:factcat => factcat_maison,:category => cat_maison_bricolage, :desc => '',:saison => saison_2010_2011, :star => 0, :adu => 0)
facture = Debit.create!(:name => 'tendeur a souder', :date => '2010-07-31', :cout => 20.60, :ref_client => '', :ref => '077', :user => User.find_by_code('bricopro'), :factype => factype_total,:factcat => factcat_maison,:category => cat_maison_batiment, :desc => '',:saison => saison_2010_2011, :star => 0, :adu => 0)
facture = Debit.create!(:name => 'fenetres batiments', :date => '2010-09-24', :cout => 106.61, :ref_client => '', :ref => '078', :user => User.find_by_code('lapeyre'), :factype => factype_total,:factcat => factcat_maison,:category => cat_maison_batiment, :desc => '',:saison => saison_2010_2011, :star => 0, :adu => 0)
facture = Debit.create!(:name => 'fenetres batiments', :date => '2010-08-19', :cout => 14.21, :ref_client => '', :ref => '079', :user => User.find_by_code('lapeyre'), :factype => factype_total,:factcat => factcat_maison,:category => cat_maison_batiment, :desc => '',:saison => saison_2010_2011, :star => 0, :adu => 0)
facture = Debit.create!(:name => 'fenetres batiments', :date => '2010-08-19', :cout => 343.06, :ref_client => '', :ref => '080', :user => User.find_by_code('lapeyre'), :factype => factype_total,:factcat => factcat_maison,:category => cat_maison_batiment, :desc => '',:saison => saison_2010_2011, :star => 0, :adu => 0)
facture = Debit.create!(:name => 'fenetres batiments', :date => '2010-08-19', :cout => 321.49, :ref_client => '', :ref => '081', :user => User.find_by_code('lapeyre'), :factype => factype_total,:factcat => factcat_maison,:category => cat_maison_batiment, :desc => '',:saison => saison_2010_2011, :star => 0, :adu => 0)
facture = Debit.create!(:name => 'materiel electrique', :date => '2010-01-01', :cout => 98.03, :ref_client => '237473', :ref => '082', :user => User.find_by_code('bricodepot'), :factype => factype_total,:factcat => factcat_maison,:category => cat_maison_bricolage, :desc => '',:saison => saison_2010_2011, :star => 0, :adu => 0)
facture = Debit.create!(:name => '(terrassement hangar)', :date => '2010-09-14', :cout => 2065.19, :ref_client => '2101640', :ref => '083', :user => User.find_by_code('batiloisirs'), :factype => factype_total,:factcat => factcat_agri,:category => cat_agri_batiment, :desc => '',:saison => saison_2010_2011, :star => 0, :adu => 0)














# FIN de FACTURES - from xls
# puts "pulve.id #{pulve.id} get_cout_total_passage  #{pulve.get_cout_total_passage}"












# PULVES & LABOURS - (generation automatique xls)

 # Les Vallées - Tournesol - 11Ha

pulves = []
labours = []


pulve = Pulve.create!(:name => 'Glyphosate', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2011-03-11', :star => 1, :adu => 0, :desc => 'verifier les date (2010 ou 2011?).</br>verifier le dosage huile.')
putoproduit = Putoproduit.create!(:pulve => pulve, :produit => glifonet, :dosage => 2, :saison => saison_2010_2011)
putoproduit = Putoproduit.create!(:pulve => pulve, :produit => huile, :dosage => 1, :saison => saison_2010_2011)
Putofacture.create!(:pulve => pulve, :facture => fac_pulve, :value => pulve.get_cout_total_passage)
pulves << pulve
pulve = Pulve.create!(:name => 'Engrais 0-20-30', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2011-03-20', :star => 0, :adu => 0, :desc => '')
putoproduit = Putoproduit.create!(:pulve => pulve, :produit => zero2030, :dosage => 250, :saison => saison_2010_2011)
pulves << pulve
Putofacture.create!(:pulve => pulve, :facture => fac_engrais, :value => pulve.get_cout_total_passage)
pulve = Pulve.create!(:name => 'Semis', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2011-04-06', :star => 1, :adu => 0, :desc => 'indiquer :</br>->la variété</br>->les dosages.</br>->modifier le cout_ha_passage du semis.</br>MAS 91 : 6Ha (PMG 58g).</br>Campus : 5Ha (PMG 78g).')
#putoproduit = Putoproduit.create!(:pulve => pulve, :produit => campus, :dosage => 1, :saison => saison_2010_2011)
#putoproduit = Putoproduit.create!(:pulve => pulve, :produit => mas91, :dosage => 1, :saison => saison_2010_2011)
pulves << pulve
#Putofacture.create!(:pulve => pulve, :facture => fac_semis, :value => pulve.get_cout_total_passage)
pulve = Pulve.create!(:name => 'Cline', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2011-04-07', :star => 0, :adu => 0, :desc => '2.5 L/Ha sur 6Ha</br>=> 2,5 x 6 / 11</br>=> 1,3636')
putoproduit = Putoproduit.create!(:pulve => pulve, :produit => cline, :dosage => 1.3636, :saison => saison_2010_2011)
pulves << pulve
Putofacture.create!(:pulve => pulve, :facture => fac_pulve, :value => pulve.get_cout_total_passage)
pulve = Pulve.create!(:name => 'Challenge', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2011-04-11', :star => 0, :adu => 0, :desc => '4 L/Ha sur 5Ha</br>=> 4 x 5 / 11</br>=> 1,8182')
putoproduit = Putoproduit.create!(:pulve => pulve, :produit => challenge, :dosage => 1.8182, :saison => saison_2010_2011)
pulves << pulve
Putofacture.create!(:pulve => pulve, :facture => fac_pulve, :value => pulve.get_cout_total_passage)
pulve = Pulve.create!(:name => 'pulsar', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2011-05-20', :star => 0, :adu => 0, :desc => '1,25 L/Ha sur 6Ha</br>=> 1,25 x 6 / 11</br>=> 0,68182')
putoproduit = Putoproduit.create!(:pulve => pulve, :produit => pulsar, :dosage => 0.68182, :saison => saison_2010_2011)
pulves << pulve
Putofacture.create!(:pulve => pulve, :facture => fac_pulve, :value => pulve.get_cout_total_passage)

#labour = Labour.create!(:name => 'déchaumage blé - 1', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2010-05-01', :star => 0, :category => cat_covercrop, :desc => 'date inconnue')
#labours << labour

parcelle = saison_2010_2011.parcelles.find_by_code('vallees')
labours.each {|labour| labtoparcelle = Labtoparcelle.create!(:parcelle => parcelle, :labour => labour, :value => 0)}
pulves.each {|pulve| putoparcelle = Putoparcelle.create!(:parcelle => parcelle, :pulve => pulve, :value => 0)}




 # Champ du milieu - Tournesol - 9Ha

pulves = []
labours = []


pulve = Pulve.create!(:name => 'Glyphosate', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2011-03-11', :star => 1, :adu => 0, :desc => 'verifier les date (2010 ou 2011?).</br>verifier le dosage huile.')
putoproduit = Putoproduit.create!(:pulve => pulve, :produit => glifonet, :dosage => 2, :saison => saison_2010_2011)
putoproduit = Putoproduit.create!(:pulve => pulve, :produit => huile, :dosage => 1, :saison => saison_2010_2011)
pulves << pulve
Putofacture.create!(:pulve => pulve, :facture => fac_pulve, :value => pulve.get_cout_total_passage)
pulve = Pulve.create!(:name => 'Engrais 0-20-30', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2011-03-20', :star => 0, :adu => 0, :desc => '')
putoproduit = Putoproduit.create!(:pulve => pulve, :produit => zero2030, :dosage => 250, :saison => saison_2010_2011)
pulves << pulve
Putofacture.create!(:pulve => pulve, :facture => fac_engrais, :value => pulve.get_cout_total_passage)
pulve = Pulve.create!(:name => 'Semis', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2011-04-06', :star => 1, :adu => 0, :desc => 'modifier le cout_ha_passage et le dosage')
#putoproduit = Putoproduit.create!(:pulve => pulve, :produit => campus, :dosage => 1, :saison => saison_2010_2011)
pulves << pulve
#Putofacture.create!(:pulve => pulve, :facture => fac_semis, :value => pulve.get_cout_total_passage)
pulve = Pulve.create!(:name => 'Challenge', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2011-04-11', :star => 0, :adu => 0, :desc => '')
putoproduit = Putoproduit.create!(:pulve => pulve, :produit => challenge, :dosage => 4, :saison => saison_2010_2011)
pulves << pulve
Putofacture.create!(:pulve => pulve, :facture => fac_pulve_2, :value => pulve.get_cout_total_passage)


parcelle = saison_2010_2011.parcelles.find_by_code('champ_du_milieu')
labours.each {|labour| labtoparcelle = Labtoparcelle.create!(:parcelle => parcelle, :labour => labour, :value => 0)}
pulves.each {|pulve| putoparcelle = Putoparcelle.create!(:parcelle => parcelle, :pulve => pulve, :value => 0)}







 # Basse-cour - Colza - 2Ha

pulves = []
labours = []


pulve = Pulve.create!(:name => 'Semis', :cout_ha_passage => 31, :user => trochet, :saison => saison_2010_2011, :date => '2010-08-31', :star => 0, :adu => 0, :desc => '')
#putoproduit = Putoproduit.create!(:pulve => pulve, :produit => catalino, :dosage => 3.5, :saison => saison_2010_2011)
pulves << pulve
Putofacture.create!(:pulve => pulve, :facture => fac_semis, :value => pulve.get_cout_total_passage)
pulve = Pulve.create!(:name => 'colzamid', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2010-08-31', :star => 0, :adu => 0, :desc => '')
putoproduit = Putoproduit.create!(:pulve => pulve, :produit => colzamid, :dosage => 1.8, :saison => saison_2010_2011)
pulves << pulve
Putofacture.create!(:pulve => pulve, :facture => fac_pulve, :value => pulve.get_cout_total_passage)
pulve = Pulve.create!(:name => 'springbok', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2010-09-02', :star => 0, :adu => 0, :desc => '')
putoproduit = Putoproduit.create!(:pulve => pulve, :produit => springbok, :dosage => 2.5, :saison => saison_2010_2011)
pulves << pulve
Putofacture.create!(:pulve => pulve, :facture => fac_pulve, :value => pulve.get_cout_total_passage)
pulve = Pulve.create!(:name => 'Folyr', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2010-10-07', :star => 0, :adu => 0, :desc => '')
putoproduit = Putoproduit.create!(:pulve => pulve, :produit => folyr, :dosage => 0.6, :saison => saison_2010_2011)
putoproduit = Putoproduit.create!(:pulve => pulve, :produit => huile, :dosage => 1, :saison => saison_2010_2011)
putoproduit = Putoproduit.create!(:pulve => pulve, :produit => fury, :dosage => 0.1, :saison => saison_2010_2011)
pulves << pulve
Putofacture.create!(:pulve => pulve, :facture => fac_pulve_2, :value => pulve.get_cout_total_passage)
pulve = Pulve.create!(:name => '0-20-30', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2011-01-23', :star => 0, :adu => 0, :desc => '')
putoproduit = Putoproduit.create!(:pulve => pulve, :produit => zero2030, :dosage => 200, :saison => saison_2010_2011)
pulves << pulve
Putofacture.create!(:pulve => pulve, :facture => fac_engrais, :value => pulve.get_cout_total_passage)
pulve = Pulve.create!(:name => 'Azote', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2011-02-08', :star => 0, :adu => 0, :desc => '81u.</br>N°38 (? Cf carnet trochet)')
putoproduit = Putoproduit.create!(:pulve => pulve, :produit => azote, :dosage => 243, :saison => saison_2010_2011)
pulves << pulve
Putofacture.create!(:pulve => pulve, :facture => fac_engrais, :value => pulve.get_cout_total_passage)
pulve = Pulve.create!(:name => 'Stratos', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2011-02-10', :star => 0, :adu => 0, :desc => '')
putoproduit = Putoproduit.create!(:pulve => pulve, :produit => stratos, :dosage => 2, :saison => saison_2010_2011)
pulves << pulve
Putofacture.create!(:pulve => pulve, :facture => fac_pulve_2, :value => pulve.get_cout_total_passage)
pulve = Pulve.create!(:name => 'Azote', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2011-03-03', :star => 0, :adu => 0, :desc => '94u.</br>N°40')
putoproduit = Putoproduit.create!(:pulve => pulve, :produit => azote, :dosage => 281, :saison => saison_2010_2011)
pulves << pulve
Putofacture.create!(:pulve => pulve, :facture => fac_engrais, :value => pulve.get_cout_total_passage)
pulve = Pulve.create!(:name => 'Soufre', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2011-03-08', :star => 0, :adu => 0, :desc => '')
putoproduit = Putoproduit.create!(:pulve => pulve, :produit => azomag, :dosage => 150, :saison => saison_2010_2011)
pulves << pulve
Putofacture.create!(:pulve => pulve, :facture => fac_engrais, :value => pulve.get_cout_total_passage)
pulve = Pulve.create!(:name => 'Fury', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2011-03-08', :star => 0, :adu => 0, :desc => '')
putoproduit = Putoproduit.create!(:pulve => pulve, :produit => fury, :dosage => 0.1, :saison => saison_2010_2011)
Putofacture.create!(:pulve => pulve, :facture => fac_pulve_2, :value => pulve.get_cout_total_passage)
pulves << pulve
pulve = Pulve.create!(:name => 'chrono', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2011-03-08', :star => 0, :adu => 0, :desc => '')
putoproduit = Putoproduit.create!(:pulve => pulve, :produit => chrono, :dosage => 1.25, :saison => saison_2010_2011)
putoproduit = Putoproduit.create!(:pulve => pulve, :produit => lontrel, :dosage => 1, :saison => saison_2010_2011)
pulves << pulve
Putofacture.create!(:pulve => pulve, :facture => fac_pulve_2, :value => pulve.get_cout_total_passage)
pulve = Pulve.create!(:name => 'picabore', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2011-03-20', :star => 0, :adu => 0, :desc => '')
putoproduit = Putoproduit.create!(:pulve => pulve, :produit => picabore, :dosage => 2.5, :saison => saison_2010_2011)
putoproduit = Putoproduit.create!(:pulve => pulve, :produit => proteus, :dosage => 0.5, :saison => saison_2010_2011)
pulves << pulve
Putofacture.create!(:pulve => pulve, :facture => fac_pulve_2, :value => pulve.get_cout_total_passage)
pulve = Pulve.create!(:name => 'Surnog', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2011-04-02', :star => 0, :adu => 0, :desc => '')
putoproduit = Putoproduit.create!(:pulve => pulve, :produit => surnog, :dosage => 0.6, :saison => saison_2010_2011)
pulves << pulve
Putofacture.create!(:pulve => pulve, :facture => fac_pulve_2, :value => pulve.get_cout_total_passage)
pulve = Pulve.create!(:name => 'amistar_xtra', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2011-04-20', :star => 0, :adu => 0, :desc => '')
putoproduit = Putoproduit.create!(:pulve => pulve, :produit => amistar_xtra, :dosage => 0.75, :saison => saison_2010_2011)
pulves << pulve
Putofacture.create!(:pulve => pulve, :facture => fac_pulve_2, :value => pulve.get_cout_total_passage)




parcelle = saison_2010_2011.parcelles.find_by_code('basse_cour')
labours.each {|labour| labtoparcelle = Labtoparcelle.create!(:parcelle => parcelle, :labour => labour, :value => 0)}
pulves.each {|pulve| putoparcelle = Putoparcelle.create!(:parcelle => parcelle, :pulve => pulve, :value => 0)}






 # Derriere - Colza - 14Ha

pulves = []
labours = []


pulve = Pulve.create!(:name => 'Semis', :cout_ha_passage => 31, :user => trochet, :saison => saison_2010_2011, :date => '2010-08-30', :star => 1, :adu => 0, :desc => 'dosage reel = 3.5Kg/Ha.</br>Selection Ovation au milieu entre les deux poteaux, voir plan)')
#putoproduit = Putoproduit.create!(:pulve => pulve, :produit => catalino, :dosage => 2, :saison => saison_2010_2011)
#putoproduit = Putoproduit.create!(:pulve => pulve, :produit => ovation, :dosage => 1.5, :saison => saison_2010_2011)
pulves << pulve
Putofacture.create!(:pulve => pulve, :facture => fac_semis, :value => pulve.get_cout_total_passage)
pulve = Pulve.create!(:name => 'colzamid', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2010-08-30', :star => 0, :adu => 0, :desc => '')
putoproduit = Putoproduit.create!(:pulve => pulve, :produit => colzamid, :dosage => 1.8, :saison => saison_2010_2011)
pulves << pulve
Putofacture.create!(:pulve => pulve, :facture => fac_pulve, :value => pulve.get_cout_total_passage)
pulve = Pulve.create!(:name => 'springbok', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2010-09-02', :star => 0, :adu => 0, :desc => '')
putoproduit = Putoproduit.create!(:pulve => pulve, :produit => springbok, :dosage => 2.5, :saison => saison_2010_2011)
pulves << pulve
Putofacture.create!(:pulve => pulve, :facture => fac_pulve_2, :value => pulve.get_cout_total_passage)
pulve = Pulve.create!(:name => 'Folyr', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2010-10-07', :star => 0, :adu => 0, :desc => '')
putoproduit = Putoproduit.create!(:pulve => pulve, :produit => folyr, :dosage => 0.6, :saison => saison_2010_2011)
putoproduit = Putoproduit.create!(:pulve => pulve, :produit => huile, :dosage => 1, :saison => saison_2010_2011)
putoproduit = Putoproduit.create!(:pulve => pulve, :produit => fury, :dosage => 0.1, :saison => saison_2010_2011)
pulves << pulve
Putofacture.create!(:pulve => pulve, :facture => fac_pulve_2, :value => pulve.get_cout_total_passage)
pulve = Pulve.create!(:name => '0-20-30', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2011-01-23', :star => 0, :adu => 0, :desc => '')
putoproduit = Putoproduit.create!(:pulve => pulve, :produit => zero2030, :dosage => 200, :saison => saison_2010_2011)
pulves << pulve
Putofacture.create!(:pulve => pulve, :facture => fac_engrais, :value => pulve.get_cout_total_passage)
pulve = Pulve.create!(:name => 'Azote', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2011-02-08', :star => 0, :adu => 0, :desc => '81u.</br>N°38')
putoproduit = Putoproduit.create!(:pulve => pulve, :produit => azote, :dosage => 243, :saison => saison_2010_2011)
pulves << pulve
Putofacture.create!(:pulve => pulve, :facture => fac_engrais, :value => pulve.get_cout_total_passage)
pulve = Pulve.create!(:name => 'Azote', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2011-03-03', :star => 0, :adu => 0, :desc => '94u.</br>N°40')
putoproduit = Putoproduit.create!(:pulve => pulve, :produit => azote, :dosage => 280, :saison => saison_2010_2011)
pulves << pulve
Putofacture.create!(:pulve => pulve, :facture => fac_engrais, :value => pulve.get_cout_total_passage)
pulve = Pulve.create!(:name => 'Soufre', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2011-03-08', :star => 0, :adu => 0, :desc => '')
putoproduit = Putoproduit.create!(:pulve => pulve, :produit => azomag, :dosage => 150, :saison => saison_2010_2011)
pulves << pulve
Putofacture.create!(:pulve => pulve, :facture => fac_engrais, :value => pulve.get_cout_total_passage)
pulve = Pulve.create!(:name => 'Fury', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2011-03-09', :star => 0, :adu => 0, :desc => '')
putoproduit = Putoproduit.create!(:pulve => pulve, :produit => fury, :dosage => 0.1, :saison => saison_2010_2011)
pulves << pulve
Putofacture.create!(:pulve => pulve, :facture => fac_pulve_2, :value => pulve.get_cout_total_passage)
pulve = Pulve.create!(:name => 'chrono', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2011-03-08', :star => 0, :adu => 0, :desc => 'dosages reel sur 8Ha:</br>chrono : 1,25L/Ha.</br>lontrel : 1L/Ha.')
putoproduit = Putoproduit.create!(:pulve => pulve, :produit => chrono, :dosage => 0.714, :saison => saison_2010_2011)
putoproduit = Putoproduit.create!(:pulve => pulve, :produit => lontrel, :dosage => 0.571, :saison => saison_2010_2011)
pulves << pulve
Putofacture.create!(:pulve => pulve, :facture => fac_pulve_2, :value => pulve.get_cout_total_passage)
pulve = Pulve.create!(:name => 'picabore', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2011-03-24', :star => 0, :adu => 0, :desc => '')
putoproduit = Putoproduit.create!(:pulve => pulve, :produit => picabore, :dosage => 2.5, :saison => saison_2010_2011)
putoproduit = Putoproduit.create!(:pulve => pulve, :produit => proteus, :dosage => 0.5, :saison => saison_2010_2011)
pulves << pulve
Putofacture.create!(:pulve => pulve, :facture => fac_pulve_2, :value => pulve.get_cout_total_passage)
pulve = Pulve.create!(:name => 'Surnog', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2011-04-02', :star => 0, :adu => 0, :desc => '')
putoproduit = Putoproduit.create!(:pulve => pulve, :produit => surnog, :dosage => 0.6, :saison => saison_2010_2011)
pulves << pulve
Putofacture.create!(:pulve => pulve, :facture => fac_pulve_2, :value => pulve.get_cout_total_passage)
pulve = Pulve.create!(:name => 'amistar_xtra', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2011-04-20', :star => 0, :adu => 0, :desc => '')
putoproduit = Putoproduit.create!(:pulve => pulve, :produit => amistar_xtra, :dosage => 0.75, :saison => saison_2010_2011)
pulves << pulve
Putofacture.create!(:pulve => pulve, :facture => fac_pulve_2, :value => pulve.get_cout_total_passage)



parcelle = saison_2010_2011.parcelles.find_by_code('derriere')
labours.each {|labour| labtoparcelle = Labtoparcelle.create!(:parcelle => parcelle, :labour => labour, :value => 0)}
pulves.each {|pulve| putoparcelle = Putoparcelle.create!(:parcelle => parcelle, :pulve => pulve, :value => 0)}







 # Pont des Champs - Blé - 10Ha

pulves = []
labours = []


pulve = Pulve.create!(:name => 'glyphosate', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2010-10-01', :star => 0, :adu => 0, :desc => '')
putoproduit = Putoproduit.create!(:pulve => pulve, :produit => glifonet, :dosage => 5, :saison => saison_2010_2011)
pulves << pulve
Putofacture.create!(:pulve => pulve, :facture => fac_pulve, :value => pulve.get_cout_total_passage)
pulve = Pulve.create!(:name => 'semis', :cout_ha_passage => 31, :user => trochet, :saison => saison_2010_2011, :date => '2010-10-22', :star => 0, :adu => 0, :desc => 'dosage réel=180.</br>début Richepin, fin PR.</br>N°43')
#putoproduit = Putoproduit.create!(:pulve => pulve, :produit => richepain, :dosage => 1, :saison => saison_2010_2011)
#putoproduit = Putoproduit.create!(:pulve => pulve, :produit => pr, :dosage => 1, :saison => saison_2010_2011)
pulves << pulve
Putofacture.create!(:pulve => pulve, :facture => fac_semis, :value => pulve.get_cout_total_passage)
pulve = Pulve.create!(:name => 'Super 45', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2011-01-20', :star => 0, :adu => 0, :desc => '')
putoproduit = Putoproduit.create!(:pulve => pulve, :produit => super45, :dosage => 153, :saison => saison_2010_2011)
pulves << pulve
Putofacture.create!(:pulve => pulve, :facture => fac_engrais, :value => pulve.get_cout_total_passage)
pulve = Pulve.create!(:name => 'Azote', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2011-02-08', :star => 0, :adu => 0, :desc => '')
putoproduit = Putoproduit.create!(:pulve => pulve, :produit => azote, :dosage => 200, :saison => saison_2010_2011)
pulves << pulve
Putofacture.create!(:pulve => pulve, :facture => fac_engrais, :value => pulve.get_cout_total_passage)
pulve = Pulve.create!(:name => 'Azote', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2011-03-03', :star => 0, :adu => 0, :desc => '')
putoproduit = Putoproduit.create!(:pulve => pulve, :produit => azote, :dosage => 237, :saison => saison_2010_2011)
pulves << pulve
Putofacture.create!(:pulve => pulve, :facture => fac_engrais, :value => pulve.get_cout_total_passage)
pulve = Pulve.create!(:name => 'Soufre', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2011-03-09', :star => 0, :adu => 0, :desc => '')
putoproduit = Putoproduit.create!(:pulve => pulve, :produit => azomag, :dosage => 100, :saison => saison_2010_2011)
pulves << pulve
Putofacture.create!(:pulve => pulve, :facture => fac_pulve_2, :value => pulve.get_cout_total_passage)
pulve = Pulve.create!(:name => 'Radar', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2011-03-09', :star => 0, :adu => 0, :desc => '')
putoproduit = Putoproduit.create!(:pulve => pulve, :produit => radar, :dosage => 0.275, :saison => saison_2010_2011)
pulves << pulve
Putofacture.create!(:pulve => pulve, :facture => fac_pulve_2, :value => pulve.get_cout_total_passage)
pulve = Pulve.create!(:name => 'Proca', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2011-04-04', :star => 1, :adu => 0, :desc => 'PZ (?)')
putoproduit = Putoproduit.create!(:pulve => pulve, :produit => proca, :dosage => 1, :saison => saison_2010_2011)
pulves << pulve
Putofacture.create!(:pulve => pulve, :facture => fac_pulve_2, :value => pulve.get_cout_total_passage)
pulve = Pulve.create!(:name => 'Vip', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2011-04-20', :star => 1, :adu => 0, :desc => 'dosage huile?')
putoproduit = Putoproduit.create!(:pulve => pulve, :produit => vip, :dosage => 0.5, :saison => saison_2010_2011)
putoproduit = Putoproduit.create!(:pulve => pulve, :produit => huile, :dosage => 1, :saison => saison_2010_2011)
pulves << pulve
Putofacture.create!(:pulve => pulve, :facture => fac_pulve_2, :value => pulve.get_cout_total_passage)
pulve = Pulve.create!(:name => 'Baravo Elite', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2011-04-30', :star => 0, :adu => 0, :desc => '')
putoproduit = Putoproduit.create!(:pulve => pulve, :produit => bravo_elite, :dosage => 1.4, :saison => saison_2010_2011)
pulves << pulve
Putofacture.create!(:pulve => pulve, :facture => fac_pulve_2, :value => pulve.get_cout_total_passage)
pulve = Pulve.create!(:name => 'Ariane', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2011-05-04', :star => 0, :adu => 0, :desc => '')
putoproduit = Putoproduit.create!(:pulve => pulve, :produit => ariane, :dosage => 3, :saison => saison_2010_2011)
pulves << pulve
Putofacture.create!(:pulve => pulve, :facture => fac_pulve_2, :value => pulve.get_cout_total_passage)



parcelle = saison_2010_2011.parcelles.find_by_code('pont_des_champs')
labours.each {|labour| labtoparcelle = Labtoparcelle.create!(:parcelle => parcelle, :labour => labour, :value => 0)}
pulves.each {|pulve| putoparcelle = Putoparcelle.create!(:parcelle => parcelle, :pulve => pulve, :value => 0)}







 # aeromodelisme - Blé - 14Ha

pulves = []
labours = []


pulve = Pulve.create!(:name => 'glyphosate', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2010-09-30', :star => 0, :adu => 0, :desc => '')
putoproduit = Putoproduit.create!(:pulve => pulve, :produit => glifonet, :dosage => 2, :saison => saison_2010_2011)
putoproduit = Putoproduit.create!(:pulve => pulve, :produit => chardol, :dosage => 0.6, :saison => saison_2010_2011)
pulves << pulve
Putofacture.create!(:pulve => pulve, :facture => fac_pulve, :value => pulve.get_cout_total_passage)
pulve = Pulve.create!(:name => 'semis', :cout_ha_passage => 31, :user => trochet, :saison => saison_2010_2011, :date => '2010-10-20', :star => 0, :adu => 0, :desc => 'dosage reel 175kg/Ha.</br>N°42.')
#putoproduit = Putoproduit.create!(:pulve => pulve, :produit => pr, :dosage => 1, :saison => saison_2010_2011)
#putoproduit = Putoproduit.create!(:pulve => pulve, :produit => paledor, :dosage => 1, :saison => saison_2010_2011)
pulves << pulve
Putofacture.create!(:pulve => pulve, :facture => fac_semis, :value => pulve.get_cout_total_passage)
pulve = Pulve.create!(:name => 'Super 45', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2011-01-20', :star => 0, :adu => 0, :desc => '')
putoproduit = Putoproduit.create!(:pulve => pulve, :produit => super45, :dosage => 153, :saison => saison_2010_2011)
pulves << pulve
Putofacture.create!(:pulve => pulve, :facture => fac_engrais, :value => pulve.get_cout_total_passage)
pulve = Pulve.create!(:name => 'Azote', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2011-02-08', :star => 0, :adu => 0, :desc => '')
putoproduit = Putoproduit.create!(:pulve => pulve, :produit => azote, :dosage => 200, :saison => saison_2010_2011)
pulves << pulve
Putofacture.create!(:pulve => pulve, :facture => fac_engrais, :value => pulve.get_cout_total_passage)
pulve = Pulve.create!(:name => 'Radar', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2011-02-11', :star => 1, :adu => 0, :desc => 'dosage huile?')
putoproduit = Putoproduit.create!(:pulve => pulve, :produit => radar, :dosage => 0.275, :saison => saison_2010_2011)
putoproduit = Putoproduit.create!(:pulve => pulve, :produit => huile, :dosage => 1, :saison => saison_2010_2011)
pulves << pulve
Putofacture.create!(:pulve => pulve, :facture => fac_pulve_2, :value => pulve.get_cout_total_passage)
pulve = Pulve.create!(:name => 'Azote', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2011-03-03', :star => 0, :adu => 0, :desc => '')
putoproduit = Putoproduit.create!(:pulve => pulve, :produit => azote, :dosage => 237, :saison => saison_2010_2011)
pulves << pulve
Putofacture.create!(:pulve => pulve, :facture => fac_engrais, :value => pulve.get_cout_total_passage)
pulve = Pulve.create!(:name => 'Soufre', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2011-03-09', :star => 0, :adu => 0, :desc => '')
putoproduit = Putoproduit.create!(:pulve => pulve, :produit => azomag, :dosage => 100, :saison => saison_2010_2011)
pulves << pulve
Putofacture.create!(:pulve => pulve, :facture => fac_pulve_2, :value => pulve.get_cout_total_passage)
pulve = Pulve.create!(:name => 'Proca', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2011-04-04', :star => 1, :adu => 0, :desc => 'PZ (?)')
putoproduit = Putoproduit.create!(:pulve => pulve, :produit => proca, :dosage => 1, :saison => saison_2010_2011)
pulves << pulve
Putofacture.create!(:pulve => pulve, :facture => fac_pulve_2, :value => pulve.get_cout_total_passage)
pulve = Pulve.create!(:name => 'Vip', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2011-04-21', :star => 1, :adu => 0, :desc => 'traxos sur 8,3 Ha</br>(remplace Vip).</br>Vip sur 5.7 Ha')
putoproduit = Putoproduit.create!(:pulve => pulve, :produit => traxos, :dosage => 0.711, :saison => saison_2010_2011)
putoproduit = Putoproduit.create!(:pulve => pulve, :produit => vip, :dosage => 0.2036, :saison => saison_2010_2011)
putoproduit = Putoproduit.create!(:pulve => pulve, :produit => huile, :dosage => 1, :saison => saison_2010_2011)
pulves << pulve
Putofacture.create!(:pulve => pulve, :facture => fac_pulve_2, :value => pulve.get_cout_total_passage)
pulve = Pulve.create!(:name => 'Bravo Elite', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2011-04-30', :star => 0, :adu => 0, :desc => '')
putoproduit = Putoproduit.create!(:pulve => pulve, :produit => bravo_elite, :dosage => 1.4, :saison => saison_2010_2011)
pulves << pulve
Putofacture.create!(:pulve => pulve, :facture => fac_pulve_2, :value => pulve.get_cout_total_passage)




parcelle = saison_2010_2011.parcelles.find_by_code('aeromodelisme')
labours.each {|labour| labtoparcelle = Labtoparcelle.create!(:parcelle => parcelle, :labour => labour, :value => 0)}
pulves.each {|pulve| putoparcelle = Putoparcelle.create!(:parcelle => parcelle, :pulve => pulve, :value => 0)}






 # Mitant - Blé - 5 Ha

pulves = []
labours = []


pulve = Pulve.create!(:name => 'glyphosate', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2010-09-30', :star => 0, :adu => 0, :desc => '')
putoproduit = Putoproduit.create!(:pulve => pulve, :produit => glifonet, :dosage => 2, :saison => saison_2010_2011)
putoproduit = Putoproduit.create!(:pulve => pulve, :produit => chardol, :dosage => 0.6, :saison => saison_2010_2011)
pulves << pulve
Putofacture.create!(:pulve => pulve, :facture => fac_pulve_2, :value => pulve.get_cout_total_passage)
pulve = Pulve.create!(:name => 'semis', :cout_ha_passage => 31, :user => trochet, :saison => saison_2010_2011, :date => '2010-10-21', :star => 0, :adu => 0, :desc => 'dosage reel 165kg/Ha.</br>(Voir plan?)')
#putoproduit = Putoproduit.create!(:pulve => pulve, :produit => pr, :dosage => 55, :saison => saison_2010_2011)
#putoproduit = Putoproduit.create!(:pulve => pulve, :produit => paledor, :dosage => 55, :saison => saison_2010_2011)
#putoproduit = Putoproduit.create!(:pulve => pulve, :produit => altigo, :dosage => 55, :saison => saison_2010_2011)
Putofacture.create!(:pulve => pulve, :facture => fac_semis, :value => pulve.get_cout_total_passage)
pulves << pulve
pulve = Pulve.create!(:name => 'Super 45', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2011-01-20', :star => 0, :adu => 0, :desc => '')
putoproduit = Putoproduit.create!(:pulve => pulve, :produit => super45, :dosage => 153, :saison => saison_2010_2011)
pulves << pulve
Putofacture.create!(:pulve => pulve, :facture => fac_engrais, :value => pulve.get_cout_total_passage)
pulve = Pulve.create!(:name => 'Azote', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2011-02-08', :star => 0, :adu => 0, :desc => '')
putoproduit = Putoproduit.create!(:pulve => pulve, :produit => azote, :dosage => 200, :saison => saison_2010_2011)
pulves << pulve
Putofacture.create!(:pulve => pulve, :facture => fac_engrais, :value => pulve.get_cout_total_passage)
pulve = Pulve.create!(:name => 'Azote', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2011-03-03', :star => 0, :adu => 0, :desc => '')
putoproduit = Putoproduit.create!(:pulve => pulve, :produit => azote, :dosage => 237, :saison => saison_2010_2011)
pulves << pulve
Putofacture.create!(:pulve => pulve, :facture => fac_engrais, :value => pulve.get_cout_total_passage)
pulve = Pulve.create!(:name => 'Soufre', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2011-03-09', :star => 0, :adu => 0, :desc => '')
putoproduit = Putoproduit.create!(:pulve => pulve, :produit => azomag, :dosage => 100, :saison => saison_2010_2011)
pulves << pulve
Putofacture.create!(:pulve => pulve, :facture => fac_pulve_2, :value => pulve.get_cout_total_passage)
pulve = Pulve.create!(:name => 'Radar', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2011-03-14', :star => 1, :adu => 0, :desc => 'dosage huile?')
putoproduit = Putoproduit.create!(:pulve => pulve, :produit => radar, :dosage => 0.275, :saison => saison_2010_2011)
putoproduit = Putoproduit.create!(:pulve => pulve, :produit => huile, :dosage => 1, :saison => saison_2010_2011)
pulves << pulve
Putofacture.create!(:pulve => pulve, :facture => fac_pulve_2, :value => pulve.get_cout_total_passage)
pulve = Pulve.create!(:name => 'Proca', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2011-04-04', :star => 1, :adu => 0, :desc => 'PZ (?)')
putoproduit = Putoproduit.create!(:pulve => pulve, :produit => proca, :dosage => 1, :saison => saison_2010_2011)
pulves << pulve
Putofacture.create!(:pulve => pulve, :facture => fac_pulve_2, :value => pulve.get_cout_total_passage)
pulve = Pulve.create!(:name => 'Vip', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2011-04-21', :star => 1, :adu => 0, :desc => 'dosage reel : 0,5L/Ha sur 2.5 Ha.')
putoproduit = Putoproduit.create!(:pulve => pulve, :produit => vip, :dosage => 0.25, :saison => saison_2010_2011)
putoproduit = Putoproduit.create!(:pulve => pulve, :produit => huile, :dosage => 0.5, :saison => saison_2010_2011)
pulves << pulve
Putofacture.create!(:pulve => pulve, :facture => fac_pulve_2, :value => pulve.get_cout_total_passage)
pulve = Pulve.create!(:name => 'Bravo Elite', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2011-04-30', :star => 0, :adu => 0, :desc => '')
putoproduit = Putoproduit.create!(:pulve => pulve, :produit => bravo_elite, :dosage => 1.4, :saison => saison_2010_2011)
pulves << pulve
Putofacture.create!(:pulve => pulve, :facture => fac_pulve_2, :value => pulve.get_cout_total_passage)



parcelle = saison_2010_2011.parcelles.find_by_code('mitant')
labours.each {|labour| labtoparcelle = Labtoparcelle.create!(:parcelle => parcelle, :labour => labour, :value => 0)}
pulves.each {|pulve| putoparcelle = Putoparcelle.create!(:parcelle => parcelle, :pulve => pulve, :value => 0)}







 # Bons Pains - Blé - 14 Ha

pulves = []
labours = []


pulve = Pulve.create!(:name => 'glyphosate', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2010-09-30', :star => 0, :adu => 0, :desc => '')
putoproduit = Putoproduit.create!(:pulve => pulve, :produit => glifonet, :dosage => 2, :saison => saison_2010_2011)
putoproduit = Putoproduit.create!(:pulve => pulve, :produit => chardol, :dosage => 0.6, :saison => saison_2010_2011)
pulves << pulve
Putofacture.create!(:pulve => pulve, :facture => fac_pulve_2, :value => pulve.get_cout_total_passage)
pulve = Pulve.create!(:name => 'semis', :cout_ha_passage => 31, :user => trochet, :saison => saison_2010_2011, :date => '2010-10-21', :star => 0, :adu => 0, :desc => 'dosage reel 171kg/Ha.</br>(Richepain au Tour?)</br>N°42')
#putoproduit = Putoproduit.create!(:pulve => pulve, :produit => richepain, :dosage => 85.5, :saison => saison_2010_2011)
#putoproduit = Putoproduit.create!(:pulve => pulve, :produit => paledor, :dosage => 85.5, :saison => saison_2010_2011)
pulves << pulve
Putofacture.create!(:pulve => pulve, :facture => fac_semis, :value => pulve.get_cout_total_passage)
pulve = Pulve.create!(:name => 'Super 45', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2011-01-20', :star => 0, :adu => 0, :desc => '')
putoproduit = Putoproduit.create!(:pulve => pulve, :produit => super45, :dosage => 153, :saison => saison_2010_2011)
pulves << pulve
Putofacture.create!(:pulve => pulve, :facture => fac_engrais, :value => pulve.get_cout_total_passage)
pulve = Pulve.create!(:name => 'Azote', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2011-02-08', :star => 0, :adu => 0, :desc => '')
putoproduit = Putoproduit.create!(:pulve => pulve, :produit => azote, :dosage => 200, :saison => saison_2010_2011)
pulves << pulve
Putofacture.create!(:pulve => pulve, :facture => fac_engrais, :value => pulve.get_cout_total_passage)
pulve = Pulve.create!(:name => 'Radar', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2011-02-11', :star => 1, :adu => 0, :desc => 'dosage huile?')
putoproduit = Putoproduit.create!(:pulve => pulve, :produit => radar, :dosage => 0.275, :saison => saison_2010_2011)
putoproduit = Putoproduit.create!(:pulve => pulve, :produit => huile, :dosage => 1, :saison => saison_2010_2011)
pulves << pulve
Putofacture.create!(:pulve => pulve, :facture => fac_engrais, :value => pulve.get_cout_total_passage)
pulve = Pulve.create!(:name => 'Azote', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2011-03-03', :star => 0, :adu => 0, :desc => '')
putoproduit = Putoproduit.create!(:pulve => pulve, :produit => azote, :dosage => 237, :saison => saison_2010_2011)
pulves << pulve
Putofacture.create!(:pulve => pulve, :facture => fac_engrais, :value => pulve.get_cout_total_passage)
pulve = Pulve.create!(:name => 'Soufre', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2011-03-09', :star => 0, :adu => 0, :desc => '')
putoproduit = Putoproduit.create!(:pulve => pulve, :produit => azomag, :dosage => 100, :saison => saison_2010_2011)
pulves << pulve
Putofacture.create!(:pulve => pulve, :facture => fac_pulve_2, :value => pulve.get_cout_total_passage)
pulve = Pulve.create!(:name => 'Proca', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2011-04-04', :star => 1, :adu => 0, :desc => 'PZ (?)')
putoproduit = Putoproduit.create!(:pulve => pulve, :produit => proca, :dosage => 1, :saison => saison_2010_2011)
pulves << pulve
Putofacture.create!(:pulve => pulve, :facture => fac_pulve_2, :value => pulve.get_cout_total_passage)
pulve = Pulve.create!(:name => 'Bravo Elite', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2011-04-30', :star => 0, :adu => 0, :desc => '')
putoproduit = Putoproduit.create!(:pulve => pulve, :produit => bravo_elite, :dosage => 1.4, :saison => saison_2010_2011)
pulves << pulve
Putofacture.create!(:pulve => pulve, :facture => fac_pulve_2, :value => pulve.get_cout_total_passage)

parcelle = saison_2010_2011.parcelles.find_by_code('bons_pains')
labours.each {|labour| labtoparcelle = Labtoparcelle.create!(:parcelle => parcelle, :labour => labour, :value => 0)}
pulves.each {|pulve| putoparcelle = Putoparcelle.create!(:parcelle => parcelle, :pulve => pulve, :value => 0)}















# FIN PULVES & LABOURS


# VENTES - from xls

vente = Vente.create!(:name => 'Moulin - paille ble', :date => '2011-08-01', :prix => 2324, :ref_client => '', :ref => '001', :user => User.find_by_name('Moulin'),:category => cat_vente_paille_foin, :desc => '',:saison => saison_2010_2011, :star => 0, :adu => 0)
parcelles_ble.each {|p| ventoparcelle = Ventoparcelle.create!(:parcelle => p, :vente => vente)}
vente = Vente.create!(:name => 'Demanus - paille colza', :date => '2011-08-01', :prix => 640, :ref_client => '', :ref => '002', :user => User.find_by_name('Demanus'),:category => cat_vente_paille_foin, :desc => '',:saison => saison_2010_2011, :star => 0, :adu => 0)
parcelles_colza.each {|p| ventoparcelle = Ventoparcelle.create!(:parcelle => p, :vente => vente)}
vente = Vente.create!(:name => 'Dumont - paille ble', :date => '2011-08-01', :prix => 1685, :ref_client => '', :ref => '003', :user => User.find_by_name('Dumont'),:category => cat_vente_paille_foin, :desc => '',:saison => saison_2010_2011, :star => 0, :adu => 0)
parcelles_ble.each {|p| ventoparcelle = Ventoparcelle.create!(:parcelle => p, :vente => vente)}
vente = Vente.create!(:name => 'Medard - foin', :date => '2011-08-01', :prix => 4240, :ref_client => '', :ref => '004', :user => User.find_by_name('Medard'),:category => cat_vente_paille_foin, :desc => '',:saison => saison_2010_2011, :star => 0, :adu => 0)
parcelles_foin.each {|p| ventoparcelle = Ventoparcelle.create!(:parcelle => p, :vente => vente)}
vente = Vente.create!(:name => 'Aussourd - foin', :date => '2011-08-01', :prix => 1976, :ref_client => '', :ref => '005', :user => User.find_by_name('Aussourd'),:category => cat_vente_paille_foin, :desc => '',:saison => saison_2010_2011, :star => 0, :adu => 0)
parcelles_foin.each {|p| ventoparcelle = Ventoparcelle.create!(:parcelle => p, :vente => vente)}
vente = Vente.create!(:name => 'Coutillet - foin', :date => '2011-08-01', :prix => 2000, :ref_client => '', :ref => '006', :user => User.find_by_name('Coutillet'),:category => cat_vente_paille_foin, :desc => '',:saison => saison_2010_2011, :star => 0, :adu => 0)
parcelles_foin.each {|p| ventoparcelle = Ventoparcelle.create!(:parcelle => p, :vente => vente)}
vente = Vente.create!(:name => 'Groupama - Assurance', :date => '2011-08-02', :prix => 21647, :ref_client => '', :ref => '007', :user => User.find_by_name('Groupama'),:category => cat_vente_assurance, :desc => '',:saison => saison_2010_2011, :star => 0, :adu => 0)
parcelles_ble.each {|p| ventoparcelle = Ventoparcelle.create!(:parcelle => p, :vente => vente)}
vente = Vente.create!(:name => 'Dauger - Ble', :date => '2011-01-20', :prix => 15289.50, :ref_client => 'VPV-01-2010-727', :ref => '', :user => User.find_by_name('Dauger'),:category => cat_vente_ble, :desc => '',:saison => saison_2010_2011, :star => 0, :adu => 0)
parcelles_ble.each {|p| ventoparcelle = Ventoparcelle.create!(:parcelle => p, :vente => vente)}





# FIN VENTES - from xls


















# NE PAS SUPPRIMER

# positionne correctement le champ value des Putofacture
# cecie ne peut pas etre fait juste apres la creation des pulve car les putoparcelles ne sont pas encore crees
# ATTENTION ceci ecrase l'ensemble des Putofactures
Putofacture.find(:all).each do |putof|
  putof.value = putof.pulve.get_cout_total_passage
  putof.save!
end



# Mise a jour des Stocks
saison_2010_2011.update_protofacture_stock
