
#Saison
saison_2011_2012 = Saison.create!(:name => "2011/2012", :year => "2012")
Setting.find(:first).update_attribute(:saison_id,	saison_2011_2012.id )



#Typecultures
ble = Typeculture.find_by_name("Ble")
tournesol = Typeculture.find_by_name("Tournesol")
colza = Typeculture.find_by_name("Colza")
jachere = Typeculture.find_by_name("Jachere")
luzerne = Typeculture.find_by_name("Luzerne")
foin = Typeculture.find_by_name("Foin")
gel = Typeculture.find_by_code("gel")
trefle = Typeculture.find_by_code("trefle")
miscanthus = Typeculture.find_by_code("miscanthus")
autre = Typeculture.find_by_code("autre")



zone = Zone.find_by_code('bons_pains')
parcelle = Parcelle.create!(:name => 'Bons Pains', :code => 'bons_pains', :saison =>  saison_2011_2012, :typeculture => tournesol, :surface => 14.03, :surface_pac => 14.03)
zonetopa = Zonetopa.create!(:parcelle => parcelle, :zone => zone, :value => parcelle.surface)

zone = Zone.find_by_code('mitant')
parcelle = Parcelle.create!(:name => 'Mitant', :code => 'mitant', :saison =>  saison_2011_2012, :typeculture => tournesol, :surface => 5.1, :surface_pac => 5.1)
zonetopa = Zonetopa.create!(:parcelle => parcelle, :zone => zone, :value => parcelle.surface)

zone = Zone.find_by_code('la_rue')
parcelle = Parcelle.create!(:name => 'etandage', :code => 'etandage', :saison =>  saison_2011_2012, :typeculture => gel, :surface => 0.2, :surface_pac => 0.2)
zonetopa = Zonetopa.create!(:parcelle => parcelle, :zone => zone, :value => parcelle.surface)

zone = Zone.find_by_code('la_rue')
parcelle = Parcelle.create!(:name => 'Pont des champs', :code => 'pont_des_champs', :saison =>  saison_2011_2012, :typeculture => ble, :surface => 10, :surface_pac => 10)
zonetopa = Zonetopa.create!(:parcelle => parcelle, :zone => zone, :value => parcelle.surface)

zone = Zone.find_by_code('la_rue')
parcelle = Parcelle.create!(:name => 'Aeromodelisme', :code => 'aeromodelisme', :saison =>  saison_2011_2012, :typeculture => colza, :surface => 14, :surface_pac => 14)
zonetopa = Zonetopa.create!(:parcelle => parcelle, :zone => zone, :value => parcelle.surface)

zone = Zone.find_by_code('la_rue')
parcelle = Parcelle.create!(:name => 'Derriere', :code => 'derriere', :saison =>  saison_2011_2012, :typeculture => ble, :surface => 12.2, :surface_pac => 12.2)
zonetopa = Zonetopa.create!(:parcelle => parcelle, :zone => zone, :value => parcelle.surface)

zone = Zone.find_by_code('la_rue')
parcelle = Parcelle.create!(:name => 'Champ du Milieu', :code => 'champ_du_milieu', :saison =>  saison_2011_2012, :typeculture => ble, :surface => 10, :surface_pac => 10)
zonetopa = Zonetopa.create!(:parcelle => parcelle, :zone => zone, :value => parcelle.surface)

zone = Zone.find_by_code('vallees')
parcelle = Parcelle.create!(:name => 'Les Vallees', :code => 'vallees', :saison =>  saison_2011_2012, :typeculture => ble, :surface => 11, :surface_pac => 11)
zonetopa = Zonetopa.create!(:parcelle => parcelle, :zone => zone, :value => parcelle.surface)

zone = Zone.find_by_code('vallees')
parcelle = Parcelle.create!(:name => 'Lapins', :code => 'lapins', :saison =>  saison_2011_2012, :typeculture => gel, :surface => 0.4, :surface_pac => 0.4)
zonetopa = Zonetopa.create!(:parcelle => parcelle, :zone => zone, :value => parcelle.surface)

