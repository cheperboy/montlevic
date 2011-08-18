# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#

upcategories = Upcategory.create!([{ :name => 'facture'}, 
{ :name => 'pulve' }, 
{ :name => 'labour' },
{ :name => 'vente' }])

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

{ :name => 'fongicide', :upcategory => pulve },
{ :name => 'herbicide', :upcategory => pulve },
{ :name => 'desherbant', :upcategory => pulve },
{ :name => 'insecticide', :upcategory => pulve },
{ :name => 'soufre', :upcategory => pulve },
{ :name => 'azote', :upcategory => pulve },
{ :name => 'engrais', :upcategory => pulve },
{ :name => 'semis', :upcategory => pulve },

{ :name => 'moisson', :upcategory => labour },
{ :name => 'covercrop', :upcategory => labour },
{ :name => 'vibro', :upcategory => labour },

{ :name => 'foin', :upcategory => vente },
{ :name => 'PAC', :upcategory => vente },
{ :name => 'Avoir', :upcategory => vente }
])

factcats = Factcat.create!([
  { :name => 'agri'}, 
  { :name => 'maison' }, 
  { :name => 'invest' }])

saison = Saison.create!(:name => "2010-2011", :year => "2010")
setting = Setting.create!( :saison => saison, :float_precision => 1, :value_parcelle => false, :detail_desc => false, :detail_ref => false)

ble = Typeculture.create!({:name => "Ble"})
bleble = Typeculture.create!({:name => "2eme Ble"})
tournesol = Typeculture.create!({:name => "Tournesol"})
colza = Typeculture.create!({:name => "Colza"})
jachere = Typeculture.create!({:name => "Jachere"})
typeculture = Typeculture.find(:first)

zones = Zone.create!([
  {:name => "Bruneau",          :surface => 14},    #/1/
  {:name => "Mitant",           :surface => 5},     #/2/     
  {:name => "La Rue",           :surface => 46.55}, #/3/
  {:name => "Basse-cour",       :surface => 2},     #/4/
  {:name => "Vallees",          :surface => 11},    #/5/

  {:name => "Guiberons",        :surface => 2.5},   #/6/
  {:name => "la cote",          :surface => 2},     #/7/
  {:name => "Feuillets",        :surface => 16},    #/8/
  {:name => "Brandes",          :surface => 2.97},  #/9/
  {:name => "Taillis",          :surface => 19.32}, #/10/
  {:name => "Varennes",         :surface => 15.86}, #/11/
  {:name => "Patureaux",        :surface => 8.87},  #/12/
  {:name => "Prairie Chevaux",  :surface => 13.26}, #/13/
  {:name => "Sous l'eglise",    :surface => 1.35},  #/14/
 
  {:name => "Reserve",          :surface => 2.55},  #/15/
  {:name => "Lavernier",        :surface => 0.75},  #/16/
  {:name => "Le Bourg-1",       :surface => 0.52}   #/17/
])

#Bons pain + mitant
for zone in Zone.find([1, 2])
  parcelle = Parcelle.create!(:name => zone.name, :saison => saison, :typeculture => ble, :surface => zone.surface)
  zonetopa = Zonetopa.create!(:parcelle => parcelle, :zone => zone, :value => zone.surface)
end

# Feuillets
zone = Zone.find(8)
parcelle = Parcelle.create!(:name => (zone.name + " 1"), :saison => saison, :typeculture => jachere, :surface => 5)
zonetopa = Zonetopa.create!(:parcelle => parcelle, :zone => zone, :value => parcelle.surface)
parcelle = Parcelle.create!(:name => (zone.name + " 2"), :saison => saison, :typeculture => jachere, :surface => 4)
zonetopa = Zonetopa.create!(:parcelle => parcelle, :zone => zone, :value => parcelle.surface)
parcelle = Parcelle.create!(:name => (zone.name + " 3"), :saison => saison, :typeculture => jachere, :surface => 7)
zonetopa = Zonetopa.create!(:parcelle => parcelle, :zone => zone, :value => parcelle.surface)


# Champ de la Rue
zone = Zone.find(3)
parcelle = Parcelle.create!(:name => "Pont des champs", :saison => saison, :typeculture => ble, :surface => 10)
zonetopa = Zonetopa.create!(:parcelle => parcelle, :zone => zone, :value => parcelle.surface)
parcelle = Parcelle.create!(:name => "Aeromodelisme", :saison => saison, :typeculture => ble, :surface => 14)
zonetopa = Zonetopa.create!(:parcelle => parcelle, :zone => zone, :value => parcelle.surface)
parcelle = Parcelle.create!(:name => "Derierre", :saison => saison, :typeculture => colza, :surface => 14)
zonetopa = Zonetopa.create!(:parcelle => parcelle, :zone => zone, :value => parcelle.surface)
parcelle = Parcelle.create!(:name => "Champ du Milieu", :saison => saison, :typeculture => tournesol, :surface => 9)
zonetopa = Zonetopa.create!(:parcelle => parcelle, :zone => zone, :value => parcelle.surface)

# Basse-courre
zone = Zone.find(4)
parcelle = Parcelle.create!(:name => zone.name, :saison => saison, :typeculture => colza, :surface => zone.surface )
zonetopa = Zonetopa.create!(:parcelle => parcelle, :zone => zone, :value => parcelle.surface)

# Vallees
zone = Zone.find(4)
parcelle = Parcelle.create!(:name => zone.name, :saison => saison, :typeculture => tournesol, :surface => zone.surface )
zonetopa = Zonetopa.create!(:parcelle => parcelle, :zone => zone, :value => parcelle.surface)

zonetopa = Zonetopa.find(:first)
parcelle = Parcelle.find(:first)
zone = Zone.find(:first)

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
  {:name => "Bricomarche"},
  {:name => "Aucun"}
])

myuser = Myuser.create!([
{:login => "admin",:password => "admin", :admin => true},
{:login => "matthieu", :admin => false},
{:login => "elisabeth", :admin => false},
{:login => "thierry", :admin => false}
])

#===== TESTING DATA ========

factureA = Debit.create!(:name => 'Debit 1', 
                          :cout => 1000, 
                          :user => User.find(:first),
                          :factype => Factype.find_by_name("diff"),
                          :factcat => Factcat.find_by_name("agri"),
                          :saison => saison,
                          :date => '2011-01-01',
                          :desc => "from seeds",
                          :category => Category.find_by_name('deplacement'))

factureB = Debit.create!(:name => 'Debit 2', 
                          :cout => 1000, 
                          :user => User.find(:first),
                          :factype => Factype.find_by_name("diff"),
                          :factcat => Factcat.find_by_name("maison"),
                          :saison => saison,
                          :date => '2011-01-01',
                          :desc => "from seeds",
                          :category => Category.find_by_name('deplacement'))

labourA = Labour.create!(  :name => 'Labour 1', 
                         :cout_ha_passage => 10, 
                         :user => User.find(:first),
                         :saison => saison,
                         :date => '2011-01-01',
                         :desc => "from seeds",
                         :category => Category.find_by_name('covercrop'))

labourB = Labour.create!(  :name => 'Labour 2', 
                         :cout_ha_passage => 10, 
                         :user => User.find(:first),
                         :saison => saison,
                         :date => '2011-01-01',
                         :desc => "from seeds",
                         :category => Category.find_by_name('covercrop'))

Labtofacture.create!(  :facture_id => factureA.id,
                     :labour_id => labourA.id,
                     :value => 10)
                     
Labtofacture.create!(  :facture_id => factureB.id,
                     :labour_id => labourB.id,
                     :value => 11)

