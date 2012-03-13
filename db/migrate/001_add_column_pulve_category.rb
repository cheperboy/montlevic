# Cette migration ajoute un champ category aux pulves
# permet de differrencier les pulve qui sont vraiement des traitement de ceux 
# qui sont des utilisation manuelles des produits (traitement des semences par exemple)

# Sur la DB:
# Creation upcategorie pulve qui n'existait pas avant (on avait seulement facture, produit, labour et vente)
# Creation des categories sous la upcat pulve : traitement, manuel.

class AddColumnPulveCategory < ActiveRecord::Migration
  def self.up
    # down
    add_column :pulves, :category_id, :integer

    # Creation upcategory pulve
    new_upcat = Upcategory.new(:name => "pulve")
    new_upcat.save!
    
    # Creation category pulve.traitement, pulve.manuel, pulve.semis
    factcat = Factcat.find_by_code('agri')
    upcategory = Upcategory.find_by_name('pulve')
    new_cat = Category.new(:factcat_id => factcat.id, :upcategory_id => upcategory.id, :name => 'Traitement', :code => 'traitement')
    new_cat.save!
    new_cat = Category.new(:factcat_id => factcat.id, :upcategory_id => upcategory.id, :name => 'Semis', :code => 'semis')
    new_cat.save!
    new_cat = Category.new(:factcat_id => factcat.id, :upcategory_id => upcategory.id, :name => 'Manuel', :code => 'manuel')
    new_cat.save!

    #recherche de la nouvelle category qui va etre affectee a tout les pulves deja enregistres
    category = Category.find_by_upcategory_and_code('pulve', 'traitement')
    Pulve.update_all("category_id	=	#{category.id}" )
    
    # ajout de la contrainte :null => false pour la nouvelle colonne
    change_column :pulves, :category_id, :integer, :null => false
  end

  def self.down
    category = Category.find_by_upcategory_and_code('pulve', 'traitement')
    category.destroy unless category.nil?
    category = Category.find_by_upcategory_and_code('pulve', 'semis')
    category.destroy unless category.nil?
    category = Category.find_by_upcategory_and_code('pulve', 'manuel')
    category.destroy unless category.nil?

    new_upcat = Upcategory.find_by_name("pulve")
    new_upcat.destroy unless new_upcat.nil?
    remove_column :pulves, :category_id
  end
end
