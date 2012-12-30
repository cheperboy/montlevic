# Attention 
# Typeculture.find_by_name("Ble") ne prend pas en compte la saison 


#Saison
saison_2013 = Saison.create!(:name => "2012/2013", :year => "2013")
Setting.find(:first).update_attribute(:saison_id,	saison_2013.id)

#Type de cultures
ble        = Typeculture.find_by_name("Ble")
tournesol  = Typeculture.find_by_name("Tournesol")
colza      = Typeculture.find_by_name("Colza")
jachere    = Typeculture.find_by_name("Jachere")
luzerne    = Typeculture.find_by_name("Luzerne")
foin       = Typeculture.find_by_name("Foin")
gel        = Typeculture.find_by_code("gel")
trefle     = Typeculture.find_by_code("trefle")
miscanthus = Typeculture.find_by_code("miscanthus")
autre      = Typeculture.find_by_code("autre")
prairie    = Typeculture.find_by_code("prairie")

# Parcelles
zone = Zone.find_by_code('bons_pains')
parcelle = Parcelle.create!(:name => 'Bons Pains', :code => 'bons_pains', :saison =>  saison_2013, :typeculture => ble, :surface => 14.03, :surface_pac => 14.03)
zonetopa = Zonetopa.create!(:parcelle => parcelle, :zone => zone, :value => parcelle.surface)

zone = Zone.find_by_code('mitant')
parcelle = Parcelle.create!(:name => 'Mitant', :code => 'mitant', :saison =>  saison_2013, :typeculture => ble, :surface => 5.1, :surface_pac => 5.1)
zonetopa = Zonetopa.create!(:parcelle => parcelle, :zone => zone, :value => parcelle.surface)

zone = Zone.find_by_code('la_rue')
parcelle = Parcelle.create!(:name => 'Pont des champs', :code => 'pont_des_champs', :saison =>  saison_2013, :typeculture => colza, :surface => 10, :surface_pac => 10)
zonetopa = Zonetopa.create!(:parcelle => parcelle, :zone => zone, :value => parcelle.surface)

zone = Zone.find_by_code('la_rue')
parcelle = Parcelle.create!(:name => 'Aeromodelisme', :code => 'aeromodelisme', :saison =>  saison_2013, :typeculture => ble, :surface => 13.5, :surface_pac => 13.5)
zonetopa = Zonetopa.create!(:parcelle => parcelle, :zone => zone, :value => parcelle.surface)

zone = Zone.find_by_code('la_rue')
parcelle = Parcelle.create!(:name => 'Derriere', :code => 'derriere', :saison =>  saison_2013, :typeculture => tournesol, :surface => 13.5, :surface_pac => 13.5)
zonetopa = Zonetopa.create!(:parcelle => parcelle, :zone => zone, :value => parcelle.surface)

zone = Zone.find_by_code('la_rue')
parcelle = Parcelle.create!(:name => 'Champ du Milieu', :code => 'champ_du_milieu', :saison =>  saison_2013, :typeculture => colza, :surface => 9.5, :surface_pac => 9.5)
zonetopa = Zonetopa.create!(:parcelle => parcelle, :zone => zone, :value => parcelle.surface)

zone = Zone.find_by_code('vallees')
parcelle = Parcelle.create!(:name => 'Les Vallees', :code => 'vallees', :saison =>  saison_2013, :typeculture => colza, :surface => 11, :surface_pac => 11)
zonetopa = Zonetopa.create!(:parcelle => parcelle, :zone => zone, :value => parcelle.surface)

zone = Zone.find_by_code('vallees')
parcelle = Parcelle.create!(:name => 'La Cote', :code => 'cote', :saison =>  saison_2013, :typeculture => luzerne, :surface => 1.9, :surface_pac => 1.9)
zonetopa = Zonetopa.create!(:parcelle => parcelle, :zone => zone, :value => parcelle.surface)

zone = Zone.find_by_code('guiberons')
parcelle = Parcelle.create!(:name => 'Guiberons', :code => 'guiberons', :saison =>  saison_2013, :typeculture => prairie, :surface => 2.5, :surface_pac => 2.5)
zonetopa = Zonetopa.create!(:parcelle => parcelle, :zone => zone, :value => parcelle.surface)