pulveA = Pulve.create!( :name => 'Pulve 1', 
                       :cout_ha_passage => 0,
                       :user => User.find(:first),
                       :saison => saison,
                       :date => '2011-01-01',
                       :desc => "from seeds")

pulveB = Pulve.create!(  :name => 'Pulve 2', 
                       :cout_ha_passage => 0,
                       :user => User.find(:first),
                       :saison => saison,
                       :date => '2011-01-01',
                       :desc => "from seeds")

pulveA = Pulve.create!( :name => 'Fury', 
                      :cout_ha_passage => 0,
                      :user => User.find(:first),
                      :saison => saison,
                      :date => '2011-01-01',
                      :desc => "from seeds")

produitA = Produit.create!(:name => 'Fury', 
                         :unit => 'L',
                         :saison => saison,
                         :desc => "FURY en 5L x5 : 5 x 41.50 = 207.5 => 1.66 e/L",
                         :category => Category.find_by_name('desherbant'))


produitB = Produit.create!(:name => 'AMISTAR', 
                         :unit => 'L',
                         :saison => saison,
                         :desc => "AMISTAR en 5L x25 : 43,90 x 25 = 1097.5",
                         :category => Category.find_by_name('desherbant'))

protofacture = Protofacture.create!( :produit => produitA,
                                   :facture => factureA,
                                   :quantite => 25,
                                   :prix => 207.5)

protofacture = Protofacture.create!( :produit => produitB,
                                   :facture => factureA,
                                   :quantite => 125,
                                   :prix => 1097.5)

putoproduit = Putoproduit.create!( :pulve => pulveA,
                                 :produit => produitA,
                                 :saison => saison,
                                 :dosage => 2)


#===== SEEDS SAISON 2009/2010 ========
trochet = User.find_by_name('Trochet')
saison_2009_2010 = Saison.create!(:name => "2009/2010", :year => "2009")
setting.saison = saison_2009_2010
setting.save!

#Bruneau + Mitant
for zone in Zone.find([1, 2])
  parcelle = Parcelle.create!(:name => zone.name, :saison => saison_2009_2010, :typeculture => colza, :surface => zone.surface)
  zonetopa = Zonetopa.create!(:parcelle => parcelle, :zone => zone, :value => zone.surface)
end

# Champ de la Rue
zone = Zone.find(8)
parcelle = Parcelle.create!(:name => zone.name, :saison => saison_2009_2010, :typeculture => colza, :surface => 12)
zonetopa = Zonetopa.create!(:parcelle => parcelle, :zone => zone, :value => 12)

# Feuillets
zone = Zone.find(8)
parcelle = Parcelle.create!(:name => (zone.name + " 1"), :saison => saison_2009_2010, :typeculture => colza, :surface => 5)
zonetopa = Zonetopa.create!(:parcelle => parcelle, :zone => zone, :value => parcelle.surface)
parcelle = Parcelle.create!(:name => (zone.name + " 2"), :saison => saison_2009_2010, :typeculture => jachere, :surface => 4)
zonetopa = Zonetopa.create!(:parcelle => parcelle, :zone => zone, :value => parcelle.surface)
parcelle = Parcelle.create!(:name => (zone.name + " 3"), :saison => saison_2009_2010, :typeculture => colza, :surface => 7)
zonetopa = Zonetopa.create!(:parcelle => parcelle, :zone => zone, :value => parcelle.surface)

zone = Zone.find(3)
#TODO pont des champ non trouve dans le carnet Trochet
parcelle = Parcelle.create!(:name => "Pont des champs", :saison => saison_2009_2010, :typeculture => ble, :surface => 10)
zonetopa = Zonetopa.create!(:parcelle => parcelle, :zone => zone, :value => parcelle.surface)
parcelle = Parcelle.create!(:name => "Aeromodelisme", :saison => saison_2009_2010, :typeculture => tournesol, :surface => 14)
zonetopa = Zonetopa.create!(:parcelle => parcelle, :zone => zone, :value => parcelle.surface)
parcelle = Parcelle.create!(:name => "Derierre maison", :saison => saison_2009_2010, :typeculture => ble, :surface => 14)
zonetopa = Zonetopa.create!(:parcelle => parcelle, :zone => zone, :value => parcelle.surface)
parcelle = Parcelle.create!(:name => "Champ du Milieu", :saison => saison_2009_2010, :typeculture => ble, :surface => 9)
zonetopa = Zonetopa.create!(:parcelle => parcelle, :zone => zone, :value => parcelle.surface)

# Basse-courre
zone = Zone.find(4)
parcelle = Parcelle.create!(:name => zone.name, :saison => saison_2009_2010, :typeculture => colza, :surface => zone.surface )
zonetopa = Zonetopa.create!(:parcelle => parcelle, :zone => zone, :value => parcelle.surface)

# Vallees
zone = Zone.find(4)
parcelle = Parcelle.create!(:name => zone.name, :saison => saison_2009_2010, :typeculture => tournesol, :surface => zone.surface )
zonetopa = Zonetopa.create!(:parcelle => parcelle, :zone => zone, :value => parcelle.surface)

# TODO seeds 2009-2010 : A VERIFIER !!!
# Guiberons 
zone = Zone.find(6)
parcelle = Parcelle.create!(:name => zone.name, :saison => saison_2009_2010, :typeculture => ble, :surface => zone.surface )
zonetopa = Zonetopa.create!(:parcelle => parcelle, :zone => zone, :value => parcelle.surface)


factureA = Debit.create!(:name => 'Achat Phyto', 
                        :cout => 1305, 
                        :user => User.find(:first),
                        :factype => Factype.find_by_name("diff"),
                        :factcat => Factcat.find_by_name("agri"),
                        :saison => saison_2009_2010,
                        :date => '2011-01-01',
                        :desc => "",
                        :category => Category.find_by_name('deplacement'))

# ----- Produits -----
anistar = Produit.create!(
:name => 'Anistar', :unit => 'L', :saison => saison_2009_2010, :desc => "", :category => Category.find_by_name('fongicide'))

azote = Produit.create!(
:name => 'Azote', :unit => 'L', :saison => saison_2009_2010, :desc => "", :category => Category.find_by_name('azote'))

azomag = Produit.create!(
:name => 'Azomag20', :unit => 'L', :saison => saison_2009_2010, :desc => "", :category => Category.find_by_name('soufre'))
#FIXME Azomag et souffre. est-ce le meme produit?

azomag20 = Produit.create!(
:name => 'Azomag20', :unit => 'L', :saison => saison_2009_2010, :desc => "", :category => Category.find_by_name('soufre'))

campo = Produit.create!(
:name => 'Campo', :unit => 'Kg', :saison => saison_2009_2010, :desc => "", :category => Category.find_by_name('semis'))

celtic = Produit.create!(
:name => 'Celtic', :unit => 'L', :saison => saison_2009_2010, :desc => "", :category => Category.find_by_name('desherbant'))

chrono = Produit.create!(
:name => 'Chrono', :unit => 'L', :saison => saison_2009_2010, :desc => "", :category => Category.find_by_name('desherbant'))

catalino = Produit.create!(
:name => 'Catalino', :unit => 'Kg', :saison => saison_2009_2010, :desc => "", :category => Category.find_by_name('semis'))

colzamid = Produit.create!(
:name => 'Colzamid', :unit => 'L', :saison => saison_2009_2010, :desc => "", :category => Category.find_by_name('desherbant'))

folyr = Produit.create!(
:name => 'Folyr', :unit => 'L', :saison => saison_2009_2010, :desc => "", :category => Category.find_by_name('desherbant'))

fury = Produit.create!(
:name => 'Fury', :unit => 'L', :saison => saison_2009_2010, :desc => "", :category => Category.find_by_name('insecticide'))

