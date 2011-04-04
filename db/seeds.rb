# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#

Upcategory.delete_all
Category.delete_all
upcategories = Upcategory.create([{ :name => 'facture'}, 
{ :name => 'pulve' }, 
{ :name => 'labour' },
{ :name => 'vente' },
{ :name => 'diverse' }])

pulve = Upcategory.find_by_name('pulve')
facture = Upcategory.find_by_name('facture')
labour = Upcategory.find_by_name('labour')
vente = Upcategory.find_by_name('vente')
diverse = Upcategory.find_by_name('diverse')

categories = Category.create([
{ :name => 'agri', :upcategory => facture}, 
{ :name => 'maison', :upcategory => facture }, 
{ :name => 'investissement', :upcategory => facture },
{ :name => 'fongicide', :upcategory => pulve },
{ :name => 'herbicide', :upcategory => pulve },
{ :name => 'glyphosate', :upcategory => pulve },
{ :name => 'test', :upcategory => pulve },
{ :name => 'covercrop', :upcategory => labour },
{ :name => 'vibro', :upcategory => labour },
{ :name => 'foin', :upcategory => vente },
{ :name => 'PAC', :upcategory => vente },
{ :name => 'Avoir', :upcategory => vente },
{ :name => 'essence voiture', :upcategory => diverse },
{ :name => 'bricolage', :upcategory => diverse },
{ :name => 'autres', :upcategory => diverse }])

saison = Saison.create(:name => "Saison-install")
setting = Setting.create( :saison => saison, :value_parcelle => false, :detail_desc => false, :detail_ref => false)

typecultures = Typeculture.create([
{:name => "Ble"},
{:name => "2eme Ble"}, 
{:name => "Colza"},
{:name => "RayGrass"},
{:name => "Jachere"}])

zone = Zone.create(:name => "zone-install", :surface => 1)

parcelle = Parcelle.create(
  :name => "parcelle-install", 
  :saison => saison, 
  :typeculture => Typeculture.find(:first), 
  :surface => 1)

zonetopa = Zonetopa.create(:parcelle => parcelle, :zone => zone, :value => 1)

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
{:name => "Bricomarche"}
])

myuser = Myuser.create([
{:login => "admin",:password => "admin", :admin => true},
{:login => "matthieu", :admin => false},
{:login => "elisabeth", :admin => false},
{:login => "thierry", :admin => false}
])

#===== TESTING DATA ========

saison = Saison.create(:name => "Saison 2")
parcelle = Parcelle.create(
  :saison => saison, 
  :name => "parcelle-2", 
  :typeculture => Typeculture.find(:first), 
  :surface => 10)
  
zonetopa = Zonetopa.create(:parcelle => parcelle, :zone => zone, :value => 10)

factureA = Debit.create(:name => 'Debit 1', 
                          :cout => 1000, 
                          :user => User.find(:first),
                          :factype => Factype.find_by_name("diff"),
                          :saison => saison,
                          :date => '2011-01-01',
                          :desc => "from seeds",
                          :category => Category.find_by_name('agri'))

factureB = Debit.create(:name => 'Debit 2', 
                          :cout => 1000, 
                          :user => User.find(:first),
                          :factype => Factype.find_by_name("diff"),
                          :saison => saison,
                          :date => '2011-01-01',
                          :desc => "from seeds",
                          :category => Category.find_by_name('agri'))

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
                      
                      
                      