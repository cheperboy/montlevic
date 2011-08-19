#===== SEEDS SAISON 2009/2010 ========
trochet = User.find_by_name('Trochet')
saison_2009_2010 = Saison.create!(:name => "!!!!/2010", :year => "2009")
setting.saison = saison_2009_2010
setting.save!

for zone in zones
  parcelle = Parcelle.create!( :name => zone.name, 
                              :saison => saison_2009_2010, 
                              :typeculture => Typeculture.find(:first), 
                              :surface => zone.surface)
  zonetopa = Zonetopa.create!(:parcelle => parcelle, :zone => zone, :value => zone.surface)
end

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
campo = Produit.create!(:name => 'Campo', 
                         :unit => 'kg',
                         :saison => saison_2009_2010,
                         :desc => "FURY en 5L x5 : 5 x 41.50 = 207.5 => 1.66 e/L",
                         :category => Category.find_by_name('semis'))

catalino = Produit.create!(
:name => 'Catalino', :unit => 'kg', :saison => saison_2009_2010, :desc => "", :category => Category.find_by_name('semis'))

colzamid = Produit.create!(
:name => 'Colzamid', :unit => 'L', :saison => saison_2009_2010, :desc => "", :category => Category.find_by_name('desherbant'))

novrel = Produit.create!(
:name => 'Novrel', :unit => 'L', :saison => saison_2009_2010, :desc => "", :category => Category.find_by_name('desherbant'))

folyr = Produit.create!(
:name => 'Folyr', :unit => 'L', :saison => saison_2009_2010, :desc => "", :category => Category.find_by_name('desherbant'))

fury = Produit.create!(
:name => 'Fury', :unit => 'L', :saison => saison_2009_2010, :desc => "", :category => Category.find_by_name('insecticide'))

zero2525 = Produit.create!(
:name => '0-25-25', :unit => 'kg', :saison => saison_2009_2010, :desc => "", :category => Category.find_by_name('engrais'))

azote = Produit.create!(
:name => 'Azote', :unit => 'L', :saison => saison_2009_2010, :desc => "", :category => Category.find_by_name('azote'))

azomag = Produit.create!(
:name => 'Azomag20', :unit => 'L', :saison => saison_2009_2010, :desc => "", :category => Category.find_by_name('soufre'))
#FIXME Azomag et souffre. est-ce le meme produit?

azomag20 = Produit.create!(
:name => 'Azomag20', :unit => 'L', :saison => saison_2009_2010, :desc => "", :category => Category.find_by_name('soufre'))

proteus = Produit.create!(
:name => 'Proteus', :unit => 'L', :saison => saison_2009_2010, :desc => "", :category => Category.find_by_name('insecticide'))

sunorg = Produit.create!(
:name => 'Sunorg', :unit => 'L', :saison => saison_2009_2010, :desc => "", :category => Category.find_by_name('fongicide'))

anistar = Produit.create!(
:name => 'Anistar', :unit => 'L', :saison => saison_2009_2010, :desc => "", :category => Category.find_by_name('fongicide'))

glyphosate = Produit.create!(
:name => 'Glyphosate', :unit => 'L', :saison => saison_2009_2010, :desc => "", :category => Category.find_by_name('desherbant'))

chrono = Produit.create!(
:name => 'Chrono', :unit => 'L', :saison => saison_2009_2010, :desc => "", :category => Category.find_by_name('desherbant'))

chrono = Produit.create!(
:name => 'Chrono', :unit => 'L', :saison => saison_2009_2010, :desc => "", :category => Category.find_by_name('desherbant'))

# 5 Ha + Bruneau - Pulves
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
#FIXME engrais en kg ou en kg/Ha ?

pulve = Pulve.create!( 
:name => 'Azote', :cout_ha_passage => 0, :user => trochet, :saison => saison_2009_2010, :date => '2010-02-10', :desc => "195kg = 65u")
putoproduit = Putoproduit.create!( :pulve => pulve, :produit => azote, :saison => saison_2009_2010, :dosage => 195)
pulves << pulve

pulve = Pulve.create!( 
:name => 'Azote 2eme', :cout_ha_passage => 0, :user => trochet, :saison => saison_2009_2010, :date => '2010-03-09', :desc => "230kg = 77u")
putoproduit = Putoproduit.create!( :pulve => pulve, :produit => azote, :saison => saison_2009_2010, :dosage => 230)
pulves << pulve

