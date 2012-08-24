module CalculateHelper

  # factures de la categorie cat
  def count_elements_sub_cat_facture(cat)
    saison_id = Setting.find(:first).saison_id
    nfac = 0
    # factures
    nfac += Facture.find_by_saison(:all, :conditions => { :category_id => cat.id}).count
    cat.children.each do |d1|
      puts "\t#{d1.code} : #{Facture.find_by_saison(:all, :conditions => { :category_id => d1.id}).count}"
      nfac += Facture.find_by_saison(:all, :conditions => { :category_id => d1.id}).count
      d1.children.each do |d2|
        puts "\t\t#{d2.code} : #{Facture.find_by_saison(:all, :conditions => { :category_id => d2.id}).count}"
        nfac += Facture.find_by_saison(:all, :conditions => { :category_id => d2.id}).count
        d2.children.each do |d3|
          puts "\t\t\t#{d3.code} : #{Facture.find_by_saison(:all, :conditions => { :category_id => d3.id}).count}"
          nfac += Facture.find_by_saison(:all, :conditions => { :category_id => d3.id}).count
          d3.children.each do |d4|
            puts "\t\t\t\t#{d4.code} : #{Facture.find_by_saison(:all, :conditions => { :category_id => d4.id}).count}"
            nfac += Facture.find_by_saison(:all, :conditions => { :category_id => d4.id}).count
          end
        end
      end
    end
    return (nfac)
  end
  
  def count_elements_sub_cat_vente(cat)
    saison_id = Setting.find(:first).saison_id
    nven = 0
    # factures
    nven += Vente.find_by_saison(:all, :conditions => { :category_id => cat.id}).count
    cat.children.each do |d1|
      puts "\t#{d1.code} : #{Vente.find_by_saison(:all, :conditions => { :category_id => d1.id}).count}"
      nven += Vente.find_by_saison(:all, :conditions => { :category_id => d1.id}).count
      d1.children.each do |d2|
        puts "\t\t#{d2.code} : #{Vente.find_by_saison(:all, :conditions => { :category_id => d2.id}).count}"
        nven += Vente.find_by_saison(:all, :conditions => { :category_id => d2.id}).count
        d2.children.each do |d3|
          puts "\t\t\t#{d3.code} : #{Vente.find_by_saison(:all, :conditions => { :category_id => d3.id}).count}"
          nven += Vente.find_by_saison(:all, :conditions => { :category_id => d3.id}).count
          d3.children.each do |d4|
            puts "\t\t\t\t#{d4.code} : #{Vente.find_by_saison(:all, :conditions => { :category_id => d4.id}).count}"
            nven += Vente.find_by_saison(:all, :conditions => { :category_id => d4.id}).count
          end
        end
      end
    end
    return (nven)
  end
  
  # putoproduits d'une categorie de produit
  def count_elements_cat_produit(cat)
    npu = 0
    saison_id = Setting.find(:first).saison_id
    
    # putoproduits de la categorie cat
    Produit.find_by_saison(:all, :conditions => { :category_id => cat.id}).each do |p| 
      npu += p.putoproduits.count
    end
    
    # putoproduits des sous-categorie de cat
    unless cat.is_childless?
      cat.children.each do |d1|
        Produit.find_by_saison(:all, :conditions => { :category_id => d1.id}).each do |p| 
          npu += p.putoproduits.count
        end
        d1.children.each do |d2|
          Produit.find_by_saison(:all, :conditions => { :category_id => d2.id}).each do |p|
            npu += p.putoproduits.count
          end
          d2.children.each do |d3|
            Produit.find_by_saison(:all, :conditions => { :category_id => d3.id}).each do |p| 
              npu += p.putoproduits.count
            end
            d3.children.each do |d4|
              Produit.find_by_saison(:all, :conditions => { :category_id => d4.id}).each do |p| 
                npu += p.putoproduits.count
              end
            end
          end
        end
      end
    end
    return (npu)
  end
  
  # nombre d'elements (factures, pulves, ...) de la categorie Agricole
  # specifique pour l'affichage actuel
  def count_elements_of_a_cat(cat)
    saison_id = Setting.find(:first).saison_id
    nfac = npu = 0
    # factures
    cat.children.each do |d1|
      nfac += Facture.find_by_saison(:all, :conditions => { :category_id => d1.id}).count
      d1.children.each do |d2|
        # puts "\t#{d2.code} : #{Facture.find_by_saison(:all, :conditions => { :category_id => d2.id}).count}"
        nfac += Facture.find_by_saison(:all, :conditions => { :category_id => d2.id}).count
        d2.children.each do |d3|
          # puts "\t\t#{d3.code} : #{Facture.find_by_saison(:all, :conditions => { :category_id => d3.id}).count}"
          nfac += Facture.find_by_saison(:all, :conditions => { :category_id => d3.id}).count
          d3.children.each do |d4|
            # puts "\t\t\t#{d4.code} : #{Facture.find_by_saison(:all, :conditions => { :category_id => d4.id}).count}"
            nfac += Facture.find_by_saison(:all, :conditions => { :category_id => d4.id}).count
          end
        end
      end
    end
    # produits used seulement si category Agricole (pas pour Maison et Invest)
    if cat.eql?(Category.root_agri)
      pro_cat = Category.root_produit
      # npu += pro_cat.descendants.count
      pro_cat.children.each do |d1|
        Produit.find_by_saison(:all, :conditions => { :category_id => d1.id}).each do |p| 
          npu += p.putoproduits.count
        end
        d1.children.each do |d2|
          Produit.find_by_saison(:all, :conditions => { :category_id => d2.id}).each do |p|
            npu += p.putoproduits.count
          end
          d2.children.each do |d3|
            Produit.find_by_saison(:all, :conditions => { :category_id => d3.id}).each do |p| 
              npu += p.putoproduits.count
            end
            d3.children.each do |d4|
              Produit.find_by_saison(:all, :conditions => { :category_id => d4.id}).each do |p| 
                npu += p.putoproduits.count
              end
            end
          end
        end
      end
    end
    return (nfac+npu)
  end
  
  # construit la somme xls a inserer
  def sum(plage)
    # puts "=SOMME(A#{plage[0]}:A#{plage[1]})"
    "=SOMME(A#{plage[0]}:A#{plage[1]})"
  end
  
  # somme pour category niveau 1 (Agricole, Maison, Invest)
  def xls_sum_cat_facture(line, cat)
    ncat = cat.descendants.count
    ncat += Category.find_by_code("produit").descendants.count if cat.eql?(Category.root_agri)
    nfac = count_elements_of_a_cat(cat)
    lenght = line + ncat + nfac
    plage = [line, lenght]
    return sum(plage)
  end

  # somme pour category niveau 2 et plus (Frais generaux, ...)
  def xls_sum_sub_cat_facture(line, cat)
    ncat = cat.descendants.count
    nfac = count_elements_sub_cat_facture(cat)
    lenght = line + ncat + nfac - 1
    plage = [line, lenght]
    return sum(plage) unless (ncat + nfac).eql?(0)
  end

  # appele une seul fois pour la categorie "Chiffre d'affaire"
  def xls_sum_cat_vente(line)
    cat = Category.root_vente
    return(xls_sum_sub_cat_vente(line, cat))
  end

  # somme pour ventes category niveau 2 et plus
  def xls_sum_sub_cat_vente(line, cat)
    ncat = cat.descendants.count
    nven = count_elements_sub_cat_vente(cat)
    lenght = line + ncat + nven - 1
    plage = [line, lenght]
    return sum(plage) unless (ncat + nven).eql?(0)
  end

  # appele une seul fois pour la categorie "produits utilises"
  # qui comporte tout les putoproduits de la saison
  def xls_sum_cat_produit(line)
    cat = Category.root_produit
    return(xls_sum_sub_cat_produit(line, cat))
  end

  # somme pour category de produits utilises (presente dans le tableau comme faisant partie des factures..)
  def xls_sum_sub_cat_produit(line, cat)
    ncat = cat.descendants.count
    npu = count_elements_cat_produit(cat)
    lenght = line + ncat + npu - 1
    plage = [line, lenght]
    puts "#{cat.code} descendants : #{cat.descendants.count}"
    puts "#{cat.code} npu : #{npu}"
    puts "#{cat.code} ncat : #{ncat}"
    puts "#{cat.code} lenght : #{lenght}"
    return sum(plage) unless (ncat + npu).eql?(0)
  end


end
