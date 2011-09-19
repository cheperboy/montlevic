# TODO
# -> modifier les labours de chaque parcelle

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
typeculture = Typeculture.find(:first)

# Factypes
factype_diff = Factype.find_by_name("diff")
factype_null = Factype.find_by_name("null")
factype_total = Factype.find_by_name("total")

# Factcat
factcat_agri = Factcat.find_by_name("agri")

#Saison
saison_test = Saison.create!(:name => "2010/2011", :year => "2010")
Setting.find(:first).update_attribute(:saison_id,	saison_test.id )


# PARCELLES
# {:name => "zone1",            :surface => 10},     # a supprimer
# {:name => "zone2",            :surface => 100},    # a supprimer
# {:name => "zone3",            :surface => 200},    # a supprimer

# zone A
zone = Zone.find_by_name('zoneA')
parcelle = Parcelle.create!(:name => 'parcelleA', :saison => saison_test, :typeculture => ble, :surface => zone.surface)
zonetopa = Zonetopa.create!(:parcelle => parcelle, :zone => zone, :value => zone.surface)

# zone B
zone = Zone.find_by_name('zoneB')
parcelle = Parcelle.create!(:name => ("parcelleB"), :saison => saison_test, :typeculture => ble, :surface => 100)
zonetopa = Zonetopa.create!(:parcelle => parcelle, :zone => zone, :value => parcelle.surface)

# zone C
zone = Zone.find_by_name('zoneC')
parcelle = Parcelle.create!(:name => ("parcelleC1"), :saison => saison_test, :typeculture => ble, :surface => 100)
zonetopa = Zonetopa.create!(:parcelle => parcelle, :zone => zone, :value => parcelle.surface)

parcelle = Parcelle.create!(:name => ("parcelleC2"), :saison => saison_test, :typeculture => colza, :surface => 100)
zonetopa = Zonetopa.create!(:parcelle => parcelle, :zone => zone, :value => parcelle.surface)


#set variables parcelles cultures
parcelles_ble = []
parcelles_ble << saison_test.parcelles.find_by_name('parcelleA')
parcelles_ble << saison_test.parcelles.find_by_name('parcelleB')
parcelles_ble << saison_test.parcelles.find_by_name('parcelleC1')

parcelles_colza = []
parcelles_colza << saison_test.parcelles.find_by_name('parcelleC2')

# FIN PARCELLES




# PRODUITS - (Generation automatique xls)
karate = Produit.create!(:name => 'Karate', :unit =>'L', :category => cat_divers, :saison => saison_test, :desc => '')




# FACTURES - from xls

facture = Debit.create!(:name => 'produits phyto 1', :date => '2011-03-11', :cout => 2000, :ref_client => '01-2010-1767', :ref => '007', :user => dauger, :factype => factype_diff,:factcat => factcat_agri,:category => cat_phyto, :desc => 'pas de prix HT. Verifier la somme.',:saison => saison_test, :star => 1)
protofacture = Protofacture.create!(:facture => facture, :produit => karate, :prix => 200, :quantite => 10, :saison => saison_test)


