# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#

Upcategory.delete_all
Category.delete_all
upcategories = Upcategory.create([{ :name => 'facture'}, 
{ :name => 'pulve' }, 
{ :name => 'labour' },
{ :name => 'vente' }])

pulve = Upcategory.find_by_name('pulve')
facture = Upcategory.find_by_name('facture')
labour = Upcategory.find_by_name('labour')
vente = Upcategory.find_by_name('vente')
diverse = Upcategory.find_by_name('diverse')

categories = Category.create([
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
{ :name => 'moisson', :upcategory => labour },
{ :name => 'covercrop', :upcategory => labour },
{ :name => 'vibro', :upcategory => labour },

{ :name => 'foin', :upcategory => vente },
{ :name => 'PAC', :upcategory => vente },
{ :name => 'Avoir', :upcategory => vente }
])

factcats = Factcat.create([
  { :name => 'agri'}, 
  { :name => 'maison' }, 
  { :name => 'invest' }])

saison = Saison.create(:name => "Saison-install", :year => "2010")
setting = Setting.create( :saison => saison, :value_parcelle => false, :detail_desc => false, :detail_ref => false)

typecultures = Typeculture.create([
{:name => "Ble"},
{:name => "2eme Ble"}, 
{:name => "Colza"},
{:name => "RayGrass"},
{:name => "Jachere"}])
typeculture = Typeculture.find(:first)

zones = Zone.create([
{:name => "Mitant", :surface => 5.09},
{:name => "Bons Pains", :surface => 14.01},
{:name => "La Rue", :surface => 46.55},
{:name => "Reserve", :surface => 2.55},
{:name => "Vallees", :surface => 13.68},
{:name => "Guiberons", :surface => 3.0},
{:name => "Taillis", :surface => 19.32},
{:name => "Brandes", :surface => 2.97},
{:name => "Feuillets", :surface => 16.05},
{:name => "Lavernier", :surface => 0.75},
{:name => "Varennes", :surface => 15.86},
{:name => "Patureaux", :surface => 8.87},
{:name => "Prairies", :surface => 13.26},
{:name => "Le Bourg-1", :surface => 0.52},
{:name => "Le Bourg-2", :surface => 1.35}])

for zone in zones
  parcelle = Parcelle.create( :name => zone.name, 
                              :saison => saison, 
                              :typeculture => typeculture, 
                              :surface => zone.surface)
  zonetopa = Zonetopa.create(:parcelle => parcelle, :zone => zone, :value => zone.surface)
end

zonetopa = Zonetopa.find(:first)
parcelle = Parcelle.find(:first)
zone = Zone.find(:first)

factypes = Factype.create([
{:name => "diff", :display => "diff", :desc => "test desc"},
{:name => "total", :display => "total", :desc => "test desc"},
{:name => "null", :display => "null", :desc => "test desc"}])

