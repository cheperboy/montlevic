# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#   
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Major.create(:name => 'Daley', :city => cities.first)
Upcategory.delete_all
Category.delete_all
upcategories = Upcategory.create([{ :name => 'facture'}, 
{ :name => 'pulve' }, 
{ :name => 'labour' }])

pulve = Upcategory.find_by_name('pulve')
facture = Upcategory.find_by_name('facture')
labour = Upcategory.find_by_name('labour')

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
{ :name => 'avoir', :upcategory => vente },
{ :name => 'essence voiture', :upcategory => diverse },
{ :name => 'bricolage', :upcategory => diverse },
{ :name => 'autres', :upcategory => diverse }])
