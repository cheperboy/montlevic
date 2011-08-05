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

saison = Saison.create(:name => "Saison-test", :year => "2010")
setting = Setting.create( :saison => saison, :float_precision => 1, :value_parcelle => false, :detail_desc => false, :detail_ref => false)

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

for zone in Zone.find([1, 2, 3])
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

factureB = Debit.create(:name => 'Debit 2', 
                          :cout => 1000, 
                          :user => User.find(:first),
                          :factype => Factype.find_by_name("diff"),
                          :factcat => Factcat.find_by_name("maison"),
                          :saison => saison,
                          :date => '2011-01-01',
                          :desc => "from seeds",
                          :category => Category.find_by_name('deplacement'))

labourA = Labour.create(  :name => 'Labour 1', 
                         :cout_ha_passage => 10, 
                         :user => User.find(:first),
                         :saison => saison,
                         :date => '2011-01-01',
                         :desc => "from seeds",
                         :category => Category.find_by_name('covercrop'))

labourB = Labour.create(  :name => 'Labour 2', 
                         :cout_ha_passage => 10, 
                         :user => User.find(:first),
                         :saison => saison,
                         :date => '2011-01-01',
                         :desc => "from seeds",
                         :category => Category.find_by_name('covercrop'))

Labtofacture.create(  :facture_id => factureA.id,
                     :labour_id => labourA.id,
                     :value => 10)
                     
Labtofacture.create(  :facture_id => factureB.id,
                     :labour_id => labourB.id,
                     :value => 11)

pulveA = Pulve.create(  :name => 'Pulve 1', 
                       :cout_ha_passage => 0,
                       :cout_fixe => 0,
                       :user => User.find(:first),
                       :saison => saison,
                       :date => '2011-01-01',
                       :desc => "from seeds")

pulveB = Pulve.create(  :name => 'Pulve 2', 
                       :cout_ha_passage => 0,
                       :cout_fixe => 10,
                       :user => User.find(:first),
                       :saison => saison,
                       :date => '2011-01-01',
                       :desc => "from seeds")


#===== SEEDS SAISON 2009/2010 ========
saison_2009_2010 = Saison.create(:name => "2009/2010", :year => "2009")
setting.saison = saison_2009_2010
setting.save!

factureA = Debit.create(:name => 'Achat Phyto', 
                          :cout => 1305, 
                          :user => User.find(:first),
                          :factype => Factype.find_by_name("diff"),
                          :factcat => Factcat.find_by_name("agri"),
                          :saison => saison_2009_2010,
                          :date => '2011-01-01',
                          :desc => "FURY en 5L x5 : 5 x 41.50 = 207.5 => 1.66 e/L AMISTAR en 5L x25 : 43,90 x 25 = 1097.5",
                          :category => Category.find_by_name('deplacement'))

pulveA = Pulve.create( :name => 'Fury', 
                       :cout_ha_passage => 0,
                       :user => User.find(:first),
                       :saison => saison_2009_2010,
                       :date => '2011-01-01',
                       :desc => "from seeds")

produitA = Produit.create(:name => 'Fury', 
                          :unit => 'L',
                          :saison => saison_2009_2010,
                          :desc => "FURY en 5L x5 : 5 x 41.50 = 207.5 => 1.66 e/L",
                          :category => Category.find_by_name('desherbant'))
                          

produitB = Produit.create(:name => 'AMISTAR', 
                          :unit => 'L',
                          :saison => saison_2009_2010,
                          :desc => "AMISTAR en 5L x25 : 43,90 x 25 = 1097.5",
                          :category => Category.find_by_name('desherbant'))
                          
protofacture = Protofacture.create( :produit => produitA,
                                    :facture => factureA,
                                    :quantite => 25,
                                    :prix => 207.5)

protofacture = Protofacture.create( :produit => produitB,
                                    :facture => factureA,
                                    :quantite => 125,
                                    :prix => 1097.5)

