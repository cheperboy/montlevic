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
saison_2010_2011 = Saison.create!(:name => "2010/2011", :year => "2010")
Setting.find(:first).update_attribute(:saison_id,	saison_2010_2011.id )


# PARCELLES

#Bons pain + mitant
for zone in Zone.find([1, 2])
  parcelle = Parcelle.create!(:name => zone.name, :saison => saison_2010_2011, :typeculture => ble, :surface => zone.surface)
  zonetopa = Zonetopa.create!(:parcelle => parcelle, :zone => zone, :value => zone.surface)
end

# Feuillets
zone = Zone.find(8)
parcelle = Parcelle.create!(:name => (zone.name + " 1"), :saison => saison_2010_2011, :typeculture => jachere, :surface => 5)
zonetopa = Zonetopa.create!(:parcelle => parcelle, :zone => zone, :value => parcelle.surface)
parcelle = Parcelle.create!(:name => (zone.name + " 2"), :saison => saison_2010_2011, :typeculture => jachere, :surface => 4)
zonetopa = Zonetopa.create!(:parcelle => parcelle, :zone => zone, :value => parcelle.surface)
parcelle = Parcelle.create!(:name => (zone.name + " 3"), :saison => saison_2010_2011, :typeculture => jachere, :surface => 7)
zonetopa = Zonetopa.create!(:parcelle => parcelle, :zone => zone, :value => parcelle.surface)


# Champ de la Rue
zone = Zone.find(3)
parcelle = Parcelle.create!(:name => "Pont des champs", :saison => saison_2010_2011, :typeculture => ble, :surface => 10)
zonetopa = Zonetopa.create!(:parcelle => parcelle, :zone => zone, :value => parcelle.surface)
parcelle = Parcelle.create!(:name => "Aeromodelisme", :saison => saison_2010_2011, :typeculture => ble, :surface => 14)
zonetopa = Zonetopa.create!(:parcelle => parcelle, :zone => zone, :value => parcelle.surface)
parcelle = Parcelle.create!(:name => "Derierre", :saison => saison_2010_2011, :typeculture => colza, :surface => 14)
zonetopa = Zonetopa.create!(:parcelle => parcelle, :zone => zone, :value => parcelle.surface)
parcelle = Parcelle.create!(:name => "Champ du Milieu", :saison => saison_2010_2011, :typeculture => tournesol, :surface => 9)
zonetopa = Zonetopa.create!(:parcelle => parcelle, :zone => zone, :value => parcelle.surface)

# Basse-cour
zone = Zone.find(4)
parcelle = Parcelle.create!(:name => zone.name, :saison => saison_2010_2011, :typeculture => colza, :surface => zone.surface )
zonetopa = Zonetopa.create!(:parcelle => parcelle, :zone => zone, :value => parcelle.surface)

# Vallees
zone = Zone.find(5)
parcelle = Parcelle.create!(:name => zone.name, :saison => saison_2010_2011, :typeculture => tournesol, :surface => zone.surface )
zonetopa = Zonetopa.create!(:parcelle => parcelle, :zone => zone, :value => parcelle.surface)

#set variables parcelles cultures
parcelles_ble = []
parcelles_ble << saison_2010_2011.parcelles.find_by_name('Mitant')
parcelles_ble << saison_2010_2011.parcelles.find_by_name('Bruneau')
parcelles_ble << saison_2010_2011.parcelles.find_by_name('Pont des champs')
parcelles_ble << saison_2010_2011.parcelles.find_by_name('Aeromodelisme')

parcelles_colza = []
parcelles_colza << saison_2010_2011.parcelles.find_by_name('Basse-cour')
parcelles_colza << saison_2010_2011.parcelles.find_by_name('Derierre')

parcelles_tournesol = []
parcelles_tournesol << saison_2010_2011.parcelles.find_by_name('Champ du Milieu')
parcelles_tournesol << saison_2010_2011.parcelles.find_by_name('Vallees')

parcelles_jachere = []
parcelles_jachere << saison_2010_2011.parcelles.find_by_name('Feuillets 1')
parcelles_jachere << saison_2010_2011.parcelles.find_by_name('Feuillets 2')
parcelles_jachere << saison_2010_2011.parcelles.find_by_name('Feuillets 3')
# FIN PARCELLES




# PRODUITS - (Generation automatique xls)
altigo = Produit.create!(:name => 'Altigo', :unit =>'kg', :category => cat_divers, :saison => saison_2010_2011, :desc => '')
amistar_xtra = Produit.create!(:name => 'Amistar Xtra', :unit =>'L', :category => cat_fongicide, :saison => saison_2010_2011, :desc => '')
ariane = Produit.create!(:name => 'Ariane', :unit =>'L', :category => cat_divers, :saison => saison_2010_2011, :desc => '')
autan = Produit.create!(:name => 'Autan', :unit =>'kg', :category => cat_semis, :saison => saison_2010_2011, :desc => '')
azomag = Produit.create!(:name => 'Azomag', :unit =>'kg', :category => cat_soufre, :saison => saison_2010_2011, :desc => '')
azomag20 = Produit.create!(:name => 'Azomag20', :unit =>'kg', :category => cat_soufre, :saison => saison_2010_2011, :desc => '')
azote = Produit.create!(:name => 'Azote', :unit =>'L', :category => cat_azote, :saison => saison_2010_2011, :desc => '')
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
cp151515 = Produit.create!(:name => '15-15-15', :unit =>'kg', :category => cat_engrais, :saison => saison_2010_2011, :desc => '')
folyr = Produit.create!(:name => 'Folyr', :unit =>'L', :category => cat_desherbant, :saison => saison_2010_2011, :desc => '')
fury = Produit.create!(:name => 'Fury', :unit =>'L', :category => cat_insecticide, :saison => saison_2010_2011, :desc => '')
glifonet = Produit.create!(:name => 'Glifonet', :unit =>'L', :category => cat_desherbant, :saison => saison_2010_2011, :desc => '')
harmony = Produit.create!(:name => 'Harmony', :unit =>'kg', :category => cat_semis, :saison => saison_2010_2011, :desc => '')
huile = Produit.create!(:name => 'Huile', :unit =>'L', :category => cat_divers, :saison => saison_2010_2011, :desc => '')
imperio = Produit.create!(:name => 'Imperio', :unit =>'kg', :category => cat_semis, :saison => saison_2010_2011, :desc => '')
karate = Produit.create!(:name => 'Karate', :unit =>'L', :category => cat_divers, :saison => saison_2010_2011, :desc => '')
lontrel = Produit.create!(:name => 'Lontrel', :unit =>'kg', :category => cat_semis, :saison => saison_2010_2011, :desc => '')
mas91 = Produit.create!(:name => 'MAS 91', :unit =>'L', :category => cat_divers, :saison => saison_2010_2011, :desc => '')
novrel = Produit.create!(:name => 'Novrel', :unit =>'kg', :category => cat_semis, :saison => saison_2010_2011, :desc => '')
nuvagrain = Produit.create!(:name => 'Nuvagrain', :unit =>'L', :category => cat_divers, :saison => saison_2010_2011, :desc => '')
ovation = Produit.create!(:name => 'Ovation', :unit =>'kg', :category => cat_semis, :saison => saison_2010_2011, :desc => '')
paledor = Produit.create!(:name => 'Paledor', :unit =>'kg', :category => cat_semis, :saison => saison_2010_2011, :desc => '')
picabore = Produit.create!(:name => 'Picabore', :unit =>'kg', :category => cat_oligo, :saison => saison_2010_2011, :desc => '')
picosolo = Produit.create!(:name => 'Picosolo', :unit =>'kg', :category => cat_desherbant, :saison => saison_2010_2011, :desc => '')
pr = Produit.create!(:name => 'Pr', :unit =>'kg', :category => cat_semis, :saison => saison_2010_2011, :desc => '')
proca = Produit.create!(:name => 'Proca', :unit =>'L', :category => cat_divers, :saison => saison_2010_2011, :desc => '')
proteus = Produit.create!(:name => 'Proteus', :unit =>'L', :category => cat_insecticide, :saison => saison_2010_2011, :desc => '')
pulsar = Produit.create!(:name => 'Pulsar', :unit =>'L', :category => cat_desherbant, :saison => saison_2010_2011, :desc => '')
radar = Produit.create!(:name => 'Radar', :unit =>'L', :category => cat_divers, :saison => saison_2010_2011, :desc => '')
richepain = Produit.create!(:name => 'Richepain', :unit =>'kg', :category => cat_divers, :saison => saison_2010_2011, :desc => '')
spartan = Produit.create!(:name => 'spartan', :unit =>'L', :category => cat_divers, :saison => saison_2010_2011, :desc => '')
springbok = Produit.create!(:name => 'Springbok', :unit =>'L', :category => cat_desherbant, :saison => saison_2010_2011, :desc => '')
stratos = Produit.create!(:name => 'Stratos', :unit =>'L', :category => cat_divers, :saison => saison_2010_2011, :desc => '')
super45 = Produit.create!(:name => 'Super45', :unit =>'kg', :category => cat_engrais, :saison => saison_2010_2011, :desc => '')
surnog = Produit.create!(:name => 'Surnog', :unit =>'L', :category => cat_fongicide, :saison => saison_2010_2011, :desc => '')
traxos = Produit.create!(:name => 'Traxos', :unit =>'L', :category => cat_desherbant, :saison => saison_2010_2011, :desc => '')
vip = Produit.create!(:name => 'Vip', :unit =>'L', :category => cat_divers, :saison => saison_2010_2011, :desc => '')
zero2030 = Produit.create!(:name => '0-20-30', :unit =>'kg', :category => cat_engrais, :saison => saison_2010_2011, :desc => '')
zero2525 = Produit.create!(:name => '0-25-25', :unit =>'kg', :category => cat_engrais, :saison => saison_2010_2011, :desc => '')