users = User.create([
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

myuser = Myuser.create([
{:login => "admin",:password => "admin", :admin => true},
{:login => "matthieu", :admin => false},
{:login => "elisabeth", :admin => false},
{:login => "thierry", :admin => false}
])

#===== TESTING DATA ========

factureA = Debit.create(:name => 'Debit 1', 
                          :cout => 1000, 
                          :user => User.find(:first),
                          :factype => Factype.find_by_name("diff"),
                          :factcat => Factcat.find_by_name("agri"),
                          :saison => saison,
                          :date => '2011-01-01',
                          :desc => "from seeds",
                          :category => Category.find_by_name('deplacement'))

# factureB = Debit.create(:name => 'Debit 2', 
#                           :cout => 1000, 
#                           :user => User.find(:first),
#                           :factype => Factype.find_by_name("diff"),
#                           :factcat => Factcat.find_by_name("maison"),
#                           :saison => saison,
#                           :date => '2011-01-01',
#                           :desc => "from seeds",
#                           :category => Category.find_by_name('deplacement'))
# 
#labourA = Labour.create(  :name => 'Labour 1', 
#                          :cout_ha_passage => 10, 
#                          :user => User.find(:first),
#                          :saison => saison,
#                          :date => '2011-01-01',
#                          :desc => "from seeds",
#                          :category => Category.find_by_name('covercrop'))
#
#labourB = Labour.create(  :name => 'Labour 2', 
#                          :cout_ha_passage => 10, 
#                          :user => User.find(:first),
#                          :saison => saison,
#                          :date => '2011-01-01',
#                          :desc => "from seeds",
#                          :category => Category.find_by_name('covercrop'))
#
#Labtofacture.create(  :facture_id => factureA.id,
#                      :labour_id => labourA.id,
#                      :value => 10)
#                      
#Labtofacture.create(  :facture_id => factureB.id,
#                      :labour_id => labourB.id,
#                      :value => 11)

# pulveA = Pulve.create(  :name => 'Pulve 1', 
#                         :dosage => 0,
#                         :prix_littre => 0,
#                         :cout_ha_passage => 1,
#                         :cout_fixe => 0,
#                         :user => User.find(:first),
#                         :saison => saison,
#                         :date => '2011-01-01',
#                         :desc => "from seeds",
#                         :category => Category.find_by_name('herbicide'))
# 
# pulveB = Pulve.create(  :name => 'Pulve 2', 
#                         :dosage => 0,
#                         :prix_littre => 0,
#                         :cout_ha_passage => 0,
#                         :cout_fixe => 10,
#                         :user => User.find(:first),
#                         :saison => saison,
#                         :date => '2011-01-01',
#                         :desc => "from seeds",
#                         :category => Category.find_by_name('glyphosate'))
# 
# Putofacture.create(  :facture_id => factureA.id,
#                      :pulve_id => pulveA.id,
#                      :value => 0)
#                       
# Putofacture.create(  :facture_id => factureB.id,
#                      :pulve_id => pulveB.id,
#                      :value => 0)    

#===== SEEDS SAISON 2009/2010 ========
saison_2009_2010 = Saison.create(:name => "2009/2010", :year => "2009")
setting.saison = saison_2009_2010
setting.save!

factureA = Debit.create(:name => 'Debit 1', 
                          :cout => 1000, 
                          :user => User.find(:first),
                          :factype => Factype.find_by_name("diff"),
                          :factcat => Factcat.find_by_name("agri"),
                          :saison => saison_2009_2010,
                          :date => '2011-01-01',
                          :desc => "from seeds",
                          :category => Category.find_by_name('deplacement'))

# 
# zones = Zone.create([
# {:name => "Mitant", :surface => 5.09},
# {:name => "Bons Pains", :surface => 14.01},
# {:name => "La Rue", :surface => 46.55},
# {:name => "Reserve", :surface => 2.55},
# {:name => "Vallees", :surface => 13.68},
# {:name => "Guiberons", :surface => 3.0},
# {:name => "Taillis", :surface => 19.32},
# {:name => "Brandes", :surface => 2.97},
# {:name => "Feuillets", :surface => 16.05},
# {:name => "Lavernier", :surface => 0.75},
# {:name => "Varennes", :surface => 15.86},
# {:name => "Patureaux", :surface => 8.87},
# {:name => "Prairies", :surface => 13.26},
# {:name => "Le Bourg-1", :surface => 0.52},
# {:name => "Le Bourg-2", :surface => 1.35}])

for zone in zones
  parcelle = Parcelle.create( :name => zone.name, 
                              :saison => saison_2009_2010, 
                              :typeculture => Typeculture.find(:first), 
                              :surface => zone.surface)
  zonetopa = Zonetopa.create(:parcelle => parcelle, :zone => zone, :value => zone.surface)
end



# 5 Ha + Bruneau - Labours
# labours = Labour.create([
#   {:name => 'moisson', :cout_ha_passage => 10, :user => User.find_by_name('Trochet'), :saison => saison_2009_2010, :date => '2009-07-24',
#   :desc => "", :category => Category.find_by_name('moisson')} ]),

# 5 Ha + Bruneau - Pulves
# pulves = Pulve.create!([
#   {:name => 'Campo + Catalino', :category => Category.find_by_name('semis'), :dosage => 3.5, :date => '2009-08-31', :prix_littre => 0, 
#   :cout_ha_passage => 0, :cout_fixe => 0, :user => User.find_by_name('Trochet'), :saison => saison_2009_2010, :desc => 'Kg/Ha, Catalino selection 2Ha cote haie'},
# 
#   {:name => 'Colzamid', :category => Category.find_by_name('desherbant'), :dosage => 2.2, :date => '2009-08-31', :prix_littre => 0, 
#   :cout_ha_passage => 0, :cout_fixe => 0, :user => User.find_by_name('Trochet'), :saison => saison_2009_2010, :desc => 'L/Ha'},
# 
#   {:name => 'Novrel', :category => Category.find_by_name('desherbant'), :dosage => 1.8, :date => '2009-09-02', :prix_littre => 0, 
#   :cout_ha_passage => 0, :cout_fixe => 0, :user => User.find_by_name('Trochet'), :saison => saison_2009_2010, :desc => 'L/Ha'},
# 
#   {:name => 'folyr', :category => Category.find_by_name('desherbant'), :dosage => 0.6, :date => '2009-09-20', :prix_littre => 0, 
#   :cout_ha_passage => 0, :cout_fixe => 0, :user => User.find_by_name('Trochet'), :saison => saison_2009_2010, :desc => 'L/Ha'},
# 
#   {:name => 'fury', :category => Category.find_by_name('desherbant'), :dosage => 0.1, :date => '2009-09-20', :prix_littre => 0, 
#   :cout_ha_passage => 0, :cout_fixe => 0, :user => User.find_by_name('Trochet'), :saison => saison_2009_2010, :desc => 'L/Ha + huile 1L'},
# 
#   {:name => '0-25-25', :category => Category.find_by_name('engrais'), :dosage => 200, :date => '2010-02-04', :prix_littre => 0, 
#   :cout_ha_passage => 0, :cout_fixe => 0, :user => User.find_by_name('Trochet'), :saison => saison_2009_2010, :desc => 'Kg ou Kg/Ha ?', :star => 1},
#   
#   {:name => 'azote', :category => Category.find_by_name('azote'), :dosage => 195, :date => '2010-02-10', :prix_littre => 0, 
#   :cout_ha_passage => 0, :cout_fixe => 0, :user => User.find_by_name('Trochet'), :saison => saison_2009_2010, :desc => '195Kg = 65u'},
#   
#   {:name => 'azote', :category => Category.find_by_name('azote'), :dosage => 230, :date => '2010-03-09', :prix_littre => 0, 
#   :cout_ha_passage => 0, :cout_fixe => 0, :user => User.find_by_name('Trochet'), :saison => saison_2009_2010, :desc => '230Kg = 77u'},
#   
#   {:name => 'azomag', :category => Category.find_by_name('soufre'), :dosage => 150, :date => '2010-03-12', :prix_littre => 0, 
#   :cout_ha_passage => 0, :cout_fixe => 0, :user => User.find_by_name('Trochet'), :saison => saison_2009_2010, :desc => '150Kg = 30u'},
#   
#   {:name => 'fury', :category => Category.find_by_name('insecticide'), :dosage => 0.10, :date => '2010-03-19', :prix_littre => 0, 
#   :cout_ha_passage => 0, :cout_fixe => 0, :user => User.find_by_name('Trochet'), :saison => saison_2009_2010, :desc => 'L/Ha'},
#   
#   {:name => 'proteus', :category => Category.find_by_name('insecticide'), :dosage => 0.5, :date => '2010-04-06', :prix_littre => 0, 
#   :cout_ha_passage => 0, :cout_fixe => 0, :user => User.find_by_name('Trochet'), :saison => saison_2009_2010, :desc => 'L/Ha'},
#   
#   {:name => 'sunorg', :category => Category.find_by_name('fongicide'), :dosage => 0.6, :date => '2010-04-18', :prix_littre => 0, 
#   :cout_ha_passage => 0, :cout_fixe => 0, :user => User.find_by_name('Trochet'), :saison => saison_2009_2010, :desc => 'L/Ha'},
#   
#   {:name => 'anistar', :category => Category.find_by_name('fongicide'), :dosage => 0.75, :date => '2010-05-07', :prix_littre => 0, 
#   :cout_ha_passage => 0, :cout_fixe => 0, :user => User.find_by_name('Trochet'), :saison => saison_2009_2010, :desc => 'L/Ha'}
#   
# 
# ])
# 
# 
# parcelle = saison_2009_2010.parcelles.find_by_name('Mitant')                      
# pulves.each do |pulve|
#   putoparcelle = Putoparcelle.create!(:parcelle => parcelle, :pulve => pulve, :value => 0)
# end
# 