pulve = Pulve.create!( 
:name => 'Azomag', :cout_ha_passage => 0, :user => trochet, :saison => saison_2009_2010, :date => '2010-03-12', :desc => "150kg = 30u")
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


parcelle = saison_2009_2010.parcelles.find_by_name('Mitant')
parcelle.typeculture = Typeculture.find_by_name('Colza')
parcelle.save!

pulves.each do |pulve|
  putoparcelle = Putoparcelle.create!(:parcelle => parcelle, :pulve => pulve, :value => 0)
end
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
  #   :cout_ha_passage => 0, :cout_fixe => 0, :user => User.find_by_name('Trochet'), :saison => saison_2009_2010, :desc => 'kg/Ha, verifier dosage semis.', :star => 1},
  # 
  #   {:name => 'Chrono', :category => Category.find_by_name('desherbant'), :dosage => 1.04, :unit => 'L/Ha', :date => '2009-09-29', :prix_littre => 0, 
  #   :cout_ha_passage => 0, :cout_fixe => 0, :user => User.find_by_name('Trochet'), :saison => saison_2009_2010, :desc => 'kg/Ha'},
  # 
  #   {:name => 'Folyr + huile', :category => Category.find_by_name('desherbant'), :dosage => 0.6, :unit => 'L/Ha', :date => '2009-11-20', :prix_littre => 0, 
  #   :cout_ha_passage => 0, :cout_fixe => 0, :user => User.find_by_name('Trochet'), :saison => saison_2009_2010, :desc => 'kg/Ha, + huile 1L'},
  # 
  #   {:name => 'Fury', :category => Category.find_by_name('insecticide'), :dosage => 0.1, :unit => 'L/Ha', :date => '2009-11-22', :prix_littre => 0, 
  #   :cout_ha_passage => 0, :cout_fixe => 0, :user => User.find_by_name('Trochet'), :saison => saison_2009_2010, :desc => 'L/Ha'},
  # 
  #   {:name => '0-25-25', :category => Category.find_by_name('engrais'), :dosage => 200, :unit => 'L/Ha', :date => '2010-02-04', :prix_littre => 0, 
  #   :cout_ha_passage => 0, :cout_fixe => 0, :user => User.find_by_name('Trochet'), :saison => saison_2009_2010, :desc => 'kg'},
  # 
  #   {:name => 'azote', :category => Category.find_by_name('azote'), :dosage => 225, :unit => 'L/Ha', :date => '2010-02-10', :prix_littre => 0, 
  #   :cout_ha_passage => 0, :cout_fixe => 0, :user => User.find_by_name('Trochet'), :saison => saison_2009_2010, :desc => 'kg, 75u'},
  # 
  #   {:name => 'azomag 20', :category => Category.find_by_name('soufre'), :dosage => 150, :unit => 'L/Ha', :date => '2010-03-12', :prix_littre => 0, 
  #   :cout_ha_passage => 0, :cout_fixe => 0, :user => User.find_by_name('Trochet'), :saison => saison_2009_2010, :desc => 'kg, 30u'},
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
  #   :cout_ha_passage => 0, :cout_fixe => 0, :user => User.find_by_name('Trochet'), :saison => saison_2009_2010, :desc => 'kg, PR + Richepain + Frelon + selection Paledor + Richepain n41'},
  # 
  #   {:name => 'Celtic', :category => Category.find_by_name('desherbant'), :dosage => 2, :unit => 'L/Ha', :date => '2009-11-19', :prix_littre => 0, 
  #   :cout_ha_passage => 0, :cout_fixe => 0, :user => User.find_by_name('Trochet'), :saison => saison_2009_2010, :desc => 'L/Ha, + Iso 2L/Ha. Sur tournesol + tour de champs'},
  # 
  #   {:name => 'Harmony', :category => Category.find_by_name('desherbant'), :dosage => 25, :unit => 'L/Ha', :date => '2009-11-19', :prix_littre => 0, 
  #   :cout_ha_passage => 0, :cout_fixe => 0, :user => User.find_by_name('Trochet'), :saison => saison_2009_2010, :desc => 'g, + Picosolo, 80g/Ha. sur Colza'},
  # 
  #   {:name => 'super 45', :category => Category.find_by_name('engrais'), :dosage => 157, :unit => 'L/Ha', :date => '2010-02-04', :prix_littre => 0, 
  #   :cout_ha_passage => 0, :cout_fixe => 0, :user => User.find_by_name('Trochet'), :saison => saison_2009_2010, :desc => 'kg'},
  # 
  #   {:name => 'azote', :category => Category.find_by_name('azote'), :dosage => 190, :unit => 'L/Ha', :date => '2010-02-11', :prix_littre => 0, 
  #   :cout_ha_passage => 0, :cout_fixe => 0, :user => User.find_by_name('Trochet'), :saison => saison_2009_2010, :desc => '190 kg, 64u'},
  # 
  #   {:name => 'azote', :category => Category.find_by_name('azote'), :dosage => 183, :unit => 'L/Ha', :date => '2010-03-09', :prix_littre => 0, 
  #   :cout_ha_passage => 0, :cout_fixe => 0, :user => User.find_by_name('Trochet'), :saison => saison_2009_2010, :desc => '183 kg, 61u'},
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
  #   :cout_ha_passage => 0, :cout_fixe => 0, :user => User.find_by_name('Trochet'), :saison => saison_2009_2010, :desc => '120kg, 40u'},
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
  #   :cout_ha_passage => 0, :cout_fixe => 0, :user => User.find_by_name('Trochet'), :saison => saison_2009_2010, :desc => 'kg, Autan'},
  # 
  #   {:name => 'super 45', :category => Category.find_by_name('engrais'), :dosage => 157, :unit => 'L/Ha', :date => '2010-02-04', :prix_littre => 0, 
  #   :cout_ha_passage => 0, :cout_fixe => 0, :user => User.find_by_name('Trochet'), :saison => saison_2009_2010, :desc => 'kg'},
  # 
  #   {:name => 'azote', :category => Category.find_by_name('azote'), :dosage => 210, :unit => 'L/Ha', :date => '2010-02-15', :prix_littre => 0, 
  #   :cout_ha_passage => 0, :cout_fixe => 0, :user => User.find_by_name('Trochet'), :saison => saison_2009_2010, :desc => '210kg, 70u'},
  # 
  #   {:name => 'azote', :category => Category.find_by_name('azote'), :dosage => 200, :unit => 'L/Ha', :date => '2010-03-09', :prix_littre => 0, 
  #   :cout_ha_passage => 0, :cout_fixe => 0, :user => User.find_by_name('Trochet'), :saison => saison_2009_2010, :desc => '200kg, 67u'},
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
  #   :cout_ha_passage => 0, :cout_fixe => 0, :user => User.find_by_name('Trochet'), :saison => saison_2009_2010, :desc => 'kg, + 2Ha Autan'},
  # 
  #   {:name => 'Celtic', :category => Category.find_by_name('desherbant'), :dosage => 2, :unit => 'L/Ha', :date => '2009-10-19', :prix_littre => 0, 
  #   :cout_ha_passage => 0, :cout_fixe => 0, :user => User.find_by_name('Trochet'), :saison => saison_2009_2010, :desc => 'L/Ha, + Iso 2L. sur 3Ha'},
  # 
  #   {:name => 'Harmony', :category => Category.find_by_name('desherbant'), :dosage => 25, :unit => 'L/Ha', :date => '2009-10-19', :prix_littre => 0, 
  #   :cout_ha_passage => 0, :cout_fixe => 0, :user => User.find_by_name('Trochet'), :saison => saison_2009_2010, :desc => 'g, + Picosolo 80g. sur 17Ha'},
  # 
  #   {:name => 'super 45', :category => Category.find_by_name('engrais'), :dosage => 157, :unit => 'L/Ha', :date => '2010-02-04', :prix_littre => 0, 
  #   :cout_ha_passage => 0, :cout_fixe => 0, :user => User.find_by_name('Trochet'), :saison => saison_2009_2010, :desc => 'kg'},
  # 
  #   {:name => 'azote', :category => Category.find_by_name('azote'), :dosage => 210, :unit => 'L/Ha', :date => '2010-02-16', :prix_littre => 0, 
  #   :cout_ha_passage => 0, :cout_fixe => 0, :user => User.find_by_name('Trochet'), :saison => saison_2009_2010, :desc => '210kg, 70u'},
  # 
  #   {:name => 'azote', :category => Category.find_by_name('azote'), :dosage => 206, :unit => 'L/Ha', :date => '2010-03-09', :prix_littre => 0, 
  #   :cout_ha_passage => 0, :cout_fixe => 0, :user => User.find_by_name('Trochet'), :saison => saison_2009_2010, :desc => '200kg, 69u'},
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
  #   :cout_ha_passage => 0, :cout_fixe => 0, :user => User.find_by_name('Trochet'), :saison => saison_2009_2010, :desc => '120kg, 40u'},
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
  #   :cout_ha_passage => 0, :cout_fixe => 0, :user => User.find_by_name('Trochet'), :saison => saison_2009_2010, :desc => 'kg'},
  # 
  #   {:name => 'Celtic + Iso', :category => Category.find_by_name('desherbant'), :dosage => 2, :unit => 'L/Ha', :date => '2009-11-19', :prix_littre => 0, 
  #   :cout_ha_passage => 0, :cout_fixe => 0, :user => User.find_by_name('Trochet'), :saison => saison_2009_2010, :desc => 'L/Ha,Celtic 2L/Ha + Iso 2L/Ha'},
  # 
  #   {:name => 'super 45', :category => Category.find_by_name('engrais'), :dosage => 157, :unit => 'L/Ha', :date => '2010-02-04', :prix_littre => 0, 
  #   :cout_ha_passage => 0, :cout_fixe => 0, :user => User.find_by_name('Trochet'), :saison => saison_2009_2010, :desc => 'kg'},
  # 
  #   {:name => 'azote', :category => Category.find_by_name('azote'), :dosage => 200, :unit => 'L/Ha', :date => '2010-02-16', :prix_littre => 0, 
  #   :cout_ha_passage => 0, :cout_fixe => 0, :user => User.find_by_name('Trochet'), :saison => saison_2009_2010, :desc => '200 kg, 67u'},
  # 
  #   {:name => 'azote', :category => Category.find_by_name('azote'), :dosage => 200, :unit => 'L/Ha', :date => '2010-03-06', :prix_littre => 0, 
  #   :cout_ha_passage => 0, :cout_fixe => 0, :user => User.find_by_name('Trochet'), :saison => saison_2009_2010, :desc => '200 kg, 67u'},
  # 
  #   {:name => 'suplason', :category => Category.find_by_name('desherbant'), :dosage => 1, :unit => 'L/Ha', :date => '2010-04-18', :prix_littre => 0, 
  #   :cout_ha_passage => 0, :cout_fixe => 0, :user => User.find_by_name('Trochet'), :saison => saison_2009_2010, :desc => '+ Storane 0.9L16 ha derriere maison'},
  # 
  #   {:name => 'azote', :category => Category.find_by_name('azote'), :dosage => 120, :unit => 'L/Ha', :date => '2010-05-17', :prix_littre => 0, 
  #   :cout_ha_passage => 0, :cout_fixe => 0, :user => User.find_by_name('Trochet'), :saison => saison_2009_2010, :desc => '120kg, 40u'},
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
  #   :cout_ha_passage => 0, :cout_fixe => 0, :user => User.find_by_name('Trochet'), :saison => saison_2009_2010, :desc => 'kg'},
  # 
  #   {:name => 'Glyphosate', :category => Category.find_by_name('desherbant'), :dosage => 2, :unit => 'L/Ha', :date => '2009-04-14', :prix_littre => 0, 
  #   :cout_ha_passage => 0, :cout_fixe => 0, :user => User.find_by_name('Trochet'), :saison => saison_2009_2010, :desc => 'L/Ha, + huile 1L/Ha'},
  # 
  #   {:name => 'Imperio', :category => Category.find_by_name('semis'), :dosage => 170, :unit => 'L/Ha', :date => '2009-04-10', :prix_littre => 0, 
  #   :cout_ha_passage => 0, :cout_fixe => 0, :user => User.find_by_name('Trochet'), :saison => saison_2009_2010, :desc => 'kg, dosage inconnu'},
  # 
  #   {:name => 'Challenge', :category => Category.find_by_name('desherbant'), :dosage => 3.5, :unit => 'L/Ha', :date => '2009-04-14', :prix_littre => 0, 
  #   :cout_ha_passage => 0, :cout_fixe => 0, :user => User.find_by_name('Trochet'), :saison => saison_2009_2010, :desc => 'L/Ha, + Iso 2L/Ha. Sur tournesol + tour de champs'},
  # 
  #   {:name => 'azote', :category => Category.find_by_name('azote'), :dosage => 107, :unit => 'L/Ha', :date => '2010-06-07', :prix_littre => 0, 
  #   :cout_ha_passage => 0, :cout_fixe => 0, :user => User.find_by_name('Trochet'), :saison => saison_2009_2010, :desc => '107 kg, 35u'}
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









