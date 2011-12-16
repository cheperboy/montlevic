# S5011
# abandon des mecanismes labours/labtofacture et pulve/putofacture (mais on conserve pulve/produit/protofacture)
# pour simplifier les modifs on prend les hypotheses suivantes: toutes les factures sont en TOTAL sauf les fac produit qui restent en DIFF
# cette hypothese tue les labours/pulve qui pompent des factures


# Upcategories
cat_pulve = Upcategory.find_by_name('pulve')
cat_facture = Upcategory.find_by_name('facture')
cat_labour = Upcategory.find_by_name('labour')
cat_vente = Upcategory.find_by_name('vente')
cat_diverse = Upcategory.find_by_name('diverse')

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
saison_test = Saison.create!(:name => "Saison Test", :year => "2010")
Setting.find(:first).update_attribute(:saison_id,	saison_test.id )


# PARCELLES
zone = Zone.find_by_code('zone_test_1')
parcelle = Parcelle.create!(:name => 'parcelle - 1', :code => 'parcelle1', :saison => saison_test, :typeculture => ble, :surface => 10)
zonetopa = Zonetopa.create!(:parcelle => parcelle, :zone => zone, :value => parcelle.surface)

zone = Zone.find_by_code('zone_test_2')
parcelle = Parcelle.create!(:name => 'parcelle - 2', :code => 'parcelle2', :saison => saison_test, :typeculture => ble, :surface => 5)
zonetopa = Zonetopa.create!(:parcelle => parcelle, :zone => zone, :value => parcelle.surface)

parcelle = Parcelle.create!(:name => 'parcelle - 3', :code => 'parcelle3', :saison => saison_test, :typeculture => ble, :surface => 5)
zonetopa = Zonetopa.create!(:parcelle => parcelle, :zone => zone, :value => parcelle.surface)



# set variables parcelles cultures
parcelles_ble = []
ble.parcelles.find_by_saison(:all, saison_test).each {|parcelle| parcelles_ble << parcelle}
parcelles_colza = []
colza.parcelles.find_by_saison(:all, saison_test).each {|parcelle| parcelles_colza << parcelle}
parcelles_tournesol = []
tournesol.parcelles.find_by_saison(:all, saison_test).each {|parcelle| parcelles_tournesol << parcelle}
parcelles_foin = []
foin.parcelles.find_by_saison(:all, saison_test).each {|parcelle| parcelles_foin << parcelle}


# PRODUITS - (Generation automatique xls)
p1 = Produit.create!(:name => 'produit - 1', :unit =>'kg', :category => cat_agri_engrais, :saison => saison_test, :desc => '')
# p2 = Produit.create!(:name => 'produit - 2', :unit =>'kg', :category => cat_agri_azote, :saison => saison_test, :desc => '')

# FACTURES - from xls

# fac_service = Debit.create!(:name => 'Fac services agri', :date => '2010-11-30', :cout => 200, :ref_client => '01-2010-1187', :ref => '001', :user => User.find_by_code('dauger'), :factype => factype_total,:factcat => factcat_agri,:category => cat_agri_service_agricole, :desc => '1 sac big bag',:saison => saison_test, :star => 0, :adu => 0)

fac_produit = Debit.create!(:name => 'Facture produit', :date => '2010-11-30', :cout => 100, :ref_client => '01-2010-1187', :ref => '001', :user => User.find_by_code('dauger'), :factype => factype_diff,:factcat => factcat_agri,:category => cat_agri_produits_phyto, :desc => '1 sac big bag',:saison => saison_test, :star => 0, :adu => 0)
protofacture = Protofacture.create!(:facture => fac_produit, :produit => p1, :prix_unit => 1, :quantite => 200, :saison => saison_test)

# protofacture = Protofacture.create!(:facture => fac_produit, :produit => p2, :prix_unit => 1, :quantite => 100, :saison => saison_test)

# facture = Debit.create!(:name => 'Facture - 2', :date => '2010-11-30', :cout => 2000, :ref_client => '01-2010-1187', :ref => '001', :user => User.find_by_code('dauger'), :factype => factype_diff,:factcat => factcat_maison,:category => cat_maison_batiment, :desc => '1 sac big bag',:saison => saison_test, :star => 0, :adu => 0)
# facture = Debit.create!(:name => 'Facture - 3', :date => '2010-11-30', :cout => 1000, :ref_client => '01-2010-1187', :ref => '001', :user => User.find_by_code('dauger'), :factype => factype_diff,:factcat => factcat_invest,:category => cat_invest_materiel, :desc => '1 sac big bag',:saison => saison_test, :star => 0, :adu => 0)

# FIN de FACTURES - from xls


vente = Vente.create!(:name => 'Vente 1', :date => '2011-08-02', :prix => 1000, :ref_client => '', :ref => '007', :user => User.find_by_name('Groupama'),:category => cat_vente_assurance, :desc => '',:saison => saison_test, :star => 0, :adu => 0)
parcelles_ble.each {|p| ventoparcelle = Ventoparcelle.create!(:parcelle => p, :vente => vente)}

# FIN VENTES - from xls


pulves = []
labours = []

pulve1 = Pulve.create!(:name => 'pulve - 1', :cout_ha_passage => 0, :user => trochet, :saison => saison_test, :date => '2011-03-11', :star => 1, :adu => 0, :desc => '')
putoproduit = Putoproduit.create!(:pulve => pulve1, :produit => p1, :dosage => 1, :saison => saison_test)

# pulve2 = Pulve.create!(:name => 'pulve - 2', :cout_ha_passage => 0, :user => trochet, :saison => saison_test, :date => '2011-03-11', :star => 1, :adu => 0, :desc => '')
# putoproduit = Putoproduit.create!(:pulve => pulve2, :produit => p1, :dosage => 1, :saison => saison_test)

# pulves << pulve

# parcelle = saison_test.parcelles.find_by_code('parcelle1')
pulves.each {|pulve| putoparcelle = Putoparcelle.create!(:parcelle => parcelle, :pulve => pulve, :value => 0)}




# NE PAS SUPPRIMER

# positionne correctement le champ value des Putofacture
# ceci ne peut pas etre fait juste apres la creation des pulve car les putoparcelles ne sont pas encore crees
# ATTENTION ceci ecrase l'ensemble des Putofactures
Putofacture.find(:all).each do |putof|
  putof.value = putof.pulve.get_cout_total_passage
  putof.save!
end


# Mise a jour des Stocks
saison_test.update_protofacture_stock