glyphosate = Produit.create!(
:name => 'Glyphosate', :unit => 'L', :saison => saison_2009_2010, :desc => "", :category => Category.find_by_name('desherbant'))

harmony = Produit.create!(
:name => 'Harmony', :unit => 'Kg', :saison => saison_2009_2010, :desc => "", :category => Category.find_by_name('desherbant'))

iso = Produit.create!(
:name => 'Iso', :unit => 'L', :saison => saison_2009_2010, :desc => "", :category => Category.find_by_name('desherbant'))

novrel = Produit.create!(
:name => 'Novrel', :unit => 'L', :saison => saison_2009_2010, :desc => "", :category => Category.find_by_name('desherbant'))

proteus = Produit.create!(
:name => 'Proteus', :unit => 'L', :saison => saison_2009_2010, :desc => "", :category => Category.find_by_name('insecticide'))

picosolo = Produit.create!(
:name => 'Picosolo', :unit => 'Kg', :saison => saison_2009_2010, :desc => "", :category => Category.find_by_name('desherbant'))

sunorg = Produit.create!(
:name => 'Sunorg', :unit => 'L', :saison => saison_2009_2010, :desc => "", :category => Category.find_by_name('fongicide'))

storane = Produit.create!(
:name => 'storane', :unit => 'L', :saison => saison_2009_2010, :desc => "", :category => Category.find_by_name('desherbant'))

suplason = Produit.create!(
:name => 'suplason', :unit => 'L', :saison => saison_2009_2010, :desc => "", :category => Category.find_by_name('desherbant'))

prochorage = Produit.create!(
:name => 'Prochorage', :unit => 'L', :saison => saison_2009_2010, :desc => "", :category => Category.find_by_name('fongicide'))

super45 = Produit.create!(
:name => 'Super45', :unit => 'L', :saison => saison_2009_2010, :desc => "", :category => Category.find_by_name('engrais'))

zero2525 = Produit.create!(
:name => '0-25-25', :unit => 'Kg', :saison => saison_2009_2010, :desc => "", :category => Category.find_by_name('engrais'))

# 5 Ha + Bruneau - Pulves
pulves = nil
pulves = []
pulve = Pulve.create!( 
:name => 'Semis', :cout_ha_passage => 0, :user => trochet, :saison => saison_2009_2010, :date => '2009-08-31', :desc => "Campo + Catalino, Catalino selection 2Ha cote haie")
putoproduit = Putoproduit.create!( :pulve => pulve, :produit => campo, :saison => saison_2009_2010, :dosage => 3.5)
putoproduit = Putoproduit.create!( :pulve => pulve, :produit => catalino, :saison => saison_2009_2010, :dosage => 3.5)
pulves << pulve

pulve = Pulve.create!( 
:name => 'Colzamid', :cout_ha_passage => 0, :user => trochet, :saison => saison_2009_2010, :date => '2009-08-31', :desc => "")
putoproduit = Putoproduit.create!( :pulve => pulve, :produit => colzamid, :saison => saison_2009_2010, :dosage => 2.2)
pulves << pulve

pulve = Pulve.create!( 
:name => 'Colzamid', :cout_ha_passage => 0, :user => trochet, :saison => saison_2009_2010, :date => '2009-08-31', :desc => "")
putoproduit = Putoproduit.create!( :pulve => pulve, :produit => colzamid, :saison => saison_2009_2010, :dosage => 2.2)
pulves << pulve

pulve = Pulve.create!( 
:name => 'Novrel', :cout_ha_passage => 0, :user => trochet, :saison => saison_2009_2010, :date => '2009-09-02', :desc => "")
putoproduit = Putoproduit.create!( :pulve => pulve, :produit => novrel, :saison => saison_2009_2010, :dosage => 1.8)
pulves << pulve

pulve = Pulve.create!( 
:name => 'folyr', :cout_ha_passage => 0, :user => trochet, :saison => saison_2009_2010, :date => '2009-09-20', :desc => "")
putoproduit = Putoproduit.create!( :pulve => pulve, :produit => folyr, :saison => saison_2009_2010, :dosage => 0.6)
pulves << pulve

pulve = Pulve.create!( 
:name => 'fury', :cout_ha_passage => 0, :user => trochet, :saison => saison_2009_2010, :date => '2009-09-20', :desc => "date erronee, avec huile 1L", :star => 1)
putoproduit = Putoproduit.create!( :pulve => pulve, :produit => fury, :saison => saison_2009_2010, :dosage => 0.1)
pulves << pulve

pulve = Pulve.create!( 
:name => 'zero2525', :cout_ha_passage => 0, :user => trochet, :saison => saison_2009_2010, :date => '2009-09-20', :desc => "date erronee", :star => 1)
putoproduit = Putoproduit.create!( :pulve => pulve, :produit => zero2525, :saison => saison_2009_2010, :dosage => 200)
pulves << pulve
#FIXME engrais en kg ou en Kg/Ha ?

pulve = Pulve.create!( 
:name => 'Azote', :cout_ha_passage => 0, :user => trochet, :saison => saison_2009_2010, :date => '2010-02-10', :desc => "195Kg = 65u")
putoproduit = Putoproduit.create!( :pulve => pulve, :produit => azote, :saison => saison_2009_2010, :dosage => 195)
pulves << pulve

pulve = Pulve.create!( 
:name => 'Azote 2eme', :cout_ha_passage => 0, :user => trochet, :saison => saison_2009_2010, :date => '2010-03-09', :desc => "230Kg = 77u")
putoproduit = Putoproduit.create!( :pulve => pulve, :produit => azote, :saison => saison_2009_2010, :dosage => 230)
pulves << pulve

pulve = Pulve.create!( 
:name => 'Azomag', :cout_ha_passage => 0, :user => trochet, :saison => saison_2009_2010, :date => '2010-03-12', :desc => "150Kg = 30u")
putoproduit = Putoproduit.create!( :pulve => pulve, :produit => azomag, :saison => saison_2009_2010, :dosage => 150)
pulves << pulve

pulve = Pulve.create!( 
:name => 'Fury', :cout_ha_passage => 0, :user => trochet, :saison => saison_2009_2010, :date => '2010-03-19', :desc => "")
putoproduit = Putoproduit.create!( :pulve => pulve, :produit => fury, :saison => saison_2009_2010, :dosage => 0.1)
pulves << pulve

pulve = Pulve.create!( 
:name => 'proteus', :cout_ha_passage => 0, :user => trochet, :saison => saison_2009_2010, :date => '2010-04-06', :desc => "")
putoproduit = Putoproduit.create!( :pulve => pulve, :produit => proteus, :saison => saison_2009_2010, :dosage => 0.5)
pulves << pulve

pulve = Pulve.create!( 
:name => 'sunorg', :cout_ha_passage => 0, :user => trochet, :saison => saison_2009_2010, :date => '2010-04-18', :desc => "")
putoproduit = Putoproduit.create!( :pulve => pulve, :produit => sunorg, :saison => saison_2009_2010, :dosage => 0.6)
pulves << pulve

pulve = Pulve.create!( 
:name => 'anistar', :cout_ha_passage => 0, :user => trochet, :saison => saison_2009_2010, :date => '2010-05-07', :desc => "")
putoproduit = Putoproduit.create!( :pulve => pulve, :produit => anistar, :saison => saison_2009_2010, :dosage => 0.75)
pulves << pulve

# 5 Ha + Bruneau - Labours
labours = Labour.create!([
 {:name => 'moisson', :cout_ha_passage => 10, :user => User.find_by_name('Trochet'), :saison => saison_2009_2010, :date => '2009-07-24',
 :desc => "", :category => Category.find_by_name('moisson')} ])

