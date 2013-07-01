# 01/07/2013
# ajout de colonnes qui permettent la saisie manuelle de donnees 
# pour gestion des remises, independament des Ventes->avoir
# les colonne sont identifiees par prefixe data_ pour 
# ne pas confondre avec les prix calcules depuis les factures/avoirs associes au produit

class AddColumnRemiseToProduits < ActiveRecord::Migration
  def self.up
    add_column :produits, :data_prix_unitaire, :float
    add_column :produits, :data_prix_remise, :float
    add_column :produits, :data_redevance_pol, :float
  end

  def self.down
    remove_column :produits, :data_prix_unitaire
    remove_column :produits, :data_prix_remise
    remove_column :produits, :data_redevance_pol
  end                                           
end                                             