zone = Zone.find_by_code('feuillets')
parcelle = Parcelle.create!(:name => 'Feuillets etang', :code => 'Feuillets_etang', :saison =>  saison_2013, :typeculture => prairie, :surface => 7, :surface_pac => 7)
zonetopa = Zonetopa.create!(:parcelle => parcelle, :zone => zone, :value => parcelle.surface)

zone = Zone.find_by_code('feuillets')
parcelle = Parcelle.create!(:name => 'Feuillets milieu', :code => 'Feuillets_milieu', :saison =>  saison_2013, :typeculture => ble, :surface => 4.08, :surface_pac => 4.08)
zonetopa = Zonetopa.create!(:parcelle => parcelle, :zone => zone, :value => parcelle.surface)

zone = Zone.find_by_code('feuillets')
parcelle = Parcelle.create!(:name => 'Feuillets route', :code => 'Feuillets_route', :saison =>  saison_2013, :typeculture => prairie, :surface => 5, :surface_pac => 5)
zonetopa = Zonetopa.create!(:parcelle => parcelle, :zone => zone, :value => parcelle.surface)

zone = Zone.find_by_code('brandes')
parcelle = Parcelle.create!(:name => 'brandes_misc', :code => 'brandes_misc', :saison =>  saison_2013, :typeculture => miscanthus, :surface => 0.3, :surface_pac => 0.3)
zonetopa = Zonetopa.create!(:parcelle => parcelle, :zone => zone, :value => parcelle.surface)

zone = Zone.find_by_code('brandes')
parcelle = Parcelle.create!(:name => 'Brandes', :code => 'brandes', :saison =>  saison_2013, :typeculture => prairie, :surface => 2.67, :surface_pac => 2.67)
zonetopa = Zonetopa.create!(:parcelle => parcelle, :zone => zone, :value => parcelle.surface)

zone = Zone.find_by_code('taillis')
parcelle = Parcelle.create!(:name => 'Taillis gauche', :code => 'taillis_gauche', :saison =>  saison_2013, :typeculture => ble, :surface => 11.5, :surface_pac => 11.5)
zonetopa = Zonetopa.create!(:parcelle => parcelle, :zone => zone, :value => parcelle.surface)

zone = Zone.find_by_code('taillis')
parcelle = Parcelle.create!(:name => 'Taillis droite', :code => 'taillis_droite', :saison =>  saison_2013, :typeculture => prairie, :surface => 5.5, :surface_pac => 5.5)
zonetopa = Zonetopa.create!(:parcelle => parcelle, :zone => zone, :value => parcelle.surface)

zone = Zone.find_by_code('taillis')
parcelle = Parcelle.create!(:name => 'Guyot', :code => 'guyot', :saison =>  saison_2013, :typeculture => prairie, :surface => 1.76, :surface_pac => 1.76)
zonetopa = Zonetopa.create!(:parcelle => parcelle, :zone => zone, :value => parcelle.surface)

zone = Zone.find_by_code('varennes')
parcelle = Parcelle.create!(:name => 'Chevaux', :code => 'chevaux', :saison =>  saison_2013, :typeculture => prairie, :surface => 1.2, :surface_pac => 1.2)
zonetopa = Zonetopa.create!(:parcelle => parcelle, :zone => zone, :value => parcelle.surface)

zone = Zone.find_by_code('varennes')
parcelle = Parcelle.create!(:name => 'Chevaux-misc', :code => 'chevaux_misc', :saison =>  saison_2013, :typeculture => miscanthus, :surface => 3, :surface_pac => 3)
zonetopa = Zonetopa.create!(:parcelle => parcelle, :zone => zone, :value => parcelle.surface)

zone = Zone.find_by_code('varennes')
parcelle = Parcelle.create!(:name => 'virage', :code => 'virage', :saison =>  saison_2013, :typeculture => prairie, :surface => 3.2, :surface_pac => 3.2)
zonetopa = Zonetopa.create!(:parcelle => parcelle, :zone => zone, :value => parcelle.surface)

zone = Zone.find_by_code('varennes')
parcelle = Parcelle.create!(:name => 'varennes', :code => 'varennes', :saison =>  saison_2013, :typeculture => prairie, :surface => 7.4, :surface_pac => 7.4)
zonetopa = Zonetopa.create!(:parcelle => parcelle, :zone => zone, :value => parcelle.surface)