# FACTURES - from xls

facture = Debit.create!(:name => 'Sacs B.B Adivalor', :date => '2010-11-30', :cout => 2.5, :ref_client => '01-2010-1187', :ref => '001', :user => dauger, :factype => factype_diff,:factcat => factcat_agri,:category => cat_phyto, :desc => '1 sac big bag',:saison => saison_2010_2011, :star => 0)
facture = Debit.create!(:name => 'Super 45% BB', :date => '2011-01-21', :cout => 3069, :ref_client => '01-2010-1429', :ref => '002', :user => dauger, :factype => factype_diff,:factcat => factcat_agri,:category => cat_phyto, :desc => '',:saison => saison_2010_2011, :star => 0)
protofacture = Protofacture.create!(:facture => facture, :produit => super45, :prix => 0.465, :quantite => 6600, :saison => saison_2010_2011)
facture = Debit.create!(:name => 'engrais 0-20-30', :date => '2011-01-24', :cout => 1260.8, :ref_client => '01-2011-1448', :ref => '003', :user => dauger, :factype => factype_diff,:factcat => factcat_agri,:category => cat_phyto, :desc => '',:saison => saison_2010_2011, :star => 0)
protofacture = Protofacture.create!(:facture => facture, :produit => zero2030, :prix => 0.394, :quantite => 3200, :saison => saison_2010_2011)
facture = Debit.create!(:name => 'Sacs B.B Adivalor', :date => '2011-04-30', :cout => 5, :ref_client => '01-2010-2593', :ref => '004', :user => dauger, :factype => factype_diff,:factcat => factcat_agri,:category => cat_phyto, :desc => '2 sac big bag',:saison => saison_2010_2011, :star => 0)
facture = Debit.create!(:name => 'engrais 0-20-30', :date => '2011-03-29', :cout => 2000, :ref_client => '01-2010-1982', :ref => '005', :user => dauger, :factype => factype_diff,:factcat => factcat_agri,:category => cat_phyto, :desc => '',:saison => saison_2010_2011, :star => 0)
protofacture = Protofacture.create!(:facture => facture, :produit => zero2030, :prix => 0.4, :quantite => 5000, :saison => saison_2010_2011)
facture = Debit.create!(:name => 'Semance Campus', :date => '2011-03-11', :cout => 994, :ref_client => '01-2010-1767', :ref => '006', :user => dauger, :factype => factype_diff,:factcat => factcat_agri,:category => cat_phyto, :desc => '',:saison => saison_2010_2011, :star => 1)
protofacture = Protofacture.create!(:facture => facture, :produit => campus, :prix => 142, :quantite => 7, :saison => saison_2010_2011)
facture = Debit.create!(:name => 'produits phyto 1', :date => '2011-03-11', :cout => 4402.2, :ref_client => '01-2010-1767', :ref => '007', :user => dauger, :factype => factype_diff,:factcat => factcat_agri,:category => cat_phyto, :desc => 'pas de prix HT. Verifier la somme.',:saison => saison_2010_2011, :star => 1)
protofacture = Protofacture.create!(:facture => facture, :produit => amistar_xtra, :prix => 43.9, :quantite => 10, :saison => saison_2010_2011)
protofacture = Protofacture.create!(:facture => facture, :produit => cline, :prix => 20.9, :quantite => 15, :saison => saison_2010_2011)
protofacture = Protofacture.create!(:facture => facture, :produit => pulsar, :prix => 56.6, :quantite => 10, :saison => saison_2010_2011)
protofacture = Protofacture.create!(:facture => facture, :produit => glifonet, :prix => 3.8, :quantite => 200, :saison => saison_2010_2011)
protofacture = Protofacture.create!(:facture => facture, :produit => glifonet, :prix => 3.8, :quantite => 100, :saison => saison_2010_2011)
protofacture = Protofacture.create!(:facture => facture, :produit => huile, :prix => 2.4, :quantite => 60, :saison => saison_2010_2011)
protofacture = Protofacture.create!(:facture => facture, :produit => lontrel, :prix => 52.95, :quantite => 12, :saison => saison_2010_2011)
protofacture = Protofacture.create!(:facture => facture, :produit => chrono, :prix => 37.9, :quantite => 15, :saison => saison_2010_2011)
protofacture = Protofacture.create!(:facture => facture, :produit => mas91, :prix => 198.6, :quantite => 3, :saison => saison_2010_2011)
facture = Debit.create!(:name => 'azomag', :date => '2011-02-28', :cout => 1680, :ref_client => '01-2010-1737', :ref => '008', :user => dauger, :factype => factype_diff,:factcat => factcat_agri,:category => cat_phyto, :desc => 'azomag 16 BB',:saison => saison_2010_2011, :star => 0)
protofacture = Protofacture.create!(:facture => facture, :produit => azomag, :prix => 0.28, :quantite => 6000, :saison => saison_2010_2011)
facture = Debit.create!(:name => 'produits phyto 2', :date => '2011-04-30', :cout => 1654, :ref_client => '01-2010-2594', :ref => '009', :user => dauger, :factype => factype_diff,:factcat => factcat_agri,:category => cat_phyto, :desc => 'avoir de 2% sous condition',:saison => saison_2010_2011, :star => 0)
protofacture = Protofacture.create!(:facture => facture, :produit => cp151515, :prix => 50, :quantite => 0.5, :saison => saison_2010_2011)
protofacture = Protofacture.create!(:facture => facture, :produit => huile, :prix => 2.4, :quantite => 20, :saison => saison_2010_2011)
protofacture = Protofacture.create!(:facture => facture, :produit => vip, :prix => 67, :quantite => 10, :saison => saison_2010_2011)
protofacture = Protofacture.create!(:facture => facture, :produit => ariane, :prix => 15.4, :quantite => 30, :saison => saison_2010_2011)
protofacture = Protofacture.create!(:facture => facture, :produit => traxos, :prix => 31.65, :quantite => 10, :saison => saison_2010_2011)
protofacture = Protofacture.create!(:facture => facture, :produit => karate, :prix => 132.5, :quantite => 1, :saison => saison_2010_2011)
facture = Debit.create!(:name => 'produits phyto 3', :date => '2011-03-11', :cout => 6314.35, :ref_client => '01-2010-1767', :ref => '010', :user => dauger, :factype => factype_diff,:factcat => factcat_agri,:category => cat_phyto, :desc => 'avoir de 2% + 3% sauf glifonet -0,30€',:saison => saison_2010_2011, :star => 0)
protofacture = Protofacture.create!(:facture => facture, :produit => stratos, :prix => 18.8, :quantite => 10, :saison => saison_2010_2011)
protofacture = Protofacture.create!(:facture => facture, :produit => radar, :prix => 212.5, :quantite => 12, :saison => saison_2010_2011)
protofacture = Protofacture.create!(:facture => facture, :produit => spartan, :prix => 33.9, :quantite => 5, :saison => saison_2010_2011)
protofacture = Protofacture.create!(:facture => facture, :produit => lontrel, :prix => 52.95, :quantite => 1, :saison => saison_2010_2011)
protofacture = Protofacture.create!(:facture => facture, :produit => huile, :prix => 2.4, :quantite => 20, :saison => saison_2010_2011)
protofacture = Protofacture.create!(:facture => facture, :produit => radar, :prix => 212.5, :quantite => 2.2, :saison => saison_2010_2011)
protofacture = Protofacture.create!(:facture => facture, :produit => proca, :prix => 10.2, :quantite => 45, :saison => saison_2010_2011)
protofacture = Protofacture.create!(:facture => facture, :produit => bravo_elite, :prix => 18.3, :quantite => 60, :saison => saison_2010_2011)
protofacture = Protofacture.create!(:facture => facture, :produit => comet_player, :prix => 159.9, :quantite => 6, :saison => saison_2010_2011)
protofacture = Protofacture.create!(:facture => facture, :produit => surnog, :prix => 32.2, :quantite => 10, :saison => saison_2010_2011)
facture = Debit.create!(:name => 'Ammonitrate', :date => '2010-08-31', :cout => 9204, :ref_client => '01-2010-250', :ref => '011', :user => dauger, :factype => factype_diff,:factcat => factcat_agri,:category => cat_phyto, :desc => 'voire indications manuscrites sur la facture',:saison => saison_2010_2011, :star => 1)
protofacture = Protofacture.create!(:facture => facture, :produit => azote, :prix => 0.26, :quantite => 25200, :saison => saison_2010_2011)
protofacture = Protofacture.create!(:facture => facture, :produit => azote, :prix => 0.26, :quantite => 10200, :saison => saison_2010_2011)
facture = Debit.create!(:name => 'produits phyto 4', :date => '2010-10-31', :cout => 998.99, :ref_client => '01-2010-975', :ref => '012', :user => dauger, :factype => factype_diff,:factcat => factcat_agri,:category => cat_phyto, :desc => 'avoir de 13,25 à prendre en compte',:saison => saison_2010_2011, :star => 1)
protofacture = Protofacture.create!(:facture => facture, :produit => fury, :prix => 44.5, :quantite => 5, :saison => saison_2010_2011)
protofacture = Protofacture.create!(:facture => facture, :produit => huile, :prix => 2.65, :quantite => 20, :saison => saison_2010_2011)
protofacture = Protofacture.create!(:facture => facture, :produit => folyr, :prix => 30.8, :quantite => 10, :saison => saison_2010_2011)
protofacture = Protofacture.create!(:facture => facture, :produit => paledor, :prix => 61.8, :quantite => 2, :saison => saison_2010_2011)
protofacture = Protofacture.create!(:facture => facture, :produit => altigo, :prix => 63.8, :quantite => 2, :saison => saison_2010_2011)
protofacture = Protofacture.create!(:facture => facture, :produit => pr, :prix => 23.47, :quantite => 7, :saison => saison_2010_2011)
facture = Debit.create!(:name => 'produits phyto 5', :date => '2010-09-27', :cout => 4907.4, :ref_client => '01-2010-471', :ref => '013', :user => dauger, :factype => factype_diff,:factcat => factcat_agri,:category => cat_phyto, :desc => '',:saison => saison_2010_2011, :star => 0)
#protofacture = Protofacture.create!(:facture => facture, :produit => dactyle, :prix => 5.2, :quantite => 130, :saison => saison_2010_2011)
#protofacture = Protofacture.create!(:facture => facture, :produit => anglais_calibra, :prix => 2.9, :quantite => 120, :saison => saison_2010_2011)
#protofacture = Protofacture.create!(:facture => facture, :produit => italie_turtetra, :prix => 1.7, :quantite => 100, :saison => saison_2010_2011)
#protofacture = Protofacture.create!(:facture => facture, :produit => fet_elevee_noria, :prix => 5.2, :quantite => 110, :saison => saison_2010_2011)
#protofacture = Protofacture.create!(:facture => facture, :produit => tref_violet_valente, :prix => 4.2, :quantite => 20, :saison => saison_2010_2011)
#protofacture = Protofacture.create!(:facture => facture, :produit => kali, :prix => 5.2, :quantite => 80, :saison => saison_2010_2011)
#protofacture = Protofacture.create!(:facture => facture, :produit => tref_blanc_regal, :prix => 7.9, :quantite => 25, :saison => saison_2010_2011)
#protofacture = Protofacture.create!(:facture => facture, :produit => oxyfertil, :prix => 19.15, :quantite => 36, :saison => saison_2010_2011)
protofacture = Protofacture.create!(:facture => facture, :produit => ovation, :prix => 139.5, :quantite => 1, :saison => saison_2010_2011)
protofacture = Protofacture.create!(:facture => facture, :produit => colzamid, :prix => 19.3, :quantite => 30, :saison => saison_2010_2011)
protofacture = Protofacture.create!(:facture => facture, :produit => springbok, :prix => 25.9, :quantite => 40, :saison => saison_2010_2011)
facture = Debit.create!(:name => 'produits phyto 6', :date => '2010-09-30', :cout => 246, :ref_client => '01-2010-689', :ref => '014', :user => dauger, :factype => factype_diff,:factcat => factcat_agri,:category => cat_phyto, :desc => '',:saison => saison_2010_2011, :star => 0)
#protofacture = Protofacture.create!(:facture => facture, :produit => aubisque, :prix => 3.7, :quantite => 10, :saison => saison_2010_2011)
protofacture = Protofacture.create!(:facture => facture, :produit => chardol, :prix => 7.85, :quantite => 10, :saison => saison_2010_2011)
protofacture = Protofacture.create!(:facture => facture, :produit => chardol, :prix => 7.85, :quantite => 10, :saison => saison_2010_2011)
protofacture = Protofacture.create!(:facture => facture, :produit => huile, :prix => 2.6, :quantite => 20, :saison => saison_2010_2011)
facture = Debit.create!(:name => 'vitavax + BB', :date => '2010-10-20', :cout => 746.58, :ref_client => '22269', :ref => '015', :user => renaud, :factype => factype_diff,:factcat => factcat_agri,:category => cat_phyto, :desc => 'vitavax + Big BagsBB : 8x9,41=75,24€ à répartir',:saison => saison_2010_2011, :star => 0)
#protofacture = Protofacture.create!(:facture => facture, :produit => vitavax, :prix => 10.05, :quantite => 66.8, :saison => saison_2010_2011)
facture = Debit.create!(:name => 'Fury 5L', :date => '2011-03-31', :cout => 163.7, :ref_client => 'FCT-1305', :ref => '016', :user => auroy, :factype => factype_diff,:factcat => factcat_agri,:category => cat_phyto, :desc => '',:saison => saison_2010_2011, :star => 0)
protofacture = Protofacture.create!(:facture => facture, :produit => fury, :prix => 32.74, :quantite => 5, :saison => saison_2010_2011)
facture = Debit.create!(:name => 'Picabore + Challenge', :date => '2011-02-28', :cout => 1221.81, :ref_client => '24302', :ref => '017', :user => renaud, :factype => factype_diff,:factcat => factcat_agri,:category => cat_phyto, :desc => '',:saison => saison_2010_2011, :star => 1)
protofacture = Protofacture.create!(:facture => facture, :produit => picabore, :prix => 2.1, :quantite => 40, :saison => saison_2010_2011)
protofacture = Protofacture.create!(:facture => facture, :produit => challenge, :prix => 18.96, :quantite => 60, :saison => saison_2010_2011)
protofacture = Protofacture.create!(:facture => facture, :produit => challenge, :prix => 1.2, :quantite => 60, :saison => saison_2010_2011)
facture = Debit.create!(:name => 'produits phyto 7', :date => '2011-06-28', :cout => 389.9, :ref_client => 'FCC-1629', :ref => '018', :user => auroy, :factype => factype_diff,:factcat => factcat_agri,:category => cat_phyto, :desc => 'produits + Bib Bag 1,50x1,60 : 10x10=100€ a répartir',:saison => saison_2010_2011, :star => 0)
protofacture = Protofacture.create!(:facture => facture, :produit => nuvagrain, :prix => 36, :quantite => 5, :saison => saison_2010_2011)
protofacture = Protofacture.create!(:facture => facture, :produit => karate, :prix => 109.9, :quantite => 1, :saison => saison_2010_2011)
facture = Debit.create!(:name => 'nuvagrain', :date => '2010-07-10', :cout => 51.26, :ref_client => 'FCC-44', :ref => '019', :user => auroy, :factype => factype_diff,:factcat => factcat_agri,:category => cat_phyto, :desc => '',:saison => saison_2010_2011, :star => 0)
protofacture = Protofacture.create!(:facture => facture, :produit => nuvagrain, :prix => 25.63, :quantite => 2, :saison => saison_2010_2011)
facture = Debit.create!(:name => 'semis tournesol', :date => '2011-03-27', :cout => 260, :ref_client => '015-2011', :ref => '020', :user => bernard_peres, :factype => factype_diff,:factcat => factcat_agri,:category => cat_service_agri, :desc => '20ha x 13€/ha = 260€',:saison => saison_2010_2011, :star => 1)

