# Maintenance: les category.codes ne sont pas unique 
#   Verification de l'unicite et modification du code si besoin
# Creation du champ nowrite
#   nowrite indique si la categorie est protegee en ecriture car doit etre reconnue par le systeme


class AddNowriteToCategories < ActiveRecord::Migration
  def self.up

    # UNICITE
    # add_column :categories, :old_code, :string
    Category.all.each do |c|
      unless c.valid?
        if c.errors[:code]
          c.old_code = c.code
          new_code = "#{c.parent.code}.#{c.code}"
          c.code = new_code
          if c.valid?
            c.save!
          else
            say "#{c.code}"
            c.errors.each {|e| say "\t#{e.inspect}"}
          end
        end
      end
      c.save
    end
    

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
    # remove_column :categories, :nowrite
    # remove_column :categories, :old_code
    say "\tremoved"
  end
end
