# Creation du champ nowrite
#   nowrite indique si la categorie est protegee en ecriture car doit etre reconnue par le systeme


class AddNowriteToCategories < ActiveRecord::Migration
  def self.up

    # UNICITE
    add_column :categories, :old_code, :string

    # NOWRITE
    add_column :categories, :nowrite, :integer
    Category.all.each do |c|
      c.nowrite = 0
      if (c.code.eql?('produits_phyto') || c.code.eql?('service_agricole'))
        c.nowrite = 1
      end
      if (c.code.eql?('produits_phyto') || c.code.eql?('service_agricole'))
        c.nowrite = 1
      end
      c.save
    end
  end

  def self.down
    remove_column :categories, :nowrite
    remove_column :categories, :old_code
    say "\tremoved"
  end
end