zone = Zone.find_by_code('vallees')
parcelle = Parcelle.create!(:name => 'La Cote', :code => 'cote', :saison =>  saison_2011_2012, :typeculture => luzerne, :surface => 2.3, :surface_pac => 2.3)
zonetopa = Zonetopa.create!(:parcelle => parcelle, :zone => zone, :value => parcelle.surface)

zone = Zone.find_by_code('guiberons')
parcelle = Parcelle.create!(:name => 'Guiberons', :code => 'guiberons', :saison =>  saison_2011_2012, :typeculture => foin, :surface => 3, :surface_pac => 3)
zonetopa = Zonetopa.create!(:parcelle => parcelle, :zone => zone, :value => parcelle.surface)

zone = Zone.find_by_code('feuillets')
parcelle = Parcelle.create!(:name => 'Feuillet-1', :code => 'feuillets_1', :saison =>  saison_2011_2012, :typeculture => luzerne, :surface => 7, :surface_pac => 7)
zonetopa = Zonetopa.create!(:parcelle => parcelle, :zone => zone, :value => parcelle.surface)

zone = Zone.find_by_code('feuillets')
parcelle = Parcelle.create!(:name => 'Feuillet-2', :code => 'feuillets_2', :saison =>  saison_2011_2012, :typeculture => foin, :surface => 4.08, :surface_pac => 4.08)
zonetopa = Zonetopa.create!(:parcelle => parcelle, :zone => zone, :value => parcelle.surface)

zone = Zone.find_by_code('feuillets')
parcelle = Parcelle.create!(:name => 'Feuillet-3', :code => 'feuillets_3', :saison =>  saison_2011_2012, :typeculture => foin, :surface => 5, :surface_pac => 5)
zonetopa = Zonetopa.create!(:parcelle => parcelle, :zone => zone, :value => parcelle.surface)

zone = Zone.find_by_code('brandes')
parcelle = Parcelle.create!(:name => 'Brandes-1', :code => 'brandes_1', :saison =>  saison_2011_2012, :typeculture => foin, :surface => 2.47, :surface_pac => 2.47)
zonetopa = Zonetopa.create!(:parcelle => parcelle, :zone => zone, :value => parcelle.surface)

zone = Zone.find_by_code('brandes')
parcelle = Parcelle.create!(:name => 'Brandes-2', :code => 'brandes_2', :saison =>  saison_2011_2012, :typeculture => miscanthus, :surface => 0.5, :surface_pac => 0.5)
zonetopa = Zonetopa.create!(:parcelle => parcelle, :zone => zone, :value => parcelle.surface)

zone = Zone.find_by_code('taillis')
parcelle = Parcelle.create!(:name => 'Taillis-1', :code => 'taillis_1', :saison =>  saison_2011_2012, :typeculture => foin, :surface => 19.05, :surface_pac => 19.05)
zonetopa = Zonetopa.create!(:parcelle => parcelle, :zone => zone, :value => parcelle.surface)

zone = Zone.find_by_code('taillis')
parcelle = Parcelle.create!(:name => 'Taillis-2', :code => 'taillis_2', :saison =>  saison_2011_2012, :typeculture => miscanthus, :surface => 0.3, :surface_pac => 0.3)
zonetopa = Zonetopa.create!(:parcelle => parcelle, :zone => zone, :value => parcelle.surface)

zone = Zone.find_by_code('varennes')
parcelle = Parcelle.create!(:name => 'Varennes-1', :code => 'varennes_1', :saison =>  saison_2011_2012, :typeculture => foin, :surface => 14.7, :surface_pac => 14.7)
zonetopa = Zonetopa.create!(:parcelle => parcelle, :zone => zone, :value => parcelle.surface)

zone = Zone.find_by_code('varennes')
parcelle = Parcelle.create!(:name => 'Varennes-2', :code => 'varennes_2', :saison =>  saison_2011_2012, :typeculture => miscanthus, :surface => 0.8, :surface_pac => 0.8)
zonetopa = Zonetopa.create!(:parcelle => parcelle, :zone => zone, :value => parcelle.surface)