putoproduit = Putoproduit.create( :pulve => pulveA,
                                  :produit => produitA,
                                  :saison => saison_2009_2010,
                                  :dosage => 2)


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
labours = Labour.create([
  {:name => 'moisson', :cout_ha_passage => 10, :user => User.find_by_name('Trochet'), :saison => saison_2009_2010, :date => '2009-07-24',
  :desc => "", :category => Category.find_by_name('moisson')} ])

  # 5 Ha + Bruneau - Pulves
  # pulves = Pulve.create!([
  #   {:name => 'Campo + Catalino', :category => Category.find_by_name('semis'), :dosage => 3.5, :unit => 'Kg/Ha', :date => '2009-08-31', :prix_littre => 0, 
  #   :cout_ha_passage => 0, :cout_fixe => 0, :user => User.find_by_name('Trochet'), :saison => saison_2009_2010, :desc => 'Kg/Ha, Catalino selection 2Ha cote haie'},
  # 
  #   {:name => 'Colzamid', :category => Category.find_by_name('desherbant'), :dosage => 2.2, :unit => 'L/Ha', :date => '2009-08-31', :prix_littre => 0, 
  #   :cout_ha_passage => 0, :cout_fixe => 0, :user => User.find_by_name('Trochet'), :saison => saison_2009_2010, :desc => 'L/Ha'},
  # 
  #   {:name => 'Novrel', :category => Category.find_by_name('desherbant'), :dosage => 1.8, :unit => 'L/Ha', :date => '2009-09-02', :prix_littre => 0, 
  #   :cout_ha_passage => 0, :cout_fixe => 0, :user => User.find_by_name('Trochet'), :saison => saison_2009_2010, :desc => 'L/Ha'},
  # 
  #   {:name => 'folyr', :category => Category.find_by_name('desherbant'), :dosage => 0.6, :unit => 'L/Ha', :date => '2009-09-20', :prix_littre => 0, 
  #   :cout_ha_passage => 0, :cout_fixe => 0, :user => User.find_by_name('Trochet'), :saison => saison_2009_2010, :desc => 'L/Ha'},
  # 
  #   {:name => 'fury', :category => Category.find_by_name('desherbant'), :dosage => 0.1, :unit => 'L/Ha', :date => '2009-09-20', :prix_littre => 0, 
  #   :cout_ha_passage => 0, :cout_fixe => 0, :user => User.find_by_name('Trochet'), :saison => saison_2009_2010, :desc => 'L/Ha + huile 1L'},
  # 
  #   {:name => '0-25-25', :category => Category.find_by_name('engrais'), :dosage => 200, :unit => 'L/Ha', :date => '2010-02-04', :prix_littre => 0, 
  #   :cout_ha_passage => 0, :cout_fixe => 0, :user => User.find_by_name('Trochet'), :saison => saison_2009_2010, :desc => 'Kg ou Kg/Ha ?', :star => 1},
  # 
  #   {:name => 'azote', :category => Category.find_by_name('azote'), :dosage => 195, :unit => 'L/Ha', :date => '2010-02-10', :prix_littre => 0, 
  #   :cout_ha_passage => 0, :cout_fixe => 0, :user => User.find_by_name('Trochet'), :saison => saison_2009_2010, :desc => '195Kg = 65u'},
  # 
  #   {:name => 'azote', :category => Category.find_by_name('azote'), :dosage => 230, :unit => 'L/Ha', :date => '2010-03-09', :prix_littre => 0, 
  #   :cout_ha_passage => 0, :cout_fixe => 0, :user => User.find_by_name('Trochet'), :saison => saison_2009_2010, :desc => '230Kg = 77u'},
  # 
  #   {:name => 'azomag', :category => Category.find_by_name('soufre'), :dosage => 150, :unit => 'L/Ha', :date => '2010-03-12', :prix_littre => 0, 
  #   :cout_ha_passage => 0, :cout_fixe => 0, :user => User.find_by_name('Trochet'), :saison => saison_2009_2010, :desc => '150Kg = 30u'},
  # 
  #   {:name => 'fury', :category => Category.find_by_name('insecticide'), :dosage => 0.10, :unit => 'L/Ha', :date => '2010-03-19', :prix_littre => 0, 
  #   :cout_ha_passage => 0, :cout_fixe => 0, :user => User.find_by_name('Trochet'), :saison => saison_2009_2010, :desc => 'L/Ha'},
  # 
  #   {:name => 'proteus', :category => Category.find_by_name('insecticide'), :dosage => 0.5, :unit => 'L/Ha', :date => '2010-04-06', :prix_littre => 0, 
  #   :cout_ha_passage => 0, :cout_fixe => 0, :user => User.find_by_name('Trochet'), :saison => saison_2009_2010, :desc => 'L/Ha'},
  # 
  #   {:name => 'sunorg', :category => Category.find_by_name('fongicide'), :dosage => 0.6, :unit => 'L/Ha', :date => '2010-04-18', :prix_littre => 0, 
  #   :cout_ha_passage => 0, :cout_fixe => 0, :user => User.find_by_name('Trochet'), :saison => saison_2009_2010, :desc => 'L/Ha'},
  # 
  #   {:name => 'anistar', :category => Category.find_by_name('fongicide'), :dosage => 0.75, :unit => 'L/Ha', :date => '2010-05-07', :prix_littre => 0, 
  #   :cout_ha_passage => 0, :cout_fixe => 0, :user => User.find_by_name('Trochet'), :saison => saison_2009_2010, :desc => 'L/Ha'}
  # ])

parcelle = saison_2009_2010.parcelles.find_by_name('Mitant')
parcelle.typeculture = Typeculture.find_by_name('Colza')
parcelle.save!

# pulves.each do |pulve|
#   putoparcelle = Putoparcelle.create!(:parcelle => parcelle, :pulve => pulve, :value => 0)
# end
labours.each do |labour|
  labtoparcelle = Labtoparcelle.create!(:parcelle => parcelle, :labour => labour, :value => 0)
end

  # 12 Ha Les Feuillets - Labours
  labours = Labour.create!([
    {:name => 'moisson', :cout_ha_passage => 10, :user => User.find_by_name('Trochet'), :saison => saison_2009_2010, :date => '2009-07-25',
    :desc => "", :category => Category.find_by_name('moisson')} ])

  # 12 Ha Les Feuillets - Pulves
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


  parcelle = saison_2009_2010.parcelles.find_by_name('Feuillets')
  parcelle.typeculture = Typeculture.find_by_name('Colza')
  parcelle.save!

  # pulves.each do |pulve|
  #   putoparcelle = Putoparcelle.create!(:parcelle => parcelle, :pulve => pulve, :value => 0)
  # end
  labours.each do |labour|
    labtoparcelle = Labtoparcelle.create!(:parcelle => parcelle, :labour => labour, :value => 0)
  end
  
  # 14 Ha + 9Ha Cote luzerne - Labours
  labours = Labour.create!([
    {:name => 'moisson', :cout_ha_passage => 10, :user => User.find_by_name('Trochet'), :saison => saison_2009_2010, :date => '2009-07-25',
    :desc => "", :category => Category.find_by_name('moisson')} ])

  # 14 Ha + 9Ha Cote luzerne - Pulves
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

  parcelle = saison_2009_2010.parcelles.find_by_name('Feuillets')
  parcelle.typeculture = Typeculture.find_by_name('Ble')
  parcelle.save!

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
  #   
  #     ])

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