facture = Debit.create!(:name => 'PRODUITS MANQUANTS', :date => '2011-02-28', :cout => 1221.81, :ref_client => '0000', :ref => '021', :user => dauger, :factype => factype_diff,:factcat => factcat_agri,:category => cat_phyto, :desc => '',:saison => saison_2010_2011, :star => 1)
protofacture = Protofacture.create!(:facture => facture, :produit => picabore, :prix => 2.1, :quantite => 40, :saison => saison_2010_2011)
protofacture = Protofacture.create!(:facture => facture, :produit => challenge, :prix => 18.96, :quantite => 60, :saison => saison_2010_2011)
protofacture = Protofacture.create!(:facture => facture, :produit => challenge, :prix => 1.2, :quantite => 60, :saison => saison_2010_2011)


reportable = Reportable.create!(:name => 'facture 19', :date => '2011-01-30', :cout => 3537.5, :ref_client => '19', :ref => '021', :user => trochet, :factype => factype_null,:factcat => factcat_agri,:category => cat_service_agri, :desc => '',:saison => saison_2010_2011, :star => 0)
facture = Report.create!(:reportable => reportable, :name => 'Pulvérisation', :date => '2011-01-30', :cout => 955, :ref_client => '19', :ref => '021', :user => trochet, :factype => factype_diff,:factcat => factcat_agri,:category => cat_service_agri, :desc => '95,5Ha x 10€ = 955€',:saison => saison_2010_2011, :star => 0)
facture = Report.create!(:reportable => reportable, :name => 'Broyage haies', :date => '2011-01-30', :cout => 456, :ref_client => '19', :ref => '021', :user => trochet, :factype => factype_diff,:factcat => factcat_agri,:category => cat_service_agri, :desc => '12h x 38€ = 456€',:saison => saison_2010_2011, :star => 0)
facture = Report.create!(:reportable => reportable, :name => 'Broyage horizontal', :date => '2011-01-30', :cout => 297.5, :ref_client => '19', :ref => '021', :user => trochet, :factype => factype_diff,:factcat => factcat_agri,:category => cat_service_agri, :desc => '8h50 x 35€/h = 297,5',:saison => saison_2010_2011, :star => 0)
facture = Report.create!(:reportable => reportable, :name => 'Semis Colza et Blé', :date => '2011-01-30', :cout => 1829, :ref_client => '19', :ref => '021', :user => trochet, :factype => factype_diff,:factcat => factcat_agri,:category => cat_service_agri, :desc => '59ha x 31€/ha = 1829€',:saison => saison_2010_2011, :star => 0)

