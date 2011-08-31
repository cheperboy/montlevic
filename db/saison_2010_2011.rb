# TODO
# -> modifier les labours de chaque parcelle


cat_pulve = Upcategory.find_by_name('pulve')
cat_facture = Upcategory.find_by_name('facture')
cat_labour = Upcategory.find_by_name('labour')
cat_vente = Upcategory.find_by_name('vente')
cat_diverse = Upcategory.find_by_name('diverse')

trochet = User.find_by_name('Trochet')

ble = Typeculture.find_by_name("Ble")
bleble = Typeculture.find_by_name("2eme Ble")
tournesol = Typeculture.find_by_name("Tournesol")
colza = Typeculture.find_by_name("Colza")
jachere = Typeculture.find_by_name("Jachere")
luzerne = Typeculture.find_by_name("Luzerne")
typeculture = Typeculture.find(:first)

cat_fongicide = Category.find_by_name('fongicide')
cat_insecticide = Category.find_by_name('insecticide')
cat_azote = Category.find_by_name('azote')
cat_engrais = Category.find_by_name('engrais')
cat_semis = Category.find_by_name('semis')
cat_oligo = Category.find_by_name('oligo')
cat_soufre = Category.find_by_name('soufre')
cat_desherbant = Category.find_by_name('desherbant')
cat_divers = Category.find_by_name('divers')


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

zonetopa = Zonetopa.find(:first)
parcelle = Parcelle.find(:first)
zone = Zone.find(:first)

# ----- FIXTURES -----
factureA = Debit.create!(:name => 'FIXTURE', 
                          :cout => 1000, 
                          :user => User.find(:first),
                          :factype => Factype.find_by_name("diff"),
                          :factcat => Factcat.find_by_name("agri"),
                          :saison => saison_2010_2011,
                          :date => '2011-01-01',
                          :desc => "from seeds",
                          :category => Category.find_by_name('deplacement'))

labourA = Labour.create!(  :name => 'FIXTURE', 
                         :cout_ha_passage => 10, 
                         :user => User.find(:first),
                         :saison => saison_2010_2011,
                         :date => '2011-01-01',
                         :desc => "from seeds",
                         :category => Category.find_by_name('covercrop'))

pulveA = Pulve.create!( :name => 'FIXTURE', 
                       :cout_ha_passage => 0,
                       :user => User.find(:first),
                       :saison => saison_2010_2011,
                       :date => '2011-01-01',
                       :desc => "from seeds")

# PRODUITS - (Generation automatique xls)
altigo = Produit.create!(:name => 'Altigo', :unit =>'L', :category => cat_divers, :saison => saison_2010_2011, :desc => '')
anistar_xtra = Produit.create!(:name => 'Anistar Xtra', :unit =>'L', :category => cat_fongicide, :saison => saison_2010_2011, :desc => '')
ariane = Produit.create!(:name => 'Ariane', :unit =>'L', :category => cat_divers, :saison => saison_2010_2011, :desc => '')
autan = Produit.create!(:name => 'Autan', :unit =>'kg', :category => cat_semis, :saison => saison_2010_2011, :desc => '')
azomag = Produit.create!(:name => 'Azomag', :unit =>'kg', :category => cat_soufre, :saison => saison_2010_2011, :desc => '')
azomag20 = Produit.create!(:name => 'Azomag20', :unit =>'L', :category => cat_soufre, :saison => saison_2010_2011, :desc => '')
azote = Produit.create!(:name => 'Azote', :unit =>'L', :category => cat_azote, :saison => saison_2010_2011, :desc => '')
bravo_elite = Produit.create!(:name => 'Bravo Elite', :unit =>'L', :category => cat_fongicide, :saison => saison_2010_2011, :desc => '')
bravoelite = Produit.create!(:name => 'Bravoelite', :unit =>'L', :category => cat_fongicide, :saison => saison_2010_2011, :desc => '')
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
glyphosate = Produit.create!(:name => 'Glyphosate', :unit =>'L', :category => cat_desherbant, :saison => saison_2010_2011, :desc => '')
harmony = Produit.create!(:name => 'Harmony', :unit =>'kg', :category => cat_semis, :saison => saison_2010_2011, :desc => '')
huile = Produit.create!(:name => 'Huile', :unit =>'L', :category => cat_divers, :saison => saison_2010_2011, :desc => '')
imperio = Produit.create!(:name => 'Imperio', :unit =>'kg', :category => cat_semis, :saison => saison_2010_2011, :desc => '')
lontrel = Produit.create!(:name => 'Lontrel', :unit =>'kg', :category => cat_semis, :saison => saison_2010_2011, :desc => '')
mas91 = Produit.create!(:name => 'MAS 91', :unit =>'L', :category => cat_divers, :saison => saison_2010_2011, :desc => '')
novrel = Produit.create!(:name => 'Novrel', :unit =>'kg', :category => cat_semis, :saison => saison_2010_2011, :desc => '')
ovation = Produit.create!(:name => 'Ovation', :unit =>'kg', :category => cat_semis, :saison => saison_2010_2011, :desc => '')
paledor = Produit.create!(:name => 'Paledor', :unit =>'kg', :category => cat_semis, :saison => saison_2010_2011, :desc => '')
picobore = Produit.create!(:name => 'Picobore', :unit =>'kg', :category => cat_oligo, :saison => saison_2010_2011, :desc => '')
picosolo = Produit.create!(:name => 'Picosolo', :unit =>'kg', :category => cat_desherbant, :saison => saison_2010_2011, :desc => '')
pr = Produit.create!(:name => 'Pr', :unit =>'kg', :category => cat_semis, :saison => saison_2010_2011, :desc => '')
proca = Produit.create!(:name => 'Proca', :unit =>'L', :category => cat_divers, :saison => saison_2010_2011, :desc => '')
proteus = Produit.create!(:name => 'Proteus', :unit =>'L', :category => cat_insecticide, :saison => saison_2010_2011, :desc => '')
pulsar = Produit.create!(:name => 'Pulsar', :unit =>'L', :category => cat_desherbant, :saison => saison_2010_2011, :desc => '')
radar = Produit.create!(:name => 'Radar', :unit =>'L', :category => cat_divers, :saison => saison_2010_2011, :desc => '')
richepain = Produit.create!(:name => 'Richepain', :unit =>'kg', :category => cat_divers, :saison => saison_2010_2011, :desc => '')
springbok = Produit.create!(:name => 'Springbok', :unit =>'L', :category => cat_desherbant, :saison => saison_2010_2011, :desc => '')
stratos = Produit.create!(:name => 'Stratos', :unit =>'L', :category => cat_divers, :saison => saison_2010_2011, :desc => '')
super45 = Produit.create!(:name => 'Super45', :unit =>'L', :category => cat_divers, :saison => saison_2010_2011, :desc => '')
surnog = Produit.create!(:name => 'Surnog', :unit =>'L', :category => cat_fongicide, :saison => saison_2010_2011, :desc => '')
traxos = Produit.create!(:name => 'Traxos', :unit =>'L', :category => cat_desherbant, :saison => saison_2010_2011, :desc => '')
vip = Produit.create!(:name => 'Vip', :unit =>'L', :category => cat_divers, :saison => saison_2010_2011, :desc => '')
zero2030 = Produit.create!(:name => '0-20-30', :unit =>'kg', :category => cat_engrais, :saison => saison_2010_2011, :desc => '')
zero2525 = Produit.create!(:name => '0-25-25', :unit =>'kg', :category => cat_engrais, :saison => saison_2010_2011, :desc => '') 