parcelle_1 = saison_2009_2010.parcelles.find_by_name('Mitant')
parcelle_2 = saison_2009_2010.parcelles.find_by_name('Bruneau')

pulves.each do |pulve|
  putoparcelle = Putoparcelle.create!(:parcelle => parcelle_1, :pulve => pulve, :value => 0)
  putoparcelle = Putoparcelle.create!(:parcelle => parcelle_2, :pulve => pulve, :value => 0)
end
labours.each do |labour|
  labtoparcelle = Labtoparcelle.create!(:parcelle => parcelle_1, :labour => labour, :value => 0)
  labtoparcelle = Labtoparcelle.create!(:parcelle => parcelle_2, :labour => labour, :value => 0)
end


# 12 Ha Les Feuillets - Labours
 labours = Labour.create!([
   {:name => 'moisson', :cout_ha_passage => 10, :user => User.find_by_name('Trochet'), :saison => saison_2009_2010, :date => '2009-07-25',
   :desc => "", :category => Category.find_by_name('moisson')} ])

 # 12 Ha Les Feuillets - Pulves
 pulves = nil
 pulves = []
 pulve = Pulve.create!( 
 :name => 'Glyphosate', :cout_ha_passage => 0, :user => trochet, :saison => saison_2009_2010, :date => '2009-13-08', :desc => "+ 0,5 L huile")
 putoproduit = Putoproduit.create!( :pulve => pulve, :produit => glyphosate, :saison => saison_2009_2010, :dosage => 3)
 pulves << pulve

 pulve = Pulve.create!( 
 :name => 'Semis', :cout_ha_passage => 0, :user => trochet, :saison => saison_2009_2010, :date => '2009-09-05', :desc => "verifier dosage semis.', :star => 1")
 putoproduit = Putoproduit.create!( :pulve => pulve, :produit => campo, :saison => saison_2009_2010, :dosage => 3)
 pulves << pulve

 pulve = Pulve.create!( 
 :name => 'Chrono', :cout_ha_passage => 0, :user => trochet, :saison => saison_2009_2010, :date => '2009-09-29', :desc => "")
 putoproduit = Putoproduit.create!( :pulve => pulve, :produit => chrono, :saison => saison_2009_2010, :dosage => 1.04)
 pulves << pulve

 pulve = Pulve.create!( 
 :name => 'folyr', :cout_ha_passage => 0, :user => trochet, :saison => saison_2009_2010, :date => '2009-11-20', :desc => " + huile 1L")
 putoproduit = Putoproduit.create!( :pulve => pulve, :produit => folyr, :saison => saison_2009_2010, :dosage => 0.6)
 pulves << pulve

 pulve = Pulve.create!( 
 :name => 'fury', :cout_ha_passage => 0, :user => trochet, :saison => saison_2009_2010, :date => '2009-11-22', :desc => "")
 putoproduit = Putoproduit.create!( :pulve => pulve, :produit => fury, :saison => saison_2009_2010, :dosage => 0.1)
 pulves << pulve

 pulve = Pulve.create!( 
 :name => '0-25-25', :cout_ha_passage => 0, :user => trochet, :saison => saison_2009_2010, :date => '2010-02-04', :desc => "")
 putoproduit = Putoproduit.create!( :pulve => pulve, :produit => zero2525, :saison => saison_2009_2010, :dosage => 200)
 pulves << pulve
 #FIXME engrais en kg ou en Kg/Ha ?

 pulve = Pulve.create!( 
 :name => 'Azote', :cout_ha_passage => 0, :user => trochet, :saison => saison_2009_2010, :date => '2010-02-10', :desc => "75u")
 putoproduit = Putoproduit.create!( :pulve => pulve, :produit => azote, :saison => saison_2009_2010, :dosage => 255)
 pulves << pulve

 pulve = Pulve.create!( 
 :name => 'Azomag20', :cout_ha_passage => 0, :user => trochet, :saison => saison_2009_2010, :date => '2010-03-12', :desc => "150Kg = 30u")
 putoproduit = Putoproduit.create!( :pulve => pulve, :produit => azomag20, :saison => saison_2009_2010, :dosage => 150)
 pulves << pulve

 pulve = Pulve.create!( 
 :name => 'fury', :cout_ha_passage => 0, :user => trochet, :saison => saison_2009_2010, :date => '2010-03-19', :desc => "")
 putoproduit = Putoproduit.create!( :pulve => pulve, :produit => fury, :saison => saison_2009_2010, :dosage => 0.1)
 pulves << pulve

 pulve = Pulve.create!( 
 :name => 'proteus', :cout_ha_passage => 0, :user => trochet, :saison => saison_2009_2010, :date => '2010-04-06', :desc => "")
 putoproduit = Putoproduit.create!( :pulve => pulve, :produit => proteus, :saison => saison_2009_2010, :dosage => 0.5)
 pulves << pulve

 pulve = Pulve.create!( 
 :name => 'sunorg', :cout_ha_passage => 0, :user => trochet, :saison => saison_2009_2010, :date => '2010-04-18', :desc => "")
 putoproduit = Putoproduit.create!( :pulve => pulve, :produit => sunorg, :saison => saison_2009_2010, :dosage => 0.6)
 pulves << pulve

 pulve = Pulve.create!( 
 :name => 'anistar', :cout_ha_passage => 0, :user => trochet, :saison => saison_2009_2010, :date => '2010-05-07', :desc => "")
 putoproduit = Putoproduit.create!( :pulve => pulve, :produit => anistar, :saison => saison_2009_2010, :dosage => 0.75)
 pulves << pulve