reportable = Reportable.create!(:name => 'facture 18', :date => '2011-01-30', :cout => 3515, :ref_client => '18', :ref => '022', :user => trochet, :factype => factype_null,:factcat => factcat_agri,:category => cat_service_agri, :desc => '',:saison => saison_2010_2011, :star => 0)
facture = Report.create!(:reportable => reportable, :name => 'Roulage', :date => '2011-01-30', :cout => 465, :ref_client => '18', :ref => '022', :user => trochet, :factype => factype_diff,:factcat => factcat_agri,:category => cat_service_agri, :desc => '15h30 x 30€/h = 465€',:saison => saison_2010_2011, :star => 0)
facture = Report.create!(:reportable => reportable, :name => 'Cover-crop', :date => '2011-01-30', :cout => 2240, :ref_client => '18', :ref => '022', :user => trochet, :factype => factype_diff,:factcat => factcat_agri,:category => cat_service_agri, :desc => '64h x 35€/h = 2240€',:saison => saison_2010_2011, :star => 0)
facture = Report.create!(:reportable => reportable, :name => 'Vibro', :date => '2011-01-30', :cout => 810, :ref_client => '18', :ref => '022', :user => trochet, :factype => factype_diff,:factcat => factcat_agri,:category => cat_service_agri, :desc => '81ha x 10€ = 810€',:saison => saison_2010_2011, :star => 0)

reportable = Reportable.create!(:name => 'facture 20', :date => '2011-01-30', :cout => 2950, :ref_client => '20', :ref => '023', :user => trochet, :factype => factype_null,:factcat => factcat_agri,:category => cat_service_agri, :desc => '',:saison => saison_2010_2011, :star => 0)
facture = Report.create!(:reportable => reportable, :name => 'Labour + Herse', :date => '2011-01-30', :cout => 2830, :ref_client => '20', :ref => '023', :user => trochet, :factype => factype_diff,:factcat => factcat_agri,:category => cat_service_agri, :desc => '(semis prairies)',:saison => saison_2010_2011, :star => 0)
facture = Report.create!(:reportable => reportable, :name => 'Epandage chaux', :date => '2011-01-30', :cout => 120, :ref_client => '20', :ref => '023', :user => trochet, :factype => factype_diff,:factcat => factcat_agri,:category => cat_service_agri, :desc => '',:saison => saison_2010_2011, :star => 0)

reportable = Reportable.create!(:name => 'facture 24', :date => '2011-07-19', :cout => 5790, :ref_client => '24', :ref => '024', :user => trochet, :factype => factype_null,:factcat => factcat_agri,:category => cat_service_agri, :desc => '',:saison => saison_2010_2011, :star => 0)
facture = Report.create!(:reportable => reportable, :name => 'Epandage engrais', :date => '2011-07-19', :cout => 2520, :ref_client => '24', :ref => '024', :user => trochet, :factype => factype_diff,:factcat => factcat_agri,:category => cat_service_agri, :desc => '252 ha x 10€ = 2520€',:saison => saison_2010_2011, :star => 0)
facture = Report.create!(:reportable => reportable, :name => 'Pulvérisation cultures', :date => '2011-07-19', :cout => 2850, :ref_client => '24', :ref => '024', :user => trochet, :factype => factype_diff,:factcat => factcat_agri,:category => cat_service_agri, :desc => '285 ha x 10€ = 2850€',:saison => saison_2010_2011, :star => 0)
facture = Report.create!(:reportable => reportable, :name => 'tours de champs', :date => '2011-07-19', :cout => 120, :ref_client => '24', :ref => '024', :user => trochet, :factype => factype_diff,:factcat => factcat_agri,:category => cat_service_agri, :desc => '4h x 30€/h = 120€ (desherbage)',:saison => saison_2010_2011, :star => 0)
facture = Report.create!(:reportable => reportable, :name => 'semis tournesol', :date => '2011-07-19', :cout => 300, :ref_client => '24', :ref => '024', :user => trochet, :factype => factype_diff,:factcat => factcat_agri,:category => cat_service_agri, :desc => '20ha x 15€/ha = 300€ (Semis tournesol Tracteur)',:saison => saison_2010_2011, :star => 0)

reportable = Reportable.create!(:name => 'facture 25', :date => '2011-07-19', :cout => 226.4, :ref_client => '25', :ref => '025', :user => trochet, :factype => factype_null,:factcat => factcat_agri,:category => cat_service_agri, :desc => '',:saison => saison_2010_2011, :star => 0)
facture = Report.create!(:reportable => reportable, :name => 'Vibro', :date => '2011-07-19', :cout => 200, :ref_client => '25', :ref => '025', :user => trochet, :factype => factype_diff,:factcat => factcat_agri,:category => cat_service_agri, :desc => '20ha x 10€ = 200€',:saison => saison_2010_2011, :star => 0)
facture = Report.create!(:reportable => reportable, :name => 'Orge', :date => '2011-07-19', :cout => 26.4, :ref_client => '25', :ref => '025', :user => trochet, :factype => factype_diff,:factcat => factcat_agri,:category => cat_service_agri, :desc => '150kg x 176€/t = 26,40€',:saison => saison_2010_2011, :star => 0)