# PULVES - (generation automatique xls)

 # Les Vallées - Tournesol - 11Ha
pulves = nil
pulves = []
pulve = Pulve.create!(:name => 'Glyphosate', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2011-03-11', :star => 1, :desc => 'verifier les date (2010 ou 2011?).</br>verifier le dosage huile.')
putoproduit = Putoproduit.create!(:pulve => pulve, :produit => glyphosate, :dosage => 2, :saison => saison_2010_2011)
putoproduit = Putoproduit.create!(:pulve => pulve, :produit => huile, :dosage => 99, :saison => saison_2010_2011)
pulves << pulve
pulve = Pulve.create!(:name => 'Engrais 0-20-30', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2011-03-20', :star => 0, :desc => '')
putoproduit = Putoproduit.create!(:pulve => pulve, :produit => zero2030, :dosage => 250, :saison => saison_2010_2011)
pulves << pulve
pulve = Pulve.create!(:name => 'Semis', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2011-04-06', :star => 1, :desc => 'indiquer :</br>->la variété</br>->les dosages.</br>->modifier le cout_ha_passage du semis.</br>MAS 91 : 6Ha (PMG 58g).</br>Campus : 5Ha (PMG 78g).')
putoproduit = Putoproduit.create!(:pulve => pulve, :produit => campus, :dosage => 99, :saison => saison_2010_2011)
putoproduit = Putoproduit.create!(:pulve => pulve, :produit => mas91, :dosage => 99, :saison => saison_2010_2011)
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

labours = Labour.create!([
 {:name => 'moisson', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2009-01-01',
 :desc => "", :category => Category.find_by_name('moisson')} ])
parcelle = saison_2010_2011.parcelles.find_by_name('Vallees')
pulves.each do |pulve|
  putoparcelle = Putoparcelle.create!(:parcelle => parcelle, :pulve => pulve, :value => 0)
end
labours.each do |labour|
  labtoparcelle = Labtoparcelle.create!(:parcelle => parcelle, :labour => labour, :value => 0)
end




 # Champ du milieu - Tournesol - 9Ha
pulves = nil
pulves = []
pulve = Pulve.create!(:name => 'Glyphosate', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2011-03-11', :star => 1, :desc => 'verifier les date (2010 ou 2011?).</br>verifier le dosage huile.')
putoproduit = Putoproduit.create!(:pulve => pulve, :produit => glyphosate, :dosage => 2, :saison => saison_2010_2011)
putoproduit = Putoproduit.create!(:pulve => pulve, :produit => huile, :dosage => 99, :saison => saison_2010_2011)
pulves << pulve
pulve = Pulve.create!(:name => 'Engrais 0-20-30', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2011-03-20', :star => 0, :desc => '')
putoproduit = Putoproduit.create!(:pulve => pulve, :produit => zero2030, :dosage => 250, :saison => saison_2010_2011)
pulves << pulve
pulve = Pulve.create!(:name => 'Semis', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2011-04-06', :star => 1, :desc => 'modifier le cout_ha_passage et le dosage')
putoproduit = Putoproduit.create!(:pulve => pulve, :produit => campus, :dosage => 99, :saison => saison_2010_2011)
pulves << pulve
pulve = Pulve.create!(:name => 'Challenge', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2011-04-11', :star => 0, :desc => '')
putoproduit = Putoproduit.create!(:pulve => pulve, :produit => challenge, :dosage => 4, :saison => saison_2010_2011)
pulves << pulve
labours = Labour.create!([
 {:name => 'moisson', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2009-01-01',
 :desc => "", :category => Category.find_by_name('moisson')} ])
parcelle = saison_2010_2011.parcelles.find_by_name('Champ du Milieu')
pulves.each do |pulve|
  putoparcelle = Putoparcelle.create!(:parcelle => parcelle, :pulve => pulve, :value => 0)
end
labours.each do |labour|
  labtoparcelle = Labtoparcelle.create!(:parcelle => parcelle, :labour => labour, :value => 0)
end


 # Basse-cour - Colza - 2Ha
pulves = nil
pulves = []
pulve = Pulve.create!(:name => 'Semis', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2010-08-31', :star => 0, :desc => '')
putoproduit = Putoproduit.create!(:pulve => pulve, :produit => catalino, :dosage => 3.5, :saison => saison_2010_2011)
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
pulve = Pulve.create!(:name => 'picobore', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2011-03-20', :star => 0, :desc => '')
putoproduit = Putoproduit.create!(:pulve => pulve, :produit => picobore, :dosage => 2.5, :saison => saison_2010_2011)
putoproduit = Putoproduit.create!(:pulve => pulve, :produit => proteus, :dosage => 0.5, :saison => saison_2010_2011)
pulves << pulve
pulve = Pulve.create!(:name => 'Surnog', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2011-04-02', :star => 0, :desc => '')
putoproduit = Putoproduit.create!(:pulve => pulve, :produit => surnog, :dosage => 0.6, :saison => saison_2010_2011)
pulves << pulve
pulve = Pulve.create!(:name => 'anistar_xtra', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2011-04-20', :star => 0, :desc => '')
putoproduit = Putoproduit.create!(:pulve => pulve, :produit => anistar_xtra, :dosage => 0.75, :saison => saison_2010_2011)
pulves << pulve

labours = Labour.create!([
 {:name => 'moisson', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2009-01-01',
 :desc => "", :category => Category.find_by_name('moisson')} ])
parcelle = saison_2010_2011.parcelles.find_by_name('Basse-cour')
pulves.each do |pulve|
  putoparcelle = Putoparcelle.create!(:parcelle => parcelle, :pulve => pulve, :value => 0)
end
labours.each do |labour|
  labtoparcelle = Labtoparcelle.create!(:parcelle => parcelle, :labour => labour, :value => 0)
end


 # Derierre - Colza - 14Ha
pulves = nil
pulves = []
pulve = Pulve.create!(:name => 'Semis', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2010-08-30', :star => 1, :desc => 'dosage reel = 3.5Kg/Ha.</br>Selection Ovation au milieu entre les deux poteaux, voir plan)')
putoproduit = Putoproduit.create!(:pulve => pulve, :produit => catalino, :dosage => 2, :saison => saison_2010_2011)
putoproduit = Putoproduit.create!(:pulve => pulve, :produit => ovation, :dosage => 1.5, :saison => saison_2010_2011)
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
pulve = Pulve.create!(:name => 'picobore', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2011-03-24', :star => 0, :desc => '')
putoproduit = Putoproduit.create!(:pulve => pulve, :produit => picobore, :dosage => 2.5, :saison => saison_2010_2011)
putoproduit = Putoproduit.create!(:pulve => pulve, :produit => proteus, :dosage => 0.5, :saison => saison_2010_2011)
pulves << pulve
pulve = Pulve.create!(:name => 'Surnog', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2011-04-02', :star => 0, :desc => '')
putoproduit = Putoproduit.create!(:pulve => pulve, :produit => surnog, :dosage => 0.6, :saison => saison_2010_2011)
pulves << pulve
pulve = Pulve.create!(:name => 'anistar_xtra', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2011-04-20', :star => 0, :desc => '')
putoproduit = Putoproduit.create!(:pulve => pulve, :produit => anistar_xtra, :dosage => 0.75, :saison => saison_2010_2011)
pulves << pulve


labours = Labour.create!([
 {:name => 'moisson', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2009-01-01',
 :desc => "", :category => Category.find_by_name('moisson')} ])
parcelle = saison_2010_2011.parcelles.find_by_name('Derierre')
pulves.each do |pulve|
  putoparcelle = Putoparcelle.create!(:parcelle => parcelle, :pulve => pulve, :value => 0)
end
labours.each do |labour|
  labtoparcelle = Labtoparcelle.create!(:parcelle => parcelle, :labour => labour, :value => 0)
end

 # Pont des Champs - Blé - 10Ha
pulves = nil
pulves = []
pulve = Pulve.create!(:name => 'glyphosate', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2010-10-01', :star => 0, :desc => '')
putoproduit = Putoproduit.create!(:pulve => pulve, :produit => glyphosate, :dosage => 5, :saison => saison_2010_2011)
pulves << pulve
pulve = Pulve.create!(:name => 'semis', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2010-10-22', :star => 0, :desc => 'dosage réel=180.</br>début Richepin, fin PR.</br>N°43')
putoproduit = Putoproduit.create!(:pulve => pulve, :produit => richepain, :dosage => 90, :saison => saison_2010_2011)
putoproduit = Putoproduit.create!(:pulve => pulve, :produit => pr, :dosage => 90, :saison => saison_2010_2011)
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
putoproduit = Putoproduit.create!(:pulve => pulve, :produit => radar, :dosage => 275, :saison => saison_2010_2011)
pulves << pulve
pulve = Pulve.create!(:name => 'Proca', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2011-04-04', :star => 1, :desc => 'PZ (?)')
putoproduit = Putoproduit.create!(:pulve => pulve, :produit => proca, :dosage => 1, :saison => saison_2010_2011)
pulves << pulve
pulve = Pulve.create!(:name => 'Vip', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2011-04-20', :star => 1, :desc => 'dosage huile?')
putoproduit = Putoproduit.create!(:pulve => pulve, :produit => vip, :dosage => 0.5, :saison => saison_2010_2011)
putoproduit = Putoproduit.create!(:pulve => pulve, :produit => huile, :dosage => 1, :saison => saison_2010_2011)
pulves << pulve
pulve = Pulve.create!(:name => 'Baravo Elite', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2011-04-30', :star => 0, :desc => '')
putoproduit = Putoproduit.create!(:pulve => pulve, :produit => bravoelite, :dosage => 1.4, :saison => saison_2010_2011)
pulves << pulve
pulve = Pulve.create!(:name => 'Ariane', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2011-05-04', :star => 0, :desc => '')
putoproduit = Putoproduit.create!(:pulve => pulve, :produit => ariane, :dosage => 3, :saison => saison_2010_2011)
pulves << pulve


labours = Labour.create!([
 {:name => 'moisson', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2009-01-01',
 :desc => "", :category => Category.find_by_name('moisson')} ])
parcelle = saison_2010_2011.parcelles.find_by_name('Pont des champs')
pulves.each do |pulve|
  putoparcelle = Putoparcelle.create!(:parcelle => parcelle, :pulve => pulve, :value => 0)
end
labours.each do |labour|
  labtoparcelle = Labtoparcelle.create!(:parcelle => parcelle, :labour => labour, :value => 0)
end

 # aeromodelisme - Blé - 14Ha
pulves = nil
pulves = []
pulve = Pulve.create!(:name => 'glyphosate', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2010-09-30', :star => 0, :desc => '')
putoproduit = Putoproduit.create!(:pulve => pulve, :produit => glyphosate, :dosage => 2, :saison => saison_2010_2011)
putoproduit = Putoproduit.create!(:pulve => pulve, :produit => chardol, :dosage => 0.6, :saison => saison_2010_2011)
pulves << pulve
pulve = Pulve.create!(:name => 'semis', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2010-10-20', :star => 0, :desc => 'dosage reel 175kg/Ha.</br>N°42.')
putoproduit = Putoproduit.create!(:pulve => pulve, :produit => pr, :dosage => 87.5, :saison => saison_2010_2011)
putoproduit = Putoproduit.create!(:pulve => pulve, :produit => paledor, :dosage => 87.5, :saison => saison_2010_2011)
pulves << pulve
pulve = Pulve.create!(:name => 'Super 45', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2011-01-20', :star => 0, :desc => '')
putoproduit = Putoproduit.create!(:pulve => pulve, :produit => super45, :dosage => 153, :saison => saison_2010_2011)
pulves << pulve
pulve = Pulve.create!(:name => 'Azote', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2011-02-08', :star => 0, :desc => '')
putoproduit = Putoproduit.create!(:pulve => pulve, :produit => azote, :dosage => 200, :saison => saison_2010_2011)
pulves << pulve
pulve = Pulve.create!(:name => 'Radar', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2011-02-11', :star => 1, :desc => 'dosage huile?')
putoproduit = Putoproduit.create!(:pulve => pulve, :produit => radar, :dosage => 275, :saison => saison_2010_2011)
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


labours = Labour.create!([
 {:name => 'moisson', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2009-01-01',
 :desc => "", :category => Category.find_by_name('moisson')} ])
parcelle = saison_2010_2011.parcelles.find_by_name('Aeromodelisme')
pulves.each do |pulve|
  putoparcelle = Putoparcelle.create!(:parcelle => parcelle, :pulve => pulve, :value => 0)
end
labours.each do |labour|
  labtoparcelle = Labtoparcelle.create!(:parcelle => parcelle, :labour => labour, :value => 0)
end

 # Mitant - Blé - 5 Ha
pulves = nil
pulves = []
pulve = Pulve.create!(:name => 'glyphosate', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2010-09-30', :star => 0, :desc => '')
putoproduit = Putoproduit.create!(:pulve => pulve, :produit => glyphosate, :dosage => 2, :saison => saison_2010_2011)
putoproduit = Putoproduit.create!(:pulve => pulve, :produit => chardol, :dosage => 0.6, :saison => saison_2010_2011)
pulves << pulve
pulve = Pulve.create!(:name => 'semis', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2010-10-21', :star => 0, :desc => 'dosage reel 165kg/Ha.</br>(Voir plan?)')
putoproduit = Putoproduit.create!(:pulve => pulve, :produit => pr, :dosage => 55, :saison => saison_2010_2011)
putoproduit = Putoproduit.create!(:pulve => pulve, :produit => paledor, :dosage => 55, :saison => saison_2010_2011)
putoproduit = Putoproduit.create!(:pulve => pulve, :produit => altigo, :dosage => 55, :saison => saison_2010_2011)
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
putoproduit = Putoproduit.create!(:pulve => pulve, :produit => radar, :dosage => 275, :saison => saison_2010_2011)
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


labours = Labour.create!([
 {:name => 'moisson', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2009-01-01',
 :desc => "", :category => Category.find_by_name('moisson')} ])
parcelle = saison_2010_2011.parcelles.find_by_name('Mitant')
pulves.each do |pulve|
  putoparcelle = Putoparcelle.create!(:parcelle => parcelle, :pulve => pulve, :value => 0)
end
labours.each do |labour|
  labtoparcelle = Labtoparcelle.create!(:parcelle => parcelle, :labour => labour, :value => 0)
end

 # Bruneau - Blé - 14 Ha
pulves = nil
pulves = []
pulve = Pulve.create!(:name => 'glyphosate', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2010-09-30', :star => 0, :desc => '')
putoproduit = Putoproduit.create!(:pulve => pulve, :produit => glyphosate, :dosage => 2, :saison => saison_2010_2011)
putoproduit = Putoproduit.create!(:pulve => pulve, :produit => chardol, :dosage => 0.6, :saison => saison_2010_2011)
pulves << pulve
pulve = Pulve.create!(:name => 'semis', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2010-10-21', :star => 0, :desc => 'dosage reel 171kg/Ha.</br>(Richepain au Tour?)</br>N°42')
putoproduit = Putoproduit.create!(:pulve => pulve, :produit => richepain, :dosage => 85.5, :saison => saison_2010_2011)
putoproduit = Putoproduit.create!(:pulve => pulve, :produit => paledor, :dosage => 85.5, :saison => saison_2010_2011)
pulves << pulve
pulve = Pulve.create!(:name => 'Super 45', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2011-01-20', :star => 0, :desc => '')
putoproduit = Putoproduit.create!(:pulve => pulve, :produit => super45, :dosage => 153, :saison => saison_2010_2011)
pulves << pulve
pulve = Pulve.create!(:name => 'Azote', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2011-02-08', :star => 0, :desc => '')
putoproduit = Putoproduit.create!(:pulve => pulve, :produit => azote, :dosage => 200, :saison => saison_2010_2011)
pulves << pulve
pulve = Pulve.create!(:name => 'Radar', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2011-02-11', :star => 1, :desc => 'dosage huile?')
putoproduit = Putoproduit.create!(:pulve => pulve, :produit => radar, :dosage => 275, :saison => saison_2010_2011)
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


labours = Labour.create!([
 {:name => 'moisson', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2009-01-01',
 :desc => "", :category => Category.find_by_name('moisson')} ])
parcelle = saison_2010_2011.parcelles.find_by_name('Bruneau')
pulves.each do |pulve|
  putoparcelle = Putoparcelle.create!(:parcelle => parcelle, :pulve => pulve, :value => 0)
end
labours.each do |labour|
  labtoparcelle = Labtoparcelle.create!(:parcelle => parcelle, :labour => labour, :value => 0)
end

# FIN PULVES - generation automatique de code

# # Les Vallées - Tournesol - 11Ha
# pulves = nil
# pulves = []
# pulve = Pulve.create!(:name => 'Glyphosate', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2011-03-11', :star => 1, :desc => 'verifier /\n/les date (2010 ou 2011?)./\n/Verifier le dosage \nhuile.')
# putoproduit = Putoproduit.create!(:pulve => pulve, :produit => glyphosate, :dosage => 2, :saison => saison_2010_2011)
# putoproduit = Putoproduit.create!(:pulve => pulve, :produit => huile, :dosage => 99, :saison => saison_2010_2011)
# pulves << pulve
# pulve = Pulve.create!(:name => 'Engrais 0-20-30', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2011-03-20', :star => 0, :desc => '')
# putoproduit = Putoproduit.create!(:pulve => pulve, :produit => zero2030, :dosage => 250, :saison => saison_2010_2011)
# pulves << pulve
# pulve = Pulve.create!(:name => 'Semis', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2011-04-06', :star => 1, :desc => 'indiquer :</br>->la variété</br>->les dosages.</br>->modifier le cout_ha_passage du semis.</br>MAS 91 : 6Ha (PMG 58g).</br>Campus : 5Ha (PMG 78g).')
# putoproduit = Putoproduit.create!(:pulve => pulve, :produit => campus, :dosage => 99, :saison => saison_2010_2011)
# putoproduit = Putoproduit.create!(:pulve => pulve, :produit => mas91, :dosage => 99, :saison => saison_2010_2011)
# pulves << pulve
# pulve = Pulve.create!(:name => 'Cline', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2011-04-07', :star => 0, :desc => '2.5 L/Ha sur 6Ha</br>=> 2,5 x 6 / 11</br>=> 1,3636')
# putoproduit = Putoproduit.create!(:pulve => pulve, :produit => cline, :dosage => 1.3636, :saison => saison_2010_2011)
# pulves << pulve
# pulve = Pulve.create!(:name => 'Challenge', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2011-04-11', :star => 0, :desc => '4 L/Ha sur 5Ha</br>=> 4 x 5 / 11</br>=> 1,8182')
# putoproduit = Putoproduit.create!(:pulve => pulve, :produit => challenge, :dosage => 1.8182, :saison => saison_2010_2011)
# pulves << pulve
# pulve = Pulve.create!(:name => 'pulsar', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2011-05-20', :star => 0, :desc => '1,25 L/Ha sur 6Ha</br>=> 1,25 x 6 / 11</br>=> 0,68182')
# putoproduit = Putoproduit.create!(:pulve => pulve, :produit => pulsar, :dosage => 0.68182, :saison => saison_2010_2011)
# pulves << pulve
# 
# labours = Labour.create!([
#  {:name => 'moisson', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2009-01-01',
#  :desc => "", :category => Category.find_by_name('moisson')} ])
# 
# parcelle = saison_2010_2011.parcelles.find_by_name('Vallees')
# 
# pulves.each do |pulve|
#   putoparcelle = Putoparcelle.create!(:parcelle => parcelle, :pulve => pulve, :value => 0)
# end
# labours.each do |labour|
#   labtoparcelle = Labtoparcelle.create!(:parcelle => parcelle, :labour => labour, :value => 0)
# end
# 
# 
# # Champ du milieu - Tournesol - 9Ha
# pulves = nil
# pulves = []
# pulve = Pulve.create!(:name => 'Glyphosate', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2011-03-11', :star => 1, :desc => 'verifier les date (2010 ou 2011?).</br>verifier le dosage huile.')
# putoproduit = Putoproduit.create!(:pulve => pulve, :produit => glyphosate, :dosage => 2, :saison => saison_2010_2011)
# putoproduit = Putoproduit.create!(:pulve => pulve, :produit => huile, :dosage => 99, :saison => saison_2010_2011)
# pulves << pulve
# pulve = Pulve.create!(:name => 'Engrais 0-20-30', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2011-03-20', :star => 0, :desc => '')
# putoproduit = Putoproduit.create!(:pulve => pulve, :produit => zero2030, :dosage => 250, :saison => saison_2010_2011)
# pulves << pulve
# pulve = Pulve.create!(:name => 'Semis', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2011-04-06', :star => 1, :desc => 'modifier le cout_ha_passage et le dosage')
# putoproduit = Putoproduit.create!(:pulve => pulve, :produit => campus, :dosage => 99, :saison => saison_2010_2011)
# pulve = Pulve.create!(:name => 'Challenge', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2011-04-11', :star => 0, :desc => '')
# putoproduit = Putoproduit.create!(:pulve => pulve, :produit => challenge, :dosage => 4, :saison => saison_2010_2011)
# pulves << pulve
# 
# labours = Labour.create!([
#  {:name => 'moisson', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2009-01-01',
#  :desc => "", :category => Category.find_by_name('moisson')} ])
# 
# parcelle = saison_2010_2011.parcelles.find_by_name('Champ du Milieu')
# 
# pulves.each do |pulve|
#   putoparcelle = Putoparcelle.create!(:parcelle => parcelle, :pulve => pulve, :value => 0)
# end
# labours.each do |labour|
#   labtoparcelle = Labtoparcelle.create!(:parcelle => parcelle, :labour => labour, :value => 0)
# end
# 
#  # Basse-cour - Colza - 2Ha
#  pulves = nil
#  pulves = []
#  pulve = Pulve.create!(:name => 'Semis', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2010-08-31', :star => 0, :desc => '')
# putoproduit = Putoproduit.create!(:pulve => pulve, :produit => catalino, :dosage => 3.5, :saison => saison_2010_2011)
# pulves << pulve
# pulve = Pulve.create!(:name => 'colzamid', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2010-08-31', :star => 0, :desc => '')
# putoproduit = Putoproduit.create!(:pulve => pulve, :produit => colzamid, :dosage => 1.8, :saison => saison_2010_2011)
# pulves << pulve
# pulve = Pulve.create!(:name => 'springbok', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2010-09-02', :star => 0, :desc => '')
# putoproduit = Putoproduit.create!(:pulve => pulve, :produit => springbok, :dosage => 2.5, :saison => saison_2010_2011)
# pulves << pulve
# pulve = Pulve.create!(:name => 'Folyr', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2010-10-07', :star => 0, :desc => '')
# putoproduit = Putoproduit.create!(:pulve => pulve, :produit => folyr, :dosage => 0.6, :saison => saison_2010_2011)
# putoproduit = Putoproduit.create!(:pulve => pulve, :produit => huile, :dosage => 1, :saison => saison_2010_2011)
# putoproduit = Putoproduit.create!(:pulve => pulve, :produit => fury, :dosage => 0.1, :saison => saison_2010_2011)
# pulves << pulve
# pulve = Pulve.create!(:name => '0-20-30', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2011-01-23', :star => 0, :desc => '')
# putoproduit = Putoproduit.create!(:pulve => pulve, :produit => zero2030, :dosage => 200, :saison => saison_2010_2011)
# pulves << pulve
# pulve = Pulve.create!(:name => 'Azote', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2011-02-08', :star => 0, :desc => '81u.</br>N°38 (? Cf carnet trochet)')
# putoproduit = Putoproduit.create!(:pulve => pulve, :produit => azote, :dosage => 243, :saison => saison_2010_2011)
# pulves << pulve
# pulve = Pulve.create!(:name => 'Stratos', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2011-02-10', :star => 0, :desc => '')
# putoproduit = Putoproduit.create!(:pulve => pulve, :produit => stratos, :dosage => 2, :saison => saison_2010_2011)
# pulves << pulve
# pulve = Pulve.create!(:name => 'Azote', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2011-03-03', :star => 0, :desc => '94u.</br>N°40')
# putoproduit = Putoproduit.create!(:pulve => pulve, :produit => azote, :dosage => 281, :saison => saison_2010_2011)
# pulves << pulve
# pulve = Pulve.create!(:name => 'Soufre', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2011-03-08', :star => 0, :desc => '')
# putoproduit = Putoproduit.create!(:pulve => pulve, :produit => azomag, :dosage => 150, :saison => saison_2010_2011)
# pulves << pulve
# pulve = Pulve.create!(:name => 'Fury', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2011-03-08', :star => 0, :desc => '')
# putoproduit = Putoproduit.create!(:pulve => pulve, :produit => fury, :dosage => 0.1, :saison => saison_2010_2011)
# pulves << pulve
# pulve = Pulve.create!(:name => 'chrono', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2011-03-08', :star => 0, :desc => '')
# putoproduit = Putoproduit.create!(:pulve => pulve, :produit => chrono, :dosage => 1.25, :saison => saison_2010_2011)
# putoproduit = Putoproduit.create!(:pulve => pulve, :produit => lontrel, :dosage => 1, :saison => saison_2010_2011)
# pulves << pulve
# pulve = Pulve.create!(:name => 'picobore', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2011-03-20', :star => 0, :desc => '')
# putoproduit = Putoproduit.create!(:pulve => pulve, :produit => picobore, :dosage => 2.5, :saison => saison_2010_2011)
# putoproduit = Putoproduit.create!(:pulve => pulve, :produit => proteus, :dosage => 0.5, :saison => saison_2010_2011)
# pulves << pulve
# pulve = Pulve.create!(:name => 'Surnog', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2011-04-02', :star => 0, :desc => '')
# putoproduit = Putoproduit.create!(:pulve => pulve, :produit => surnog, :dosage => 0.6, :saison => saison_2010_2011)
# pulves << pulve
# pulve = Pulve.create!(:name => 'anistar_xtra', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2011-04-20', :star => 0, :desc => '')
# putoproduit = Putoproduit.create!(:pulve => pulve, :produit => anistar_xtra, :dosage => 0.75, :saison => saison_2010_2011)
# pulves << pulve
# 
# 
# labours = Labour.create!([
#  {:name => 'moisson', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2009-01-01',
#  :desc => "", :category => Category.find_by_name('moisson')} ])
# 
# parcelle = saison_2010_2011.parcelles.find_by_name('Basse-cour')
# 
# pulves.each do |pulve|
#   putoparcelle = Putoparcelle.create!(:parcelle => parcelle, :pulve => pulve, :value => 0)
# end
# labours.each do |labour|
#   labtoparcelle = Labtoparcelle.create!(:parcelle => parcelle, :labour => labour, :value => 0)
# end
# 
# 
#  # Derierre - Colza - 14Ha
#  pulves = nil
#  pulves = []
#  pulve = Pulve.create!(:name => 'Semis', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2010-08-30', :star => 1, :desc => 'dosage reel = 3.5Kg/Ha.</br>Selection Ovation au milieu entre les deux poteaux, voir plan)')
# putoproduit = Putoproduit.create!(:pulve => pulve, :produit => catalino, :dosage => 2, :saison => saison_2010_2011)
# putoproduit = Putoproduit.create!(:pulve => pulve, :produit => ovation, :dosage => 1.5, :saison => saison_2010_2011)
# pulves << pulve
# pulve = Pulve.create!(:name => 'colzamid', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2010-08-30', :star => 0, :desc => '')
# putoproduit = Putoproduit.create!(:pulve => pulve, :produit => colzamid, :dosage => 1.8, :saison => saison_2010_2011)
# pulves << pulve
# pulve = Pulve.create!(:name => 'springbok', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2010-09-02', :star => 0, :desc => '')
# putoproduit = Putoproduit.create!(:pulve => pulve, :produit => springbok, :dosage => 2.5, :saison => saison_2010_2011)
# pulves << pulve
# pulve = Pulve.create!(:name => 'Folyr', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2010-10-07', :star => 0, :desc => '')
# putoproduit = Putoproduit.create!(:pulve => pulve, :produit => folyr, :dosage => 0.6, :saison => saison_2010_2011)
# putoproduit = Putoproduit.create!(:pulve => pulve, :produit => huile, :dosage => 1, :saison => saison_2010_2011)
# putoproduit = Putoproduit.create!(:pulve => pulve, :produit => fury, :dosage => 0.1, :saison => saison_2010_2011)
# pulves << pulve
# pulve = Pulve.create!(:name => '0-20-30', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2011-01-23', :star => 0, :desc => '')
# putoproduit = Putoproduit.create!(:pulve => pulve, :produit => zero2030, :dosage => 200, :saison => saison_2010_2011)
# pulves << pulve
# pulve = Pulve.create!(:name => 'Azote', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2011-02-08', :star => 0, :desc => '81u.</br>N°38')
# putoproduit = Putoproduit.create!(:pulve => pulve, :produit => azote, :dosage => 243, :saison => saison_2010_2011)
# pulves << pulve
# pulve = Pulve.create!(:name => 'Azote', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2011-03-03', :star => 0, :desc => '94u.</br>N°40')
# putoproduit = Putoproduit.create!(:pulve => pulve, :produit => azote, :dosage => 280, :saison => saison_2010_2011)
# pulves << pulve
# pulve = Pulve.create!(:name => 'Soufre', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2011-03-08', :star => 0, :desc => '')
# putoproduit = Putoproduit.create!(:pulve => pulve, :produit => azomag, :dosage => 150, :saison => saison_2010_2011)
# pulves << pulve
# pulve = Pulve.create!(:name => 'Fury', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2011-03-09', :star => 0, :desc => '')
# putoproduit = Putoproduit.create!(:pulve => pulve, :produit => fury, :dosage => 0.1, :saison => saison_2010_2011)
# pulves << pulve
# pulve = Pulve.create!(:name => 'chrono', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2011-03-08', :star => 0, :desc => 'dosages reel sur 8Ha:</br>chrono : 1,25L/Ha.</br>lontrel : 1L/Ha.')
# putoproduit = Putoproduit.create!(:pulve => pulve, :produit => chrono, :dosage => 0.714, :saison => saison_2010_2011)
# putoproduit = Putoproduit.create!(:pulve => pulve, :produit => lontrel, :dosage => 0.571, :saison => saison_2010_2011)
# pulves << pulve
# pulve = Pulve.create!(:name => 'picobore', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2011-03-24', :star => 0, :desc => '')
# putoproduit = Putoproduit.create!(:pulve => pulve, :produit => picobore, :dosage => 2.5, :saison => saison_2010_2011)
# putoproduit = Putoproduit.create!(:pulve => pulve, :produit => proteus, :dosage => 0.5, :saison => saison_2010_2011)
# pulves << pulve
# pulve = Pulve.create!(:name => 'Surnog', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2011-04-02', :star => 0, :desc => '')
# putoproduit = Putoproduit.create!(:pulve => pulve, :produit => surnog, :dosage => 0.6, :saison => saison_2010_2011)
# pulves << pulve
# pulve = Pulve.create!(:name => 'anistar_xtra', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2011-04-20', :star => 0, :desc => '')
# putoproduit = Putoproduit.create!(:pulve => pulve, :produit => anistar_xtra, :dosage => 0.75, :saison => saison_2010_2011)
# pulves << pulve
# 
# labours = Labour.create!([
#  {:name => 'moisson', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2009-01-01',
#  :desc => "", :category => Category.find_by_name('moisson')} ])
# 
# parcelle = saison_2010_2011.parcelles.find_by_name('Derierre')
# 
# pulves.each do |pulve|
#   putoparcelle = Putoparcelle.create!(:parcelle => parcelle, :pulve => pulve, :value => 0)
# end
# labours.each do |labour|
#   labtoparcelle = Labtoparcelle.create!(:parcelle => parcelle, :labour => labour, :value => 0)
# end
# 
# 
# 
#  # Pont des Champs - Blé - 10Ha
#  pulves = nil
#  pulves = []
#  pulve = Pulve.create!(:name => 'glyphosate', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2010-10-01', :star => 0, :desc => '')
# putoproduit = Putoproduit.create!(:pulve => pulve, :produit => glyphosate, :dosage => 5, :saison => saison_2010_2011)
# pulves << pulve
# pulve = Pulve.create!(:name => 'semis', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2010-10-22', :star => 0, :desc => 'dosage réel=180.</br>début Richepin, fin PR.</br>N°43')
# putoproduit = Putoproduit.create!(:pulve => pulve, :produit => richepain, :dosage => 90, :saison => saison_2010_2011)
# putoproduit = Putoproduit.create!(:pulve => pulve, :produit => pr, :dosage => 90, :saison => saison_2010_2011)
# pulves << pulve
# pulve = Pulve.create!(:name => 'Super 45', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2011-01-20', :star => 0, :desc => '')
# putoproduit = Putoproduit.create!(:pulve => pulve, :produit => super45, :dosage => 153, :saison => saison_2010_2011)
# pulves << pulve
# pulve = Pulve.create!(:name => 'Azote', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2011-02-08', :star => 0, :desc => '')
# putoproduit = Putoproduit.create!(:pulve => pulve, :produit => azote, :dosage => 200, :saison => saison_2010_2011)
# pulves << pulve
# pulve = Pulve.create!(:name => 'Azote', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2011-03-03', :star => 0, :desc => '')
# putoproduit = Putoproduit.create!(:pulve => pulve, :produit => azote, :dosage => 237, :saison => saison_2010_2011)
# pulves << pulve
# pulve = Pulve.create!(:name => 'Soufre', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2011-03-09', :star => 0, :desc => '')
# putoproduit = Putoproduit.create!(:pulve => pulve, :produit => azomag, :dosage => 100, :saison => saison_2010_2011)
# pulves << pulve
# pulve = Pulve.create!(:name => 'Radar', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2011-03-09', :star => 0, :desc => '')
# putoproduit = Putoproduit.create!(:pulve => pulve, :produit => radar, :dosage => 275, :saison => saison_2010_2011)
# pulves << pulve
# pulve = Pulve.create!(:name => 'Proca', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2011-04-04', :star => 1, :desc => 'PZ (?)')
# putoproduit = Putoproduit.create!(:pulve => pulve, :produit => proca, :dosage => 1, :saison => saison_2010_2011)
# pulves << pulve
# pulve = Pulve.create!(:name => 'Vip', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2011-04-20', :star => 1, :desc => 'dosage huile?')
# putoproduit = Putoproduit.create!(:pulve => pulve, :produit => vip, :dosage => 0.5, :saison => saison_2010_2011)
# putoproduit = Putoproduit.create!(:pulve => pulve, :produit => huile, :dosage => 1, :saison => saison_2010_2011)
# pulves << pulve
# pulve = Pulve.create!(:name => 'Baravo Elite', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2011-04-30', :star => 0, :desc => '')
# putoproduit = Putoproduit.create!(:pulve => pulve, :produit => bravoelite, :dosage => 1.4, :saison => saison_2010_2011)
# pulves << pulve
# pulve = Pulve.create!(:name => 'Ariane', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2011-05-04', :star => 0, :desc => '')
# putoproduit = Putoproduit.create!(:pulve => pulve, :produit => ariane, :dosage => 3, :saison => saison_2010_2011)
# pulves << pulve
# 
# labours = Labour.create!([
#  {:name => 'moisson', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2009-01-01',
#  :desc => "", :category => Category.find_by_name('moisson')} ])
# 
# parcelle = saison_2010_2011.parcelles.find_by_name('Pont des champs')
# 
# pulves.each do |pulve|
#   putoparcelle = Putoparcelle.create!(:parcelle => parcelle, :pulve => pulve, :value => 0)
# end
# labours.each do |labour|
#   labtoparcelle = Labtoparcelle.create!(:parcelle => parcelle, :labour => labour, :value => 0)
# end
# 
#  # aeromodelisme - Blé - 14Ha
#  pulves = nil
#  pulves = []
# pulve = Pulve.create!(:name => 'glyphosate', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2010-09-30', :star => 0, :desc => '')
# putoproduit = Putoproduit.create!(:pulve => pulve, :produit => glyphosate, :dosage => 2, :saison => saison_2010_2011)
# putoproduit = Putoproduit.create!(:pulve => pulve, :produit => chardol, :dosage => 0.6, :saison => saison_2010_2011)
# pulves << pulve
# pulve = Pulve.create!(:name => 'semis', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2010-10-20', :star => 0, :desc => 'dosage reel 175kg/Ha.</br>N°42.')
# putoproduit = Putoproduit.create!(:pulve => pulve, :produit => pr, :dosage => 87.5, :saison => saison_2010_2011)
# putoproduit = Putoproduit.create!(:pulve => pulve, :produit => paledor, :dosage => 87.5, :saison => saison_2010_2011)
# pulves << pulve
# pulve = Pulve.create!(:name => 'Super 45', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2011-01-20', :star => 0, :desc => '')
# putoproduit = Putoproduit.create!(:pulve => pulve, :produit => super45, :dosage => 153, :saison => saison_2010_2011)
# pulves << pulve
# pulve = Pulve.create!(:name => 'Azote', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2011-02-08', :star => 0, :desc => '')
# putoproduit = Putoproduit.create!(:pulve => pulve, :produit => azote, :dosage => 200, :saison => saison_2010_2011)
# pulves << pulve
# pulve = Pulve.create!(:name => 'Radar', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2011-02-11', :star => 1, :desc => 'dosage huile?')
# putoproduit = Putoproduit.create!(:pulve => pulve, :produit => radar, :dosage => 275, :saison => saison_2010_2011)
# putoproduit = Putoproduit.create!(:pulve => pulve, :produit => huile, :dosage => 1, :saison => saison_2010_2011)
# pulves << pulve
# pulve = Pulve.create!(:name => 'Azote', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2011-03-03', :star => 0, :desc => '')
# putoproduit = Putoproduit.create!(:pulve => pulve, :produit => azote, :dosage => 237, :saison => saison_2010_2011)
# pulves << pulve
# pulve = Pulve.create!(:name => 'Soufre', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2011-03-09', :star => 0, :desc => '')
# putoproduit = Putoproduit.create!(:pulve => pulve, :produit => azomag, :dosage => 100, :saison => saison_2010_2011)
# pulves << pulve
# pulve = Pulve.create!(:name => 'Proca', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2011-04-04', :star => 1, :desc => 'PZ (?)')
# putoproduit = Putoproduit.create!(:pulve => pulve, :produit => proca, :dosage => 1, :saison => saison_2010_2011)
# pulves << pulve
# pulve = Pulve.create!(:name => 'Vip', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2011-04-21', :star => 1, :desc => 'traxos sur 8,3 Ha</br>(remplace Vip).</br>Vip sur 5.7 Ha')
# putoproduit = Putoproduit.create!(:pulve => pulve, :produit => traxos, :dosage => 0.711, :saison => saison_2010_2011)
# putoproduit = Putoproduit.create!(:pulve => pulve, :produit => vip, :dosage => 0.2036, :saison => saison_2010_2011)
# putoproduit = Putoproduit.create!(:pulve => pulve, :produit => huile, :dosage => 1, :saison => saison_2010_2011)
# pulves << pulve
# pulve = Pulve.create!(:name => 'Bravo Elite', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2011-04-30', :star => 0, :desc => '')
# putoproduit = Putoproduit.create!(:pulve => pulve, :produit => bravo_elite, :dosage => 1.4, :saison => saison_2010_2011)
# pulves << pulve
# 
# labours = Labour.create!([
#  {:name => 'moisson', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2009-01-01',
#  :desc => "", :category => Category.find_by_name('moisson')} ])
# 
# parcelle = saison_2010_2011.parcelles.find_by_name('Aeromodelisme')
# 
# pulves.each do |pulve|
#   putoparcelle = Putoparcelle.create!(:parcelle => parcelle, :pulve => pulve, :value => 0)
# end
# labours.each do |labour|
#   labtoparcelle = Labtoparcelle.create!(:parcelle => parcelle, :labour => labour, :value => 0)
# end
# 
#  # Mitant - Blé - 5 Ha
#  pulves = nil
#  pulves = []
# pulve = Pulve.create!(:name => 'glyphosate', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2010-09-30', :star => 0, :desc => '')
# putoproduit = Putoproduit.create!(:pulve => pulve, :produit => glyphosate, :dosage => 2, :saison => saison_2010_2011)
# putoproduit = Putoproduit.create!(:pulve => pulve, :produit => chardol, :dosage => 0.6, :saison => saison_2010_2011)
# pulves << pulve
# pulve = Pulve.create!(:name => 'semis', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2010-10-21', :star => 0, :desc => 'dosage reel 165kg/Ha.</br>(Voir plan?)')
# putoproduit = Putoproduit.create!(:pulve => pulve, :produit => pr, :dosage => 55, :saison => saison_2010_2011)
# putoproduit = Putoproduit.create!(:pulve => pulve, :produit => paledor, :dosage => 55, :saison => saison_2010_2011)
# putoproduit = Putoproduit.create!(:pulve => pulve, :produit => altigo, :dosage => 55, :saison => saison_2010_2011)
# pulves << pulve
# pulve = Pulve.create!(:name => 'Super 45', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2011-01-20', :star => 0, :desc => '')
# putoproduit = Putoproduit.create!(:pulve => pulve, :produit => super45, :dosage => 153, :saison => saison_2010_2011)
# pulves << pulve
# pulve = Pulve.create!(:name => 'Azote', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2011-02-08', :star => 0, :desc => '')
# putoproduit = Putoproduit.create!(:pulve => pulve, :produit => azote, :dosage => 200, :saison => saison_2010_2011)
# pulves << pulve
# pulve = Pulve.create!(:name => 'Azote', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2011-03-03', :star => 0, :desc => '')
# putoproduit = Putoproduit.create!(:pulve => pulve, :produit => azote, :dosage => 237, :saison => saison_2010_2011)
# pulves << pulve
# pulve = Pulve.create!(:name => 'Soufre', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2011-03-09', :star => 0, :desc => '')
# putoproduit = Putoproduit.create!(:pulve => pulve, :produit => azomag, :dosage => 100, :saison => saison_2010_2011)
# pulves << pulve
# pulve = Pulve.create!(:name => 'Radar', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2011-03-14', :star => 1, :desc => 'dosage huile?')
# putoproduit = Putoproduit.create!(:pulve => pulve, :produit => radar, :dosage => 275, :saison => saison_2010_2011)
# putoproduit = Putoproduit.create!(:pulve => pulve, :produit => huile, :dosage => 1, :saison => saison_2010_2011)
# pulves << pulve
# pulve = Pulve.create!(:name => 'Proca', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2011-04-04', :star => 1, :desc => 'PZ (?)')
# putoproduit = Putoproduit.create!(:pulve => pulve, :produit => proca, :dosage => 1, :saison => saison_2010_2011)
# pulves << pulve
# pulve = Pulve.create!(:name => 'Vip', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2011-04-21', :star => 1, :desc => 'dosage reel : 0,5L/Ha sur 2.5 Ha.')
# putoproduit = Putoproduit.create!(:pulve => pulve, :produit => vip, :dosage => 0.25, :saison => saison_2010_2011)
# putoproduit = Putoproduit.create!(:pulve => pulve, :produit => huile, :dosage => 0.5, :saison => saison_2010_2011)
# pulves << pulve
# pulve = Pulve.create!(:name => 'Bravo Elite', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2011-04-30', :star => 0, :desc => '')
# putoproduit = Putoproduit.create!(:pulve => pulve, :produit => bravo_elite, :dosage => 1.4, :saison => saison_2010_2011)
# pulves << pulve
# 
# labours = Labour.create!([
#  {:name => 'moisson', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2009-01-01',
#  :desc => "", :category => Category.find_by_name('moisson')} ])
# 
# parcelle = saison_2010_2011.parcelles.find_by_name('Mitant')
# 
# pulves.each do |pulve|
#   putoparcelle = Putoparcelle.create!(:parcelle => parcelle, :pulve => pulve, :value => 0)
# end
# labours.each do |labour|
#   labtoparcelle = Labtoparcelle.create!(:parcelle => parcelle, :labour => labour, :value => 0)
# end
# 
#  # Bruneau - Blé - 14 Ha
#  pulves = nil
#  pulves = []
# pulve = Pulve.create!(:name => 'glyphosate', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2010-09-30', :star => 0, :desc => '')
# putoproduit = Putoproduit.create!(:pulve => pulve, :produit => glyphosate, :dosage => 2, :saison => saison_2010_2011)
# putoproduit = Putoproduit.create!(:pulve => pulve, :produit => chardol, :dosage => 0.6, :saison => saison_2010_2011)
# pulves << pulve
# pulve = Pulve.create!(:name => 'semis', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2010-10-21', :star => 0, :desc => 'dosage reel 171kg/Ha.</br>(Richepain au Tour?)</br>N°42')
# putoproduit = Putoproduit.create!(:pulve => pulve, :produit => richepain, :dosage => 85.5, :saison => saison_2010_2011)
# putoproduit = Putoproduit.create!(:pulve => pulve, :produit => paledor, :dosage => 85.5, :saison => saison_2010_2011)
# pulves << pulve
# pulve = Pulve.create!(:name => 'Super 45', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2011-01-20', :star => 0, :desc => '')
# putoproduit = Putoproduit.create!(:pulve => pulve, :produit => super45, :dosage => 153, :saison => saison_2010_2011)
# pulves << pulve
# pulve = Pulve.create!(:name => 'Azote', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2011-02-08', :star => 0, :desc => '')
# putoproduit = Putoproduit.create!(:pulve => pulve, :produit => azote, :dosage => 200, :saison => saison_2010_2011)
# pulves << pulve
# pulve = Pulve.create!(:name => 'Radar', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2011-02-11', :star => 1, :desc => 'dosage huile?')
# putoproduit = Putoproduit.create!(:pulve => pulve, :produit => radar, :dosage => 275, :saison => saison_2010_2011)
# putoproduit = Putoproduit.create!(:pulve => pulve, :produit => huile, :dosage => 1, :saison => saison_2010_2011)
# pulves << pulve
# pulve = Pulve.create!(:name => 'Azote', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2011-03-03', :star => 0, :desc => '')
# putoproduit = Putoproduit.create!(:pulve => pulve, :produit => azote, :dosage => 237, :saison => saison_2010_2011)
# pulves << pulve
# pulve = Pulve.create!(:name => 'Soufre', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2011-03-09', :star => 0, :desc => '')
# putoproduit = Putoproduit.create!(:pulve => pulve, :produit => azomag, :dosage => 100, :saison => saison_2010_2011)
# pulves << pulve
# pulve = Pulve.create!(:name => 'Proca', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2011-04-04', :star => 1, :desc => 'PZ (?)')
# putoproduit = Putoproduit.create!(:pulve => pulve, :produit => proca, :dosage => 1, :saison => saison_2010_2011)
# pulves << pulve
# pulve = Pulve.create!(:name => 'Bravo Elite', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2011-04-30', :star => 0, :desc => '')
# putoproduit = Putoproduit.create!(:pulve => pulve, :produit => bravo_elite, :dosage => 1.4, :saison => saison_2010_2011)
# pulves << pulve
# 
# labours = Labour.create!([
#  {:name => 'moisson', :cout_ha_passage => 10, :user => trochet, :saison => saison_2010_2011, :date => '2009-01-01',
#  :desc => "", :category => Category.find_by_name('moisson')} ])
# 
# parcelle = saison_2010_2011.parcelles.find_by_name('Bruneau')
# 
# pulves.each do |pulve|
#   putoparcelle = Putoparcelle.create!(:parcelle => parcelle, :pulve => pulve, :value => 0)
# end
# labours.each do |labour|
#   labtoparcelle = Labtoparcelle.create!(:parcelle => parcelle, :labour => labour, :value => 0)
# end