zone = Zone.find_by_code('varennes')
parcelle = Parcelle.create!(:name => 'varennes-misc', :code => 'varennes_misc', :saison =>  saison_2013, :typeculture => miscanthus, :surface => 1, :surface_pac => 1)
zonetopa = Zonetopa.create!(:parcelle => parcelle, :zone => zone, :value => parcelle.surface)

zone = Zone.find_by_code('patureaux')
parcelle = Parcelle.create!(:name => 'Patureaux', :code => 'patureaux', :saison =>  saison_2013, :typeculture => ble, :surface => 7, :surface_pac => 7)
zonetopa = Zonetopa.create!(:parcelle => parcelle, :zone => zone, :value => parcelle.surface)

zone = Zone.find_by_code('prairies')
parcelle = Parcelle.create!(:name => 'Les Prairies', :code => 'prairies', :saison =>  saison_2013, :typeculture => prairie, :surface => 12.2, :surface_pac => 12.2)
zonetopa = Zonetopa.create!(:parcelle => parcelle, :zone => zone, :value => parcelle.surface)

zone = Zone.find_by_code('le_bourg')
parcelle = Parcelle.create!(:name => 'Le Bourg', :code => 'le_bourg', :saison =>  saison_2013, :typeculture => prairie, :surface => 1.36, :surface_pac => 1.36)
zonetopa = Zonetopa.create!(:parcelle => parcelle, :zone => zone, :value => parcelle.surface)

zone = Zone.find_by_code('reserve')
parcelle = Parcelle.create!(:name => 'reserve', :code => 'reserve', :saison =>  saison_2013, :typeculture => tournesol, :surface => 2.1, :surface_pac => 2.1)
zonetopa = Zonetopa.create!(:parcelle => parcelle, :zone => zone, :value => parcelle.surface)

zone = Zone.find_by_code('lavernier')
parcelle = Parcelle.create!(:name => 'Lavernier', :code => 'lavernier', :saison =>  saison_2013, :typeculture => prairie, :surface => 0.75, :surface_pac => 0.75)
zonetopa = Zonetopa.create!(:parcelle => parcelle, :zone => zone, :value => parcelle.surface)



# set variables parcelles cultures
parcelles_ble = []
ble.parcelles.find_by_saison(:all, saison_2013).each {|parcelle| parcelles_ble << parcelle}
parcelles_colza = []
colza.parcelles.find_by_saison(:all, saison_2013).each {|parcelle| parcelles_colza << parcelle}
parcelles_tournesol = []
tournesol.parcelles.find_by_saison(:all, saison_2013).each {|parcelle| parcelles_tournesol << parcelle}
parcelles_foin = []
foin.parcelles.find_by_saison(:all, saison_2013).each {|parcelle| parcelles_foin << parcelle}
parcelles_cultures = []
ble.parcelles.find_by_saison(:all, saison_2013).each {|parcelle| parcelles_cultures << parcelle}
colza.parcelles.find_by_saison(:all, saison_2013).each {|parcelle| parcelles_cultures << parcelle}
tournesol.parcelles.find_by_saison(:all, saison_2013).each {|parcelle| parcelles_cultures << parcelle}

# verification: sum des surfaces
s = parcelles_ble.sum { |p| p.surface }
puts "parcelles_ble : #{s} ha"
s = parcelles_colza.sum { |p| p.surface }
puts "parcelles_colza : #{s} ha"
s = parcelles_tournesol.sum { |p| p.surface }
puts "parcelles_tournesol : #{s} ha"


# NE PAS SUPPRIMER

# positionne correctement le champ value des Putofacture
# ceci ne peut pas etre fait juste apres la creation des pulve car les putoparcelles ne sont pas encore crees
# ATTENTION ceci ecrase l'ensemble des Putofactures
Putofacture.find(:all).each do |putof|
  putof.value = putof.pulve.get_cout_total_passage
  putof.save!
end

#positionne les champs 'facture.paye, 'facture.reglement', 'facture.tva'
Facture.find(:all).each do |f|
  f.paye = Application::DEFAULT
  f.tva = Application::DEFAULT
  f.reglement = Application::DEFAULT
  f.save!
end


# Mise a jour des Stocks
saison_2013.update_protofacture_stock