if nil
 # pulves = Pulve.create!([
 #   {:name => 'Glyphosate', :category => Category.find_by_name('desherbant'), :dosage => 3, :unit => 'L/Ha', :date => '2009-08-13', :prix_littre => 0, 
 #   :cout_ha_passage => 0, :cout_fixe => 0, :user => User.find_by_name('Trochet'), :saison => saison_2009_2010, :desc => 'L/Ha, + 0,5 L huile'},
 # 
 #   {:name => 'Campo', :category => Category.find_by_name('semis'), :dosage => 3.5, :unit => 'L/Ha', :date => '2009-09-05', :prix_littre => 0, 
 #   :cout_ha_passage => 0, :cout_fixe => 0, :user => User.find_by_name('Trochet'), :saison => saison_2009_2010, :desc => 'Kg/Ha, verifier dosage semis.', :star => 1},
 # 
 #   {:name => 'Chrono', :category => Category.find_by_name('desherbant'), :dosage => 1.04, :unit => 'L/Ha', :date => '2009-09-29', :prix_littre => 0, 
 #   :cout_ha_passage => 0, :cout_fixe => 0, :user => User.find_by_name('Trochet'), :saison => saison_2009_2010, :desc => 'Kg/Ha'},
 # 
 #   {:name => 'Folyr + huile', :category => Category.find_by_name('desherbant'), :dosage => 0.6, :unit => 'L/Ha', :date => '2009-11-20', :prix_littre => 0, 
 #   :cout_ha_passage => 0, :cout_fixe => 0, :user => User.find_by_name('Trochet'), :saison => saison_2009_2010, :desc => 'Kg/Ha, + huile 1L'},
 # 
 #   {:name => 'Fury', :category => Category.find_by_name('insecticide'), :dosage => 0.1, :unit => 'L/Ha', :date => '2009-11-22', :prix_littre => 0, 
 #   :cout_ha_passage => 0, :cout_fixe => 0, :user => User.find_by_name('Trochet'), :saison => saison_2009_2010, :desc => 'L/Ha'},
 # 
 #   {:name => '0-25-25', :category => Category.find_by_name('engrais'), :dosage => 200, :unit => 'L/Ha', :date => '2010-02-04', :prix_littre => 0, 
 #   :cout_ha_passage => 0, :cout_fixe => 0, :user => User.find_by_name('Trochet'), :saison => saison_2009_2010, :desc => 'Kg'},
 # 
 #   {:name => 'azote', :category => Category.find_by_name('azote'), :dosage => 225, :unit => 'L/Ha', :date => '2010-02-10', :prix_littre => 0, 
 #   :cout_ha_passage => 0, :cout_fixe => 0, :user => User.find_by_name('Trochet'), :saison => saison_2009_2010, :desc => 'Kg, 75u'},
 # 
 #   {:name => 'azomag 20', :category => Category.find_by_name('soufre'), :dosage => 150, :unit => 'L/Ha', :date => '2010-03-12', :prix_littre => 0, 
 #   :cout_ha_passage => 0, :cout_fixe => 0, :user => User.find_by_name('Trochet'), :saison => saison_2009_2010, :desc => 'Kg, 30u'},
 # 
 #   {:name => 'fury', :category => Category.find_by_name('insecticide'), :dosage => 0.1, :unit => 'L/Ha', :date => '2010-03-19', :prix_littre => 0, 
 #   :cout_ha_passage => 0, :cout_fixe => 0, :user => User.find_by_name('Trochet'), :saison => saison_2009_2010, :desc => 'L/Ha'},
 # 
 #   {:name => 'proteus', :category => Category.find_by_name('insecticide'), :dosage => 0.5, :unit => 'L/Ha', :date => '2010-04-06', :prix_littre => 0, 
 #   :cout_ha_passage => 0, :cout_fixe => 0, :user => User.find_by_name('Trochet'), :saison => saison_2009_2010, :desc => 'L/Ha'},
 # 
 #   {:name => 'surnog', :category => Category.find_by_name('fongicide'), :dosage => 0.6, :unit => 'L/Ha', :date => '2010-04-18', :prix_littre => 0, 
 #   :cout_ha_passage => 0, :cout_fixe => 0, :user => User.find_by_name('Trochet'), :saison => saison_2009_2010, :desc => 'L/Ha'},
 # 
 #   {:name => 'amistar', :category => Category.find_by_name('fongicide'), :dosage => 0.75, :unit => 'L/Ha', :date => '2010-05-07', :prix_littre => 0, 
 #   :cout_ha_passage => 0, :cout_fixe => 0, :user => User.find_by_name('Trochet'), :saison => saison_2009_2010, :desc => 'L/Ha'}
 #    ])
end

 parcelle_1 = saison_2009_2010.parcelles.find_by_name('Feuillets 1')
 parcelle_2 = saison_2009_2010.parcelles.find_by_name('Feuillets 3')

 pulves.each do |pulve|
   putoparcelle = Putoparcelle.create!(:parcelle => parcelle_1, :pulve => pulve, :value => 0)
   putoparcelle = Putoparcelle.create!(:parcelle => parcelle_2, :pulve => pulve, :value => 0)
 end
 labours.each do |labour|
   labtoparcelle = Labtoparcelle.create!(:parcelle => parcelle_1, :labour => labour, :value => 0)
   labtoparcelle = Labtoparcelle.create!(:parcelle => parcelle_2, :labour => labour, :value => 0)
 end

 # 14 Ha + 9Ha Cote luzerne - Labours
 labours = Labour.create!([
   {:name => 'moisson', :cout_ha_passage => 10, :user => User.find_by_name('Trochet'), :saison => saison_2009_2010, :date => '2009-07-25',
   :desc => "", :category => Category.find_by_name('moisson')} ])

 # 14 Ha + 9Ha Cote luzerne - Pulves
 pulves = nil
 pulves = []
 pulve = Pulve.create!( 
 :name => 'Semis', :cout_ha_passage => 0, :user => trochet, :saison => saison_2009_2010, :date => '2009-10-19', :desc => "PR + Richepain + Frelon + selection Paledor + Richepain n41")
 putoproduit = Putoproduit.create!( :pulve => pulve, :produit => campo, :saison => saison_2009_2010, :dosage => 3)
 pulves << pulve

 pulve = Pulve.create!( 
 :name => 'desherb colza', :cout_ha_passage => 0, :user => trochet, :saison => saison_2009_2010, :date => '2009-11-19', :desc => "TODO: diminuer le dosage car surface moindre. Iso 2L/Ha. Sur tournesol + tour de champs", :star => 1)
 putoproduit = Putoproduit.create!( :pulve => pulve, :produit => celtic, :saison => saison_2009_2010, :dosage => 2)
 putoproduit = Putoproduit.create!( :pulve => pulve, :produit => iso, :saison => saison_2009_2010, :dosage => 2)
 pulves << pulve

 pulve = Pulve.create!( 
 :name => '', :cout_ha_passage => 0, :user => trochet, :saison => saison_2009_2010, :date => '2009-11-19', :desc => "7 Ha sur colza. TODO: diminuer le dosage car surface moindre. Picosolo, 80g/Ha, Harmony, 25g/Ha", :star => 1)
 putoproduit = Putoproduit.create!( :pulve => pulve, :produit => picosolo, :saison => saison_2009_2010, :dosage => 80)
 putoproduit = Putoproduit.create!( :pulve => pulve, :produit => harmony, :saison => saison_2009_2010, :dosage => 25)
 pulves << pulve

 pulve = Pulve.create!( 
 :name => 'Super 45', :cout_ha_passage => 0, :user => trochet, :saison => saison_2009_2010, :date => '2010-02-04', :desc => "")
 putoproduit = Putoproduit.create!( :pulve => pulve, :produit => super45, :saison => saison_2009_2010, :dosage => 157)
 pulves << pulve

 pulve = Pulve.create!( 
 :name => 'Azote 1', :cout_ha_passage => 0, :user => trochet, :saison => saison_2009_2010, :date => '2010-02-11', :desc => "190 Kg, 64u")
 putoproduit = Putoproduit.create!( :pulve => pulve, :produit => azote, :saison => saison_2009_2010, :dosage => 195)
 pulves << pulve

 pulve = Pulve.create!( 
 :name => 'Azote 2', :cout_ha_passage => 0, :user => trochet, :saison => saison_2009_2010, :date => '2010-03-09', :desc => "183 Kg, 61u")
 putoproduit = Putoproduit.create!( :pulve => pulve, :produit => azote, :saison => saison_2009_2010, :dosage => 183)
 pulves << pulve

 pulve = Pulve.create!( 
 :name => 'Celio', :cout_ha_passage => 0, :user => trochet, :saison => saison_2009_2010, :date => '2010-03-23', :desc => "0.5L + Huile 0.1L. sur 6.72 ha cote luzerne")
 putoproduit = Putoproduit.create!( :pulve => pulve, :produit => celio, :saison => saison_2009_2010, :dosage => 0.5)
 pulves << pulve

 pulve = Pulve.create!( 
 :name => 'Procharge', :cout_ha_passage => 0, :user => trochet, :saison => saison_2009_2010, :date => '2010-04-06', :desc => "")
 putoproduit = Putoproduit.create!( :pulve => pulve, :produit => procharge, :saison => saison_2009_2010, :dosage => 1)
 pulves << pulve

 pulve = Pulve.create!( 
 :name => 'suplason', :cout_ha_passage => 0, :user => trochet, :saison => saison_2009_2010, :date => '2010-04-18', :desc => "TODO: ajuster les dosage a la surface. 16 ha derriere maison")
 putoproduit = Putoproduit.create!( :pulve => pulve, :produit => suplason, :saison => saison_2009_2010, :dosage => 1)
 putoproduit = Putoproduit.create!( :pulve => pulve, :produit => storane, :saison => saison_2009_2010, :dosage => 0.9)
 pulves << pulve

 pulve = Pulve.create!( 
 :name => 'Azote 3', :cout_ha_passage => 0, :user => trochet, :saison => saison_2009_2010, :date => '2010-05-17', :desc => "120Kg, 40u")
 putoproduit = Putoproduit.create!( :pulve => pulve, :produit => azote, :saison => saison_2009_2010, :dosage => 120)
 pulves << pulve

 pulve = Pulve.create!( 
 :name => 'comet Player', :cout_ha_passage => 0, :user => trochet, :saison => saison_2009_2010, :date => '2010-05-28', :desc => "1 pack = 6 Ha")
 putoproduit = Putoproduit.create!( :pulve => pulve, :produit => comet_player, :saison => saison_2009_2010, :dosage => 120)
 pulves << pulve