reportable = Reportable.create!(:name => 'facture 50', :date => '2010-11-07', :cout => 6986, :ref_client => '50', :ref => '026', :user => trochet, :factype => factype_null,:factcat => factcat_agri,:category => cat_service_agri, :desc => '',:saison => saison_2010_2011, :star => 0)
facture = Report.create!(:reportable => reportable, :name => 'Moissonnage Blé colza, Tournesol', :date => '2010-11-07', :cout => 6375, :ref_client => '50', :ref => '026', :user => trochet, :factype => factype_diff,:factcat => factcat_agri,:category => cat_service_agri, :desc => '85ha x 75€/ha = 6375€',:saison => saison_2010_2011, :star => 0)
facture = Report.create!(:reportable => reportable, :name => 'Transport Céréales', :date => '2010-11-07', :cout => 611, :ref_client => '50', :ref => '026', :user => trochet, :factype => factype_diff,:factcat => factcat_agri,:category => cat_service_agri, :desc => '13 voyages x 47€ = 611€',:saison => saison_2010_2011, :star => 0)

facture = Debit.create!(:name => 'facture 14 : Pressage', :date => '2010-11-10', :cout => 3312, :ref_client => '14', :ref => '027', :user => trochet, :factype => factype_null,:factcat => factcat_agri,:category => cat_service_agri, :desc => '',:saison => saison_2010_2011, :star => 0)



















# PULVES & LABOURS - (generation automatique xls)

 # Les Vallées - Tournesol - 11Ha

pulves = []
labours = []