zone = Zone.find_by_code('varennes')
parcelle = Parcelle.create!(:name => 'Varennes-3', :code => 'varennes_3', :saison =>  saison_2011_2012, :typeculture => gel, :surface => 0.39, :surface_pac => 0.39)
zonetopa = Zonetopa.create!(:parcelle => parcelle, :zone => zone, :value => parcelle.surface)

zone = Zone.find_by_code('patureaux')
parcelle = Parcelle.create!(:name => 'Patureaux', :code => 'patureaux', :saison =>  saison_2011_2012, :typeculture => foin, :surface => 8.88, :surface_pac => 8.88)
zonetopa = Zonetopa.create!(:parcelle => parcelle, :zone => zone, :value => parcelle.surface)

zone = Zone.find_by_code('chevaux')
parcelle = Parcelle.create!(:name => 'Chevaux-1', :code => 'chevaux_1', :saison =>  saison_2011_2012, :typeculture => foin, :surface => 12.26, :surface_pac => 12.26)
zonetopa = Zonetopa.create!(:parcelle => parcelle, :zone => zone, :value => parcelle.surface)

zone = Zone.find_by_code('chevaux')
parcelle = Parcelle.create!(:name => 'Chevaux-2', :code => 'chevaux_2', :saison =>  saison_2011_2012, :typeculture => autre, :surface => 1, :surface_pac => 1)
zonetopa = Zonetopa.create!(:parcelle => parcelle, :zone => zone, :value => parcelle.surface)

zone = Zone.find_by_code('le_bourg')
parcelle = Parcelle.create!(:name => 'Sous Eglise', :code => 'sous_eglise', :saison =>  saison_2011_2012, :typeculture => foin, :surface => 1.35, :surface_pac => 1.35)
zonetopa = Zonetopa.create!(:parcelle => parcelle, :zone => zone, :value => parcelle.surface)

zone = Zone.find_by_code('reserve')
parcelle = Parcelle.create!(:name => 'Basse-cour', :code => 'basse_cour', :saison =>  saison_2011_2012, :typeculture => ble, :surface => 2.35, :surface_pac => 2.55)
zonetopa = Zonetopa.create!(:parcelle => parcelle, :zone => zone, :value => parcelle.surface)

zone = Zone.find_by_code('reserve')
parcelle = Parcelle.create!(:name => 'Reserve', :code => 'reserve', :saison =>  saison_2011_2012, :typeculture => autre, :surface => 0.2, :surface_pac => 0.2)
zonetopa = Zonetopa.create!(:parcelle => parcelle, :zone => zone, :value => parcelle.surface)

zone = Zone.find_by_code('lavernier')
parcelle = Parcelle.create!(:name => 'Lavernier', :code => 'lavernier', :saison =>  saison_2011_2012, :typeculture => foin, :surface => 0.75, :surface_pac => 0.75)
zonetopa = Zonetopa.create!(:parcelle => parcelle, :zone => zone, :value => parcelle.surface)


# set variables parcelles cultures
parcelles_ble = []
ble.parcelles.find_by_saison(:all, saison_2011_2012).each {|parcelle| parcelles_ble << parcelle}
parcelles_colza = []
colza.parcelles.find_by_saison(:all, saison_2011_2012).each {|parcelle| parcelles_colza << parcelle}
parcelles_tournesol = []
tournesol.parcelles.find_by_saison(:all, saison_2011_2012).each {|parcelle| parcelles_tournesol << parcelle}
parcelles_foin = []
foin.parcelles.find_by_saison(:all, saison_2011_2012).each {|parcelle| parcelles_foin << parcelle}
parcelles_cultures = []
ble.parcelles.find_by_saison(:all, saison_2011_2012).each {|parcelle| parcelles_cultures << parcelle}
colza.parcelles.find_by_saison(:all, saison_2011_2012).each {|parcelle| parcelles_cultures << parcelle}
tournesol.parcelles.find_by_saison(:all, saison_2011_2012).each {|parcelle| parcelles_cultures << parcelle}





# NE PAS SUPPRIMER

# positionne correctement le champ value des Putofacture
# cecie ne peut pas etre fait juste apres la creation des pulve car les putoparcelles ne sont pas encore crees
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
saison_2011_2012.update_protofacture_stock