if nil
 # pulves = Pulve.create!([
 #   {:name => 'semis', :category => Category.find_by_name('semis'), :dosage => 170, :unit => 'L/Ha', :date => '2009-10-19', :prix_littre => 0, 
 #   :cout_ha_passage => 0, :cout_fixe => 0, :user => User.find_by_name('Trochet'), :saison => saison_2009_2010, :desc => 'Kg, PR + Richepain + Frelon + selection Paledor + Richepain n41'},
 # 
 #   {:name => 'Celtic', :category => Category.find_by_name('desherbant'), :dosage => 2, :unit => 'L/Ha', :date => '2009-11-19', :prix_littre => 0, 
 #   :cout_ha_passage => 0, :cout_fixe => 0, :user => User.find_by_name('Trochet'), :saison => saison_2009_2010, :desc => 'L/Ha, + Iso 2L/Ha. Sur tournesol + tour de champs'},
 # 
 #   {:name => 'Harmony', :category => Category.find_by_name('desherbant'), :dosage => 25, :unit => 'L/Ha', :date => '2009-11-19', :prix_littre => 0, 
 #   :cout_ha_passage => 0, :cout_fixe => 0, :user => User.find_by_name('Trochet'), :saison => saison_2009_2010, :desc => 'g, + Picosolo, 80g/Ha. sur Colza'},
 # 
 #   {:name => 'super 45', :category => Category.find_by_name('engrais'), :dosage => 157, :unit => 'L/Ha', :date => '2010-02-04', :prix_littre => 0, 
 #   :cout_ha_passage => 0, :cout_fixe => 0, :user => User.find_by_name('Trochet'), :saison => saison_2009_2010, :desc => 'Kg'},
 # 
 #   {:name => 'azote', :category => Category.find_by_name('azote'), :dosage => 190, :unit => 'L/Ha', :date => '2010-02-11', :prix_littre => 0, 
 #   :cout_ha_passage => 0, :cout_fixe => 0, :user => User.find_by_name('Trochet'), :saison => saison_2009_2010, :desc => '190 Kg, 64u'},
 # 
 #   {:name => 'azote', :category => Category.find_by_name('azote'), :dosage => 183, :unit => 'L/Ha', :date => '2010-03-09', :prix_littre => 0, 
 #   :cout_ha_passage => 0, :cout_fixe => 0, :user => User.find_by_name('Trochet'), :saison => saison_2009_2010, :desc => '183 Kg, 61u'},
 # 
 #   {:name => 'Celio', :category => Category.find_by_name('desherbant'), :dosage => 0.5, :unit => 'L/Ha', :date => '2010-03-23', :prix_littre => 0, 
 #   :cout_ha_passage => 0, :cout_fixe => 0, :user => User.find_by_name('Trochet'), :saison => saison_2009_2010, :desc => '0.5L + Huile 0.1L. sur 6.72 ha cote luzerne'},
 # 
 #   {:name => 'Prochorage', :category => Category.find_by_name('fongicide'), :dosage => 1, :unit => 'L/Ha', :date => '2010-04-06', :prix_littre => 0, 
 #   :cout_ha_passage => 0, :cout_fixe => 0, :user => User.find_by_name('Trochet'), :saison => saison_2009_2010, :desc => ''},
 # 
 #   {:name => 'suplason', :category => Category.find_by_name('desherbant'), :dosage => 1, :unit => 'L/Ha', :date => '2010-04-18', :prix_littre => 0, 
 #   :cout_ha_passage => 0, :cout_fixe => 0, :user => User.find_by_name('Trochet'), :saison => saison_2009_2010, :desc => '+ Storane 0.9L16 ha derriere maison'},
 # 
 #   {:name => 'azote', :category => Category.find_by_name('azote'), :dosage => 120, :unit => 'L/Ha', :date => '2010-05-17', :prix_littre => 0, 
 #   :cout_ha_passage => 0, :cout_fixe => 0, :user => User.find_by_name('Trochet'), :saison => saison_2009_2010, :desc => '120Kg, 40u'},
 # 
 #   {:name => 'comet Player', :category => Category.find_by_name('fongicide'), :dosage => 120, :unit => 'L/Ha', :date => '2010-05-28', :prix_littre => 0, 
 #   :cout_ha_passage => 0, :cout_fixe => 0, :user => User.find_by_name('Trochet'), :saison => saison_2009_2010, :desc => '1 pack = 6 Ha'}
 # 
 #    ])
end

 parcelle_1 = saison_2009_2010.parcelles.find_by_name('Derierre maison')
 parcelle_2 = saison_2009_2010.parcelles.find_by_name('Champ du Milieu')

 pulves.each do |pulve|
   putoparcelle = Putoparcelle.create!(:parcelle => parcelle_1, :pulve => pulve, :value => 0)
   putoparcelle = Putoparcelle.create!(:parcelle => parcelle_2, :pulve => pulve, :value => 0)
 end
 labours.each do |labour|
   labtoparcelle = Labtoparcelle.create!(:parcelle => parcelle_1, :labour => labour, :value => 0)
   labtoparcelle = Labtoparcelle.create!(:parcelle => parcelle_2, :labour => labour, :value => 0)
 end


 # pulves.each do |pulve|
 #   putoparcelle = Putoparcelle.create!(:parcelle => parcelle, :pulve => pulve, :value => 0)
 # end
 labours.each do |labour|
   labtoparcelle = Labtoparcelle.create!(:parcelle => parcelle, :labour => labour, :value => 0)
 end

 # 2.5 Ha Les Guiberons ble/ble- Labours
 labours = Labour.create!([
   {:name => 'moisson', :cout_ha_passage => 10, :user => User.find_by_name('Trochet'), :saison => saison_2009_2010, :date => '2009-07-25',
   :desc => "", :category => Category.find_by_name('moisson')} ])

 # 2.5 Ha Les Guiberons ble/ble- Pulves
 # pulves = Pulve.create!([
 #   {:name => 'Autan', :category => Category.find_by_name('semis'), :dosage => 180, :unit => 'L/Ha', :date => '2009-10-20', :prix_littre => 0, 
 #   :cout_ha_passage => 0, :cout_fixe => 0, :user => User.find_by_name('Trochet'), :saison => saison_2009_2010, :desc => 'Kg, Autan'},
 # 
 #   {:name => 'super 45', :category => Category.find_by_name('engrais'), :dosage => 157, :unit => 'L/Ha', :date => '2010-02-04', :prix_littre => 0, 
 #   :cout_ha_passage => 0, :cout_fixe => 0, :user => User.find_by_name('Trochet'), :saison => saison_2009_2010, :desc => 'Kg'},
 # 
 #   {:name => 'azote', :category => Category.find_by_name('azote'), :dosage => 210, :unit => 'L/Ha', :date => '2010-02-15', :prix_littre => 0, 
 #   :cout_ha_passage => 0, :cout_fixe => 0, :user => User.find_by_name('Trochet'), :saison => saison_2009_2010, :desc => '210Kg, 70u'},
 # 
 #   {:name => 'azote', :category => Category.find_by_name('azote'), :dosage => 200, :unit => 'L/Ha', :date => '2010-03-09', :prix_littre => 0, 
 #   :cout_ha_passage => 0, :cout_fixe => 0, :user => User.find_by_name('Trochet'), :saison => saison_2009_2010, :desc => '200Kg, 67u'},
 # 
 #   {:name => 'Droid', :category => Category.find_by_name('desherbant'), :dosage => 0.275, :unit => 'L/Ha', :date => '2009-03-23', :prix_littre => 0, 
 #   :cout_ha_passage => 0, :cout_fixe => 0, :user => User.find_by_name('Trochet'), :saison => saison_2009_2010, :desc => 'L/Ha, + huile 0.1L. tour de champs'},
 # 
 #   {:name => 'Prochloraze', :category => Category.find_by_name('fongicide'), :dosage => 1, :unit => 'L/Ha', :date => '2009-04-06', :prix_littre => 0, 
 #   :cout_ha_passage => 0, :cout_fixe => 0, :user => User.find_by_name('Trochet'), :saison => saison_2009_2010, :desc => 'L'},   
 #   
 #   {:name => 'Duplason', :category => Category.find_by_name('desherbant'), :dosage => 1, :unit => 'L/Ha', :date => '2009-04-12', :prix_littre => 0, 
 #   :cout_ha_passage => 0, :cout_fixe => 0, :user => User.find_by_name('Trochet'), :saison => saison_2009_2010, :desc => 'L. + Storane 0.9L'},
 #   
 #   {:name => 'Bravo Elite', :category => Category.find_by_name('fongicide'), :dosage => 1.4, :unit => 'L/Ha', :date => '2009-05-07', :prix_littre => 0, 
 #   :cout_ha_passage => 0, :cout_fixe => 0, :user => User.find_by_name('Trochet'), :saison => saison_2009_2010, :desc => 'L. + Storane 0.9L'}
 #   
 #    ])
 
