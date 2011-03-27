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
myuser = Myuser.create(:login => "mat")

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

User.create(:name => "Jouve")
factypes = Factype.create([
{:name => "diff", :display => "diff", :desc => "test desc"},
{:name => "total", :display => "total", :desc => "test desc"},
{:name => "null", :display => "null", :desc => "test desc"}])