pulve = Pulve.create!(:name => 'Glyphosate', :cout_ha_passage => 23, :user => trochet, :saison => saison_2010_2011, :date => '2011-03-11', :star => 1, :desc => 'verifier les date (2010 ou 2011?).</br>verifier le dosage huile.')
putoproduit = Putoproduit.create!(:pulve => pulve, :produit => glifonet, :dosage => 2, :saison => saison_2010_2011)
putoproduit = Putoproduit.create!(:pulve => pulve, :produit => huile, :dosage => 1, :saison => saison_2010_2011)
pulves << pulve
pulve = Pulve.create!(:name => 'Engrais 0-20-30', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2011-03-20', :star => 0, :desc => '')
putoproduit = Putoproduit.create!(:pulve => pulve, :produit => zero2030, :dosage => 250, :saison => saison_2010_2011)
pulves << pulve
pulve = Pulve.create!(:name => 'Semis', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2011-04-06', :star => 1, :desc => 'indiquer :</br>->la variété</br>->les dosages.</br>->modifier le cout_ha_passage du semis.</br>MAS 91 : 6Ha (PMG 58g).</br>Campus : 5Ha (PMG 78g).')
#putoproduit = Putoproduit.create!(:pulve => pulve, :produit => campus, :dosage => 1, :saison => saison_2010_2011)
#putoproduit = Putoproduit.create!(:pulve => pulve, :produit => mas91, :dosage => 1, :saison => saison_2010_2011)
pulves << pulve
pulve = Pulve.create!(:name => 'Cline', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2011-04-07', :star => 0, :desc => '2.5 L/Ha sur 6Ha</br>=> 2,5 x 6 / 11</br>=> 1,3636')
putoproduit = Putoproduit.create!(:pulve => pulve, :produit => cline, :dosage => 1.3636, :saison => saison_2010_2011)
pulves << pulve
pulve = Pulve.create!(:name => 'Challenge', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2011-04-11', :star => 0, :desc => '4 L/Ha sur 5Ha</br>=> 4 x 5 / 11</br>=> 1,8182')
putoproduit = Putoproduit.create!(:pulve => pulve, :produit => challenge, :dosage => 1.8182, :saison => saison_2010_2011)
pulves << pulve
pulve = Pulve.create!(:name => 'pulsar', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2011-05-20', :star => 0, :desc => '1,25 L/Ha sur 6Ha</br>=> 1,25 x 6 / 11</br>=> 0,68182')
putoproduit = Putoproduit.create!(:pulve => pulve, :produit => pulsar, :dosage => 0.68182, :saison => saison_2010_2011)
pulves << pulve

labour = Labour.create!(:name => 'déchaumage blé - 1', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2010-05-01', :star => 0, :category => cat_covercrop, :desc => 'date inconnue')
labours << labour

parcelle = saison_2010_2011.parcelles.find_by_name('Vallees')
labours.each {|labour| labtoparcelle = Labtoparcelle.create!(:parcelle => parcelle, :labour => labour, :value => 0)}
pulves.each {|pulve| putoparcelle = Putoparcelle.create!(:parcelle => parcelle, :pulve => pulve, :value => 0)}




 # Champ du milieu - Tournesol - 9Ha

pulves = []
labours = []


pulve = Pulve.create!(:name => 'Glyphosate', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2011-03-11', :star => 1, :desc => 'verifier les date (2010 ou 2011?).</br>verifier le dosage huile.')
putoproduit = Putoproduit.create!(:pulve => pulve, :produit => glifonet, :dosage => 2, :saison => saison_2010_2011)
putoproduit = Putoproduit.create!(:pulve => pulve, :produit => huile, :dosage => 1, :saison => saison_2010_2011)
pulves << pulve
pulve = Pulve.create!(:name => 'Engrais 0-20-30', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2011-03-20', :star => 0, :desc => '')
putoproduit = Putoproduit.create!(:pulve => pulve, :produit => zero2030, :dosage => 250, :saison => saison_2010_2011)
pulves << pulve
pulve = Pulve.create!(:name => 'Semis', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2011-04-06', :star => 1, :desc => 'modifier le cout_ha_passage et le dosage')
#putoproduit = Putoproduit.create!(:pulve => pulve, :produit => campus, :dosage => 1, :saison => saison_2010_2011)
pulves << pulve
pulve = Pulve.create!(:name => 'Challenge', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2011-04-11', :star => 0, :desc => '')
putoproduit = Putoproduit.create!(:pulve => pulve, :produit => challenge, :dosage => 4, :saison => saison_2010_2011)
pulves << pulve


parcelle = saison_2010_2011.parcelles.find_by_name('Champ du Milieu')
labours.each {|labour| labtoparcelle = Labtoparcelle.create!(:parcelle => parcelle, :labour => labour, :value => 0)}
pulves.each {|pulve| putoparcelle = Putoparcelle.create!(:parcelle => parcelle, :pulve => pulve, :value => 0)}







 # Basse-cour - Colza - 2Ha

pulves = []
labours = []


pulve = Pulve.create!(:name => 'Semis', :cout_ha_passage => 31, :user => trochet, :saison => saison_2010_2011, :date => '2010-08-31', :star => 0, :desc => '')
#putoproduit = Putoproduit.create!(:pulve => pulve, :produit => catalino, :dosage => 3.5, :saison => saison_2010_2011)
pulves << pulve
pulve = Pulve.create!(:name => 'colzamid', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2010-08-31', :star => 0, :desc => '')
putoproduit = Putoproduit.create!(:pulve => pulve, :produit => colzamid, :dosage => 1.8, :saison => saison_2010_2011)
pulves << pulve
pulve = Pulve.create!(:name => 'springbok', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2010-09-02', :star => 0, :desc => '')
putoproduit = Putoproduit.create!(:pulve => pulve, :produit => springbok, :dosage => 2.5, :saison => saison_2010_2011)
pulves << pulve
pulve = Pulve.create!(:name => 'Folyr', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2010-10-07', :star => 0, :desc => '')
putoproduit = Putoproduit.create!(:pulve => pulve, :produit => folyr, :dosage => 0.6, :saison => saison_2010_2011)
putoproduit = Putoproduit.create!(:pulve => pulve, :produit => huile, :dosage => 1, :saison => saison_2010_2011)
putoproduit = Putoproduit.create!(:pulve => pulve, :produit => fury, :dosage => 0.1, :saison => saison_2010_2011)
pulves << pulve
pulve = Pulve.create!(:name => '0-20-30', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2011-01-23', :star => 0, :desc => '')
putoproduit = Putoproduit.create!(:pulve => pulve, :produit => zero2030, :dosage => 200, :saison => saison_2010_2011)
pulves << pulve
pulve = Pulve.create!(:name => 'Azote', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2011-02-08', :star => 0, :desc => '81u.</br>N°38 (? Cf carnet trochet)')
putoproduit = Putoproduit.create!(:pulve => pulve, :produit => azote, :dosage => 243, :saison => saison_2010_2011)
pulves << pulve
pulve = Pulve.create!(:name => 'Stratos', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2011-02-10', :star => 0, :desc => '')
putoproduit = Putoproduit.create!(:pulve => pulve, :produit => stratos, :dosage => 2, :saison => saison_2010_2011)
pulves << pulve
pulve = Pulve.create!(:name => 'Azote', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2011-03-03', :star => 0, :desc => '94u.</br>N°40')
putoproduit = Putoproduit.create!(:pulve => pulve, :produit => azote, :dosage => 281, :saison => saison_2010_2011)
pulves << pulve
pulve = Pulve.create!(:name => 'Soufre', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2011-03-08', :star => 0, :desc => '')
putoproduit = Putoproduit.create!(:pulve => pulve, :produit => azomag, :dosage => 150, :saison => saison_2010_2011)
pulves << pulve
pulve = Pulve.create!(:name => 'Fury', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2011-03-08', :star => 0, :desc => '')
putoproduit = Putoproduit.create!(:pulve => pulve, :produit => fury, :dosage => 0.1, :saison => saison_2010_2011)
pulves << pulve
pulve = Pulve.create!(:name => 'chrono', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2011-03-08', :star => 0, :desc => '')
putoproduit = Putoproduit.create!(:pulve => pulve, :produit => chrono, :dosage => 1.25, :saison => saison_2010_2011)
putoproduit = Putoproduit.create!(:pulve => pulve, :produit => lontrel, :dosage => 1, :saison => saison_2010_2011)
pulves << pulve
pulve = Pulve.create!(:name => 'picabore', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2011-03-20', :star => 0, :desc => '')
putoproduit = Putoproduit.create!(:pulve => pulve, :produit => picabore, :dosage => 2.5, :saison => saison_2010_2011)
putoproduit = Putoproduit.create!(:pulve => pulve, :produit => proteus, :dosage => 0.5, :saison => saison_2010_2011)
pulves << pulve
pulve = Pulve.create!(:name => 'Surnog', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2011-04-02', :star => 0, :desc => '')
putoproduit = Putoproduit.create!(:pulve => pulve, :produit => surnog, :dosage => 0.6, :saison => saison_2010_2011)
pulves << pulve
pulve = Pulve.create!(:name => 'amistar_xtra', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2011-04-20', :star => 0, :desc => '')
putoproduit = Putoproduit.create!(:pulve => pulve, :produit => amistar_xtra, :dosage => 0.75, :saison => saison_2010_2011)
pulves << pulve




parcelle = saison_2010_2011.parcelles.find_by_name('Basse-cour')
labours.each {|labour| labtoparcelle = Labtoparcelle.create!(:parcelle => parcelle, :labour => labour, :value => 0)}
pulves.each {|pulve| putoparcelle = Putoparcelle.create!(:parcelle => parcelle, :pulve => pulve, :value => 0)}






 # Derierre - Colza - 14Ha

pulves = []
labours = []


pulve = Pulve.create!(:name => 'Semis', :cout_ha_passage => 31, :user => trochet, :saison => saison_2010_2011, :date => '2010-08-30', :star => 1, :desc => 'dosage reel = 3.5Kg/Ha.</br>Selection Ovation au milieu entre les deux poteaux, voir plan)')
#putoproduit = Putoproduit.create!(:pulve => pulve, :produit => catalino, :dosage => 2, :saison => saison_2010_2011)
#putoproduit = Putoproduit.create!(:pulve => pulve, :produit => ovation, :dosage => 1.5, :saison => saison_2010_2011)
pulves << pulve
pulve = Pulve.create!(:name => 'colzamid', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2010-08-30', :star => 0, :desc => '')
putoproduit = Putoproduit.create!(:pulve => pulve, :produit => colzamid, :dosage => 1.8, :saison => saison_2010_2011)
pulves << pulve
pulve = Pulve.create!(:name => 'springbok', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2010-09-02', :star => 0, :desc => '')
putoproduit = Putoproduit.create!(:pulve => pulve, :produit => springbok, :dosage => 2.5, :saison => saison_2010_2011)
pulves << pulve
pulve = Pulve.create!(:name => 'Folyr', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2010-10-07', :star => 0, :desc => '')
putoproduit = Putoproduit.create!(:pulve => pulve, :produit => folyr, :dosage => 0.6, :saison => saison_2010_2011)
putoproduit = Putoproduit.create!(:pulve => pulve, :produit => huile, :dosage => 1, :saison => saison_2010_2011)
putoproduit = Putoproduit.create!(:pulve => pulve, :produit => fury, :dosage => 0.1, :saison => saison_2010_2011)
pulves << pulve
pulve = Pulve.create!(:name => '0-20-30', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2011-01-23', :star => 0, :desc => '')
putoproduit = Putoproduit.create!(:pulve => pulve, :produit => zero2030, :dosage => 200, :saison => saison_2010_2011)
pulves << pulve
pulve = Pulve.create!(:name => 'Azote', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2011-02-08', :star => 0, :desc => '81u.</br>N°38')
putoproduit = Putoproduit.create!(:pulve => pulve, :produit => azote, :dosage => 243, :saison => saison_2010_2011)
pulves << pulve
pulve = Pulve.create!(:name => 'Azote', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2011-03-03', :star => 0, :desc => '94u.</br>N°40')
putoproduit = Putoproduit.create!(:pulve => pulve, :produit => azote, :dosage => 280, :saison => saison_2010_2011)
pulves << pulve
pulve = Pulve.create!(:name => 'Soufre', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2011-03-08', :star => 0, :desc => '')
putoproduit = Putoproduit.create!(:pulve => pulve, :produit => azomag, :dosage => 150, :saison => saison_2010_2011)
pulves << pulve
pulve = Pulve.create!(:name => 'Fury', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2011-03-09', :star => 0, :desc => '')
putoproduit = Putoproduit.create!(:pulve => pulve, :produit => fury, :dosage => 0.1, :saison => saison_2010_2011)
pulves << pulve
pulve = Pulve.create!(:name => 'chrono', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2011-03-08', :star => 0, :desc => 'dosages reel sur 8Ha:</br>chrono : 1,25L/Ha.</br>lontrel : 1L/Ha.')
putoproduit = Putoproduit.create!(:pulve => pulve, :produit => chrono, :dosage => 0.714, :saison => saison_2010_2011)
putoproduit = Putoproduit.create!(:pulve => pulve, :produit => lontrel, :dosage => 0.571, :saison => saison_2010_2011)
pulves << pulve
pulve = Pulve.create!(:name => 'picabore', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2011-03-24', :star => 0, :desc => '')
putoproduit = Putoproduit.create!(:pulve => pulve, :produit => picabore, :dosage => 2.5, :saison => saison_2010_2011)
putoproduit = Putoproduit.create!(:pulve => pulve, :produit => proteus, :dosage => 0.5, :saison => saison_2010_2011)
pulves << pulve
pulve = Pulve.create!(:name => 'Surnog', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2011-04-02', :star => 0, :desc => '')
putoproduit = Putoproduit.create!(:pulve => pulve, :produit => surnog, :dosage => 0.6, :saison => saison_2010_2011)
pulves << pulve
pulve = Pulve.create!(:name => 'amistar_xtra', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2011-04-20', :star => 0, :desc => '')
putoproduit = Putoproduit.create!(:pulve => pulve, :produit => amistar_xtra, :dosage => 0.75, :saison => saison_2010_2011)
pulves << pulve



parcelle = saison_2010_2011.parcelles.find_by_name('Derierre')
labours.each {|labour| labtoparcelle = Labtoparcelle.create!(:parcelle => parcelle, :labour => labour, :value => 0)}
pulves.each {|pulve| putoparcelle = Putoparcelle.create!(:parcelle => parcelle, :pulve => pulve, :value => 0)}







 # Pont des Champs - Blé - 10Ha

pulves = []
labours = []


pulve = Pulve.create!(:name => 'glyphosate', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2010-10-01', :star => 0, :desc => '')
putoproduit = Putoproduit.create!(:pulve => pulve, :produit => glifonet, :dosage => 5, :saison => saison_2010_2011)
pulves << pulve
pulve = Pulve.create!(:name => 'semis', :cout_ha_passage => 31, :user => trochet, :saison => saison_2010_2011, :date => '2010-10-22', :star => 0, :desc => 'dosage réel=180.</br>début Richepin, fin PR.</br>N°43')
#putoproduit = Putoproduit.create!(:pulve => pulve, :produit => richepain, :dosage => 1, :saison => saison_2010_2011)
#putoproduit = Putoproduit.create!(:pulve => pulve, :produit => pr, :dosage => 1, :saison => saison_2010_2011)
pulves << pulve
pulve = Pulve.create!(:name => 'Super 45', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2011-01-20', :star => 0, :desc => '')
putoproduit = Putoproduit.create!(:pulve => pulve, :produit => super45, :dosage => 153, :saison => saison_2010_2011)
pulves << pulve
pulve = Pulve.create!(:name => 'Azote', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2011-02-08', :star => 0, :desc => '')
putoproduit = Putoproduit.create!(:pulve => pulve, :produit => azote, :dosage => 200, :saison => saison_2010_2011)
pulves << pulve
pulve = Pulve.create!(:name => 'Azote', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2011-03-03', :star => 0, :desc => '')
putoproduit = Putoproduit.create!(:pulve => pulve, :produit => azote, :dosage => 237, :saison => saison_2010_2011)
pulves << pulve
pulve = Pulve.create!(:name => 'Soufre', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2011-03-09', :star => 0, :desc => '')
putoproduit = Putoproduit.create!(:pulve => pulve, :produit => azomag, :dosage => 100, :saison => saison_2010_2011)
pulves << pulve
pulve = Pulve.create!(:name => 'Radar', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2011-03-09', :star => 0, :desc => '')
putoproduit = Putoproduit.create!(:pulve => pulve, :produit => radar, :dosage => 0.275, :saison => saison_2010_2011)
pulves << pulve
pulve = Pulve.create!(:name => 'Proca', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2011-04-04', :star => 1, :desc => 'PZ (?)')
putoproduit = Putoproduit.create!(:pulve => pulve, :produit => proca, :dosage => 1, :saison => saison_2010_2011)
pulves << pulve
pulve = Pulve.create!(:name => 'Vip', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2011-04-20', :star => 1, :desc => 'dosage huile?')
putoproduit = Putoproduit.create!(:pulve => pulve, :produit => vip, :dosage => 0.5, :saison => saison_2010_2011)
putoproduit = Putoproduit.create!(:pulve => pulve, :produit => huile, :dosage => 1, :saison => saison_2010_2011)
pulves << pulve
pulve = Pulve.create!(:name => 'Baravo Elite', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2011-04-30', :star => 0, :desc => '')
putoproduit = Putoproduit.create!(:pulve => pulve, :produit => bravo_elite, :dosage => 1.4, :saison => saison_2010_2011)
pulves << pulve
pulve = Pulve.create!(:name => 'Ariane', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2011-05-04', :star => 0, :desc => '')
putoproduit = Putoproduit.create!(:pulve => pulve, :produit => ariane, :dosage => 3, :saison => saison_2010_2011)
pulves << pulve



parcelle = saison_2010_2011.parcelles.find_by_name('Pont des champs')
labours.each {|labour| labtoparcelle = Labtoparcelle.create!(:parcelle => parcelle, :labour => labour, :value => 0)}
pulves.each {|pulve| putoparcelle = Putoparcelle.create!(:parcelle => parcelle, :pulve => pulve, :value => 0)}







 # aeromodelisme - Blé - 14Ha

pulves = []
labours = []


pulve = Pulve.create!(:name => 'glyphosate', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2010-09-30', :star => 0, :desc => '')
putoproduit = Putoproduit.create!(:pulve => pulve, :produit => glifonet, :dosage => 2, :saison => saison_2010_2011)
putoproduit = Putoproduit.create!(:pulve => pulve, :produit => chardol, :dosage => 0.6, :saison => saison_2010_2011)
pulves << pulve
pulve = Pulve.create!(:name => 'semis', :cout_ha_passage => 31, :user => trochet, :saison => saison_2010_2011, :date => '2010-10-20', :star => 0, :desc => 'dosage reel 175kg/Ha.</br>N°42.')
#putoproduit = Putoproduit.create!(:pulve => pulve, :produit => pr, :dosage => 1, :saison => saison_2010_2011)
#putoproduit = Putoproduit.create!(:pulve => pulve, :produit => paledor, :dosage => 1, :saison => saison_2010_2011)
pulves << pulve
pulve = Pulve.create!(:name => 'Super 45', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2011-01-20', :star => 0, :desc => '')
putoproduit = Putoproduit.create!(:pulve => pulve, :produit => super45, :dosage => 153, :saison => saison_2010_2011)
pulves << pulve
pulve = Pulve.create!(:name => 'Azote', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2011-02-08', :star => 0, :desc => '')
putoproduit = Putoproduit.create!(:pulve => pulve, :produit => azote, :dosage => 200, :saison => saison_2010_2011)
pulves << pulve
pulve = Pulve.create!(:name => 'Radar', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2011-02-11', :star => 1, :desc => 'dosage huile?')
putoproduit = Putoproduit.create!(:pulve => pulve, :produit => radar, :dosage => 0.275, :saison => saison_2010_2011)
putoproduit = Putoproduit.create!(:pulve => pulve, :produit => huile, :dosage => 1, :saison => saison_2010_2011)
pulves << pulve
pulve = Pulve.create!(:name => 'Azote', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2011-03-03', :star => 0, :desc => '')
putoproduit = Putoproduit.create!(:pulve => pulve, :produit => azote, :dosage => 237, :saison => saison_2010_2011)
pulves << pulve
pulve = Pulve.create!(:name => 'Soufre', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2011-03-09', :star => 0, :desc => '')
putoproduit = Putoproduit.create!(:pulve => pulve, :produit => azomag, :dosage => 100, :saison => saison_2010_2011)
pulves << pulve
pulve = Pulve.create!(:name => 'Proca', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2011-04-04', :star => 1, :desc => 'PZ (?)')
putoproduit = Putoproduit.create!(:pulve => pulve, :produit => proca, :dosage => 1, :saison => saison_2010_2011)
pulves << pulve
pulve = Pulve.create!(:name => 'Vip', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2011-04-21', :star => 1, :desc => 'traxos sur 8,3 Ha</br>(remplace Vip).</br>Vip sur 5.7 Ha')
putoproduit = Putoproduit.create!(:pulve => pulve, :produit => traxos, :dosage => 0.711, :saison => saison_2010_2011)
putoproduit = Putoproduit.create!(:pulve => pulve, :produit => vip, :dosage => 0.2036, :saison => saison_2010_2011)
putoproduit = Putoproduit.create!(:pulve => pulve, :produit => huile, :dosage => 1, :saison => saison_2010_2011)
pulves << pulve
pulve = Pulve.create!(:name => 'Bravo Elite', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2011-04-30', :star => 0, :desc => '')
putoproduit = Putoproduit.create!(:pulve => pulve, :produit => bravo_elite, :dosage => 1.4, :saison => saison_2010_2011)
pulves << pulve




parcelle = saison_2010_2011.parcelles.find_by_name('Aeromodelisme')
labours.each {|labour| labtoparcelle = Labtoparcelle.create!(:parcelle => parcelle, :labour => labour, :value => 0)}
pulves.each {|pulve| putoparcelle = Putoparcelle.create!(:parcelle => parcelle, :pulve => pulve, :value => 0)}






 # Mitant - Blé - 5 Ha

pulves = []
labours = []


pulve = Pulve.create!(:name => 'glyphosate', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2010-09-30', :star => 0, :desc => '')
putoproduit = Putoproduit.create!(:pulve => pulve, :produit => glifonet, :dosage => 2, :saison => saison_2010_2011)
putoproduit = Putoproduit.create!(:pulve => pulve, :produit => chardol, :dosage => 0.6, :saison => saison_2010_2011)
pulves << pulve
pulve = Pulve.create!(:name => 'semis', :cout_ha_passage => 31, :user => trochet, :saison => saison_2010_2011, :date => '2010-10-21', :star => 0, :desc => 'dosage reel 165kg/Ha.</br>(Voir plan?)')
#putoproduit = Putoproduit.create!(:pulve => pulve, :produit => pr, :dosage => 55, :saison => saison_2010_2011)
#putoproduit = Putoproduit.create!(:pulve => pulve, :produit => paledor, :dosage => 55, :saison => saison_2010_2011)
#putoproduit = Putoproduit.create!(:pulve => pulve, :produit => altigo, :dosage => 55, :saison => saison_2010_2011)
pulves << pulve
pulve = Pulve.create!(:name => 'Super 45', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2011-01-20', :star => 0, :desc => '')
putoproduit = Putoproduit.create!(:pulve => pulve, :produit => super45, :dosage => 153, :saison => saison_2010_2011)
pulves << pulve
pulve = Pulve.create!(:name => 'Azote', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2011-02-08', :star => 0, :desc => '')
putoproduit = Putoproduit.create!(:pulve => pulve, :produit => azote, :dosage => 200, :saison => saison_2010_2011)
pulves << pulve
pulve = Pulve.create!(:name => 'Azote', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2011-03-03', :star => 0, :desc => '')
putoproduit = Putoproduit.create!(:pulve => pulve, :produit => azote, :dosage => 237, :saison => saison_2010_2011)
pulves << pulve
pulve = Pulve.create!(:name => 'Soufre', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2011-03-09', :star => 0, :desc => '')
putoproduit = Putoproduit.create!(:pulve => pulve, :produit => azomag, :dosage => 100, :saison => saison_2010_2011)
pulves << pulve
pulve = Pulve.create!(:name => 'Radar', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2011-03-14', :star => 1, :desc => 'dosage huile?')
putoproduit = Putoproduit.create!(:pulve => pulve, :produit => radar, :dosage => 0.275, :saison => saison_2010_2011)
putoproduit = Putoproduit.create!(:pulve => pulve, :produit => huile, :dosage => 1, :saison => saison_2010_2011)
pulves << pulve
pulve = Pulve.create!(:name => 'Proca', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2011-04-04', :star => 1, :desc => 'PZ (?)')
putoproduit = Putoproduit.create!(:pulve => pulve, :produit => proca, :dosage => 1, :saison => saison_2010_2011)
pulves << pulve
pulve = Pulve.create!(:name => 'Vip', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2011-04-21', :star => 1, :desc => 'dosage reel : 0,5L/Ha sur 2.5 Ha.')
putoproduit = Putoproduit.create!(:pulve => pulve, :produit => vip, :dosage => 0.25, :saison => saison_2010_2011)
putoproduit = Putoproduit.create!(:pulve => pulve, :produit => huile, :dosage => 0.5, :saison => saison_2010_2011)
pulves << pulve
pulve = Pulve.create!(:name => 'Bravo Elite', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2011-04-30', :star => 0, :desc => '')
putoproduit = Putoproduit.create!(:pulve => pulve, :produit => bravo_elite, :dosage => 1.4, :saison => saison_2010_2011)
pulves << pulve



parcelle = saison_2010_2011.parcelles.find_by_name('Mitant')
labours.each {|labour| labtoparcelle = Labtoparcelle.create!(:parcelle => parcelle, :labour => labour, :value => 0)}
pulves.each {|pulve| putoparcelle = Putoparcelle.create!(:parcelle => parcelle, :pulve => pulve, :value => 0)}







 # Bruneau - Blé - 14 Ha

pulves = []
labours = []


pulve = Pulve.create!(:name => 'glyphosate', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2010-09-30', :star => 0, :desc => '')
putoproduit = Putoproduit.create!(:pulve => pulve, :produit => glifonet, :dosage => 2, :saison => saison_2010_2011)
putoproduit = Putoproduit.create!(:pulve => pulve, :produit => chardol, :dosage => 0.6, :saison => saison_2010_2011)
pulves << pulve
pulve = Pulve.create!(:name => 'semis', :cout_ha_passage => 31, :user => trochet, :saison => saison_2010_2011, :date => '2010-10-21', :star => 0, :desc => 'dosage reel 171kg/Ha.</br>(Richepain au Tour?)</br>N°42')
#putoproduit = Putoproduit.create!(:pulve => pulve, :produit => richepain, :dosage => 85.5, :saison => saison_2010_2011)
#putoproduit = Putoproduit.create!(:pulve => pulve, :produit => paledor, :dosage => 85.5, :saison => saison_2010_2011)
pulves << pulve
pulve = Pulve.create!(:name => 'Super 45', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2011-01-20', :star => 0, :desc => '')
putoproduit = Putoproduit.create!(:pulve => pulve, :produit => super45, :dosage => 153, :saison => saison_2010_2011)
pulves << pulve
pulve = Pulve.create!(:name => 'Azote', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2011-02-08', :star => 0, :desc => '')
putoproduit = Putoproduit.create!(:pulve => pulve, :produit => azote, :dosage => 200, :saison => saison_2010_2011)
pulves << pulve
pulve = Pulve.create!(:name => 'Radar', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2011-02-11', :star => 1, :desc => 'dosage huile?')
putoproduit = Putoproduit.create!(:pulve => pulve, :produit => radar, :dosage => 0.275, :saison => saison_2010_2011)
putoproduit = Putoproduit.create!(:pulve => pulve, :produit => huile, :dosage => 1, :saison => saison_2010_2011)
pulves << pulve
pulve = Pulve.create!(:name => 'Azote', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2011-03-03', :star => 0, :desc => '')
putoproduit = Putoproduit.create!(:pulve => pulve, :produit => azote, :dosage => 237, :saison => saison_2010_2011)
pulves << pulve
pulve = Pulve.create!(:name => 'Soufre', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2011-03-09', :star => 0, :desc => '')
putoproduit = Putoproduit.create!(:pulve => pulve, :produit => azomag, :dosage => 100, :saison => saison_2010_2011)
pulves << pulve
pulve = Pulve.create!(:name => 'Proca', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2011-04-04', :star => 1, :desc => 'PZ (?)')
putoproduit = Putoproduit.create!(:pulve => pulve, :produit => proca, :dosage => 1, :saison => saison_2010_2011)
pulves << pulve
pulve = Pulve.create!(:name => 'Bravo Elite', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2011-04-30', :star => 0, :desc => '')
putoproduit = Putoproduit.create!(:pulve => pulve, :produit => bravo_elite, :dosage => 1.4, :saison => saison_2010_2011)
pulves << pulve

parcelle = saison_2010_2011.parcelles.find_by_name('Bruneau')
labours.each {|labour| labtoparcelle = Labtoparcelle.create!(:parcelle => parcelle, :labour => labour, :value => 0)}
pulves.each {|pulve| putoparcelle = Putoparcelle.create!(:parcelle => parcelle, :pulve => pulve, :value => 0)}



# FIN PULVES & LABOURS

# NE PAS SUPPRIMER

# Parcelles BLE
labours = []
labour = Labour.create!(:name => 'déchaumage blé - 1', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2010-05-01', :star => 0, :category => cat_covercrop, :desc => 'date inconnue')
labours << labour
labour = Labour.create!(:name => 'déchaumage blé - 2', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2010-05-02', :star => 0, :category => cat_covercrop, :desc => 'date inconnue')
labours << labour
labour = Labour.create!(:name => 'déchaumage blé - 3', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2010-05-03', :star => 0, :category => cat_covercrop, :desc => 'date inconnue')
labours << labour
labour = Labour.create!(:name => 'moisson blé', :cout_ha_passage => 75, :user => trochet, :saison => saison_2010_2011, :date => '2010-05-01', :star => 0, :category => cat_moisson, :desc => 'date inconnue')
labours << labour

parcelles_ble.each do |parcelle|
  labours.each {|labour| labtoparcelle = Labtoparcelle.create!(:parcelle => parcelle, :labour => labour, :value => 0)}
end

# Parcelles TOURNESOL
labours = []
labour = Labour.create!(:name => 'moisson tournesol', :cout_ha_passage => 75, :user => trochet, :saison => saison_2010_2011, :date => '2010-05-01', :star => 0, :category => cat_moisson, :desc => 'date inconnue')
labours << labour
parcelles_tournesol.each do |parcelle|
  labours.each {|labour| labtoparcelle = Labtoparcelle.create!(:parcelle => parcelle, :labour => labour, :value => 0)}
end


# Parcelles COLZA
labours = []
labour = Labour.create!(:name => 'moisson colza', :cout_ha_passage => 75, :user => trochet, :saison => saison_2010_2011, :date => '2010-05-01', :star => 0, :category => cat_moisson, :desc => 'date inconnue')
labours << labour
parcelles_colza.each do |parcelle|
  labours.each {|labour| labtoparcelle = Labtoparcelle.create!(:parcelle => parcelle, :labour => labour, :value => 0)}
end