parcelle = saison_2009_2010.parcelles.find_by_name('Guiberons')
parcelle.typeculture = Typeculture.find_by_name('Ble')
parcelle.save!

 # pulves.each do |pulve|
 #   putoparcelle = Putoparcelle.create!(:parcelle => parcelle, :pulve => pulve, :value => 0)
 # end
 labours.each do |labour|
   labtoparcelle = Labtoparcelle.create!(:parcelle => parcelle, :labour => labour, :value => 0)
 end

 # 13 Ha - Les Vallees - Ble - Labours
 labours = Labour.create!([
   {:name => 'moisson', :cout_ha_passage => 10, :user => User.find_by_name('Trochet'), :saison => saison_2009_2010, :date => '2009-07-25',
   :desc => "", :category => Category.find_by_name('moisson')} ])

 # 13 Ha - Les Vallees - Ble - Pulves
 # pulves = Pulve.create!([
 #   {:name => 'Frelon', :category => Category.find_by_name('semis'), :dosage => 170, :unit => 'L/Ha', :date => '2009-10-20', :prix_littre => 0, 
 #   :cout_ha_passage => 0, :cout_fixe => 0, :user => User.find_by_name('Trochet'), :saison => saison_2009_2010, :desc => 'Kg, + 2Ha Autan'},
 # 
 #   {:name => 'Celtic', :category => Category.find_by_name('desherbant'), :dosage => 2, :unit => 'L/Ha', :date => '2009-10-19', :prix_littre => 0, 
 #   :cout_ha_passage => 0, :cout_fixe => 0, :user => User.find_by_name('Trochet'), :saison => saison_2009_2010, :desc => 'L/Ha, + Iso 2L. sur 3Ha'},
 # 
 #   {:name => 'Harmony', :category => Category.find_by_name('desherbant'), :dosage => 25, :unit => 'L/Ha', :date => '2009-10-19', :prix_littre => 0, 
 #   :cout_ha_passage => 0, :cout_fixe => 0, :user => User.find_by_name('Trochet'), :saison => saison_2009_2010, :desc => 'g, + Picosolo 80g. sur 17Ha'},
 # 
 #   {:name => 'super 45', :category => Category.find_by_name('engrais'), :dosage => 157, :unit => 'L/Ha', :date => '2010-02-04', :prix_littre => 0, 
 #   :cout_ha_passage => 0, :cout_fixe => 0, :user => User.find_by_name('Trochet'), :saison => saison_2009_2010, :desc => 'Kg'},
 # 
 #   {:name => 'azote', :category => Category.find_by_name('azote'), :dosage => 210, :unit => 'L/Ha', :date => '2010-02-16', :prix_littre => 0, 
 #   :cout_ha_passage => 0, :cout_fixe => 0, :user => User.find_by_name('Trochet'), :saison => saison_2009_2010, :desc => '210Kg, 70u'},
 # 
 #   {:name => 'azote', :category => Category.find_by_name('azote'), :dosage => 206, :unit => 'L/Ha', :date => '2010-03-09', :prix_littre => 0, 
 #   :cout_ha_passage => 0, :cout_fixe => 0, :user => User.find_by_name('Trochet'), :saison => saison_2009_2010, :desc => '200Kg, 69u'},
 # 
 #   {:name => 'Droid', :category => Category.find_by_name('desherbant'), :dosage => 0.275, :unit => 'L/Ha', :date => '2009-03-23', :prix_littre => 0, 
 #   :cout_ha_passage => 0, :cout_fixe => 0, :user => User.find_by_name('Trochet'), :saison => saison_2009_2010, :desc => 'L/Ha, + huile 0.1L. sur 3 Ha'},
 # 
 #   {:name => 'Celio', :category => Category.find_by_name('fongicide'), :dosage => 0.5, :unit => 'L/Ha', :date => '2009-03-23', :prix_littre => 0, 
 #   :cout_ha_passage => 0, :cout_fixe => 0, :user => User.find_by_name('Trochet'), :saison => saison_2009_2010, :desc => 'Lsur 4 Ha. + huile 0.1L'},   
 #   
 #   {:name => 'Prochloraze', :category => Category.find_by_name('fongicide'), :dosage => 1, :unit => 'L/Ha', :date => '2009-04-06', :prix_littre => 0, 
 #   :cout_ha_passage => 0, :cout_fixe => 0, :user => User.find_by_name('Trochet'), :saison => saison_2009_2010, :desc => 'L'},   
 #   
 #   {:name => 'Bravo Elite', :category => Category.find_by_name('fongicide'), :dosage => 1.4, :unit => 'L/Ha', :date => '2009-05-07', :prix_littre => 0, 
 #   :cout_ha_passage => 0, :cout_fixe => 0, :user => User.find_by_name('Trochet'), :saison => saison_2009_2010, :desc => 'L'},
 #   
 #   {:name => 'azote', :category => Category.find_by_name('azote'), :dosage => 120, :unit => 'L/Ha', :date => '2009-05-17', :prix_littre => 0, 
 #   :cout_ha_passage => 0, :cout_fixe => 0, :user => User.find_by_name('Trochet'), :saison => saison_2009_2010, :desc => '120Kg, 40u'},
 #   
 #   {:name => 'cornet player', :category => Category.find_by_name('fongicide'), :dosage => 120, :unit => 'L/Ha', :date => '2009-05-22', :prix_littre => 0, 
 #   :cout_ha_passage => 0, :cout_fixe => 0, :user => User.find_by_name('Trochet'), :saison => saison_2009_2010, :desc => '1 pack 6Ha'}
 #   
 #   
 #     ])

 parcelle = saison_2009_2010.parcelles.find_by_name('Vallees')
 parcelle.typeculture = Typeculture.find_by_name('Ble')
 parcelle.save!

 # pulves.each do |pulve|
 #   putoparcelle = Putoparcelle.create!(:parcelle => parcelle, :pulve => pulve, :value => 0)
 # end
 labours.each do |labour|
   labtoparcelle = Labtoparcelle.create!(:parcelle => parcelle, :labour => labour, :value => 0)
 end

 # 2 Ha Basse-courre - Labours
 labours = Labour.create!([
   {:name => 'moisson', :cout_ha_passage => 10, :user => User.find_by_name('Trochet'), :saison => saison_2009_2010, :date => '2009-07-25',
   :desc => "", :category => Category.find_by_name('moisson')} ])

 # 2 Ha Basse-courre - Pulves
 # pulves = Pulve.create!([
 #   {:name => 'Autan', :category => Category.find_by_name('semis'), :dosage => 170, :unit => 'L/Ha', :date => '2009-11-19', :prix_littre => 0, 
 #   :cout_ha_passage => 0, :cout_fixe => 0, :user => User.find_by_name('Trochet'), :saison => saison_2009_2010, :desc => 'Kg'},
 # 
 #   {:name => 'Celtic + Iso', :category => Category.find_by_name('desherbant'), :dosage => 2, :unit => 'L/Ha', :date => '2009-11-19', :prix_littre => 0, 
 #   :cout_ha_passage => 0, :cout_fixe => 0, :user => User.find_by_name('Trochet'), :saison => saison_2009_2010, :desc => 'L/Ha,Celtic 2L/Ha + Iso 2L/Ha'},
 # 
 #   {:name => 'super 45', :category => Category.find_by_name('engrais'), :dosage => 157, :unit => 'L/Ha', :date => '2010-02-04', :prix_littre => 0, 
 #   :cout_ha_passage => 0, :cout_fixe => 0, :user => User.find_by_name('Trochet'), :saison => saison_2009_2010, :desc => 'Kg'},
 # 
 #   {:name => 'azote', :category => Category.find_by_name('azote'), :dosage => 200, :unit => 'L/Ha', :date => '2010-02-16', :prix_littre => 0, 
 #   :cout_ha_passage => 0, :cout_fixe => 0, :user => User.find_by_name('Trochet'), :saison => saison_2009_2010, :desc => '200 Kg, 67u'},
 # 
 #   {:name => 'azote', :category => Category.find_by_name('azote'), :dosage => 200, :unit => 'L/Ha', :date => '2010-03-06', :prix_littre => 0, 
 #   :cout_ha_passage => 0, :cout_fixe => 0, :user => User.find_by_name('Trochet'), :saison => saison_2009_2010, :desc => '200 Kg, 67u'},
 # 
 #   {:name => 'suplason', :category => Category.find_by_name('desherbant'), :dosage => 1, :unit => 'L/Ha', :date => '2010-04-18', :prix_littre => 0, 
 #   :cout_ha_passage => 0, :cout_fixe => 0, :user => User.find_by_name('Trochet'), :saison => saison_2009_2010, :desc => '+ Storane 0.9L16 ha derriere maison'},
 # 
 #   {:name => 'azote', :category => Category.find_by_name('azote'), :dosage => 120, :unit => 'L/Ha', :date => '2010-05-17', :prix_littre => 0, 
 #   :cout_ha_passage => 0, :cout_fixe => 0, :user => User.find_by_name('Trochet'), :saison => saison_2009_2010, :desc => '120Kg, 40u'},
 # 
 #   {:name => 'comet Player', :category => Category.find_by_name('fongicide'), :dosage => 120, :unit => 'L/Ha', :date => '2010-05-28', :prix_littre => 0, 
 #   :cout_ha_passage => 0, :cout_fixe => 0, :user => User.find_by_name('Trochet'), :saison => saison_2009_2010, :desc => ''}
 # 
 #    ])

 parcelle = saison_2009_2010.parcelles.find_by_name('Le Bourg-2')
 parcelle.typeculture = Typeculture.find_by_name('Ble')
 parcelle.save!

 # pulves.each do |pulve|
 #   putoparcelle = Putoparcelle.create!(:parcelle => parcelle, :pulve => pulve, :value => 0)
 # end
 labours.each do |labour|
   labtoparcelle = Labtoparcelle.create!(:parcelle => parcelle, :labour => labour, :value => 0)
 end


 # 14 Ha Piste Avion - Tournesol - Labours
 labours = Labour.create!([
   {:name => 'moisson', :cout_ha_passage => 10, :user => User.find_by_name('Trochet'), :saison => saison_2009_2010, :date => '2009-07-25',
   :desc => "", :category => Category.find_by_name('moisson')} ])

 # 14 Ha Piste Avion - Tournesol - Pulves
 # pulves = Pulve.create!([
 # 
 #   {:name => 'Glyphosate', :category => Category.find_by_name('desherbant'), :dosage => 2, :unit => 'L/Ha', :date => '2009-11-22', :prix_littre => 0, 
 #   :cout_ha_passage => 0, :cout_fixe => 0, :user => User.find_by_name('Trochet'), :saison => saison_2009_2010, :desc => 'L/Ha, + huile 1L/Ha'},
 # 
 #   {:name => '0-20-30', :category => Category.find_by_name('engrais'), :dosage => 250, :unit => 'L/Ha', :date => '2009-03-24', :prix_littre => 0, 
 #   :cout_ha_passage => 0, :cout_fixe => 0, :user => User.find_by_name('Trochet'), :saison => saison_2009_2010, :desc => 'Kg'},
 # 
 #   {:name => 'Glyphosate', :category => Category.find_by_name('desherbant'), :dosage => 2, :unit => 'L/Ha', :date => '2009-04-14', :prix_littre => 0, 
 #   :cout_ha_passage => 0, :cout_fixe => 0, :user => User.find_by_name('Trochet'), :saison => saison_2009_2010, :desc => 'L/Ha, + huile 1L/Ha'},
 # 
 #   {:name => 'Imperio', :category => Category.find_by_name('semis'), :dosage => 170, :unit => 'L/Ha', :date => '2009-04-10', :prix_littre => 0, 
 #   :cout_ha_passage => 0, :cout_fixe => 0, :user => User.find_by_name('Trochet'), :saison => saison_2009_2010, :desc => 'Kg, dosage inconnu'},
 # 
 #   {:name => 'Challenge', :category => Category.find_by_name('desherbant'), :dosage => 3.5, :unit => 'L/Ha', :date => '2009-04-14', :prix_littre => 0, 
 #   :cout_ha_passage => 0, :cout_fixe => 0, :user => User.find_by_name('Trochet'), :saison => saison_2009_2010, :desc => 'L/Ha, + Iso 2L/Ha. Sur tournesol + tour de champs'},
 # 
 #   {:name => 'azote', :category => Category.find_by_name('azote'), :dosage => 107, :unit => 'L/Ha', :date => '2010-06-07', :prix_littre => 0, 
 #   :cout_ha_passage => 0, :cout_fixe => 0, :user => User.find_by_name('Trochet'), :saison => saison_2009_2010, :desc => '107 Kg, 35u'}
 # 
 #    ])

 parcelle = saison_2009_2010.parcelles.find_by_name('Feuillets')
 parcelle.typeculture = Typeculture.find_by_name('Ble')
 parcelle.save!

 # pulves.each do |pulve|
 #   putoparcelle = Putoparcelle.create!(:parcelle => parcelle, :pulve => pulve, :value => 0)
 # end
 labours.each do |labour|
   labtoparcelle = Labtoparcelle.create!(:parcelle => parcelle, :labour => labour, :value => 0)
 end









