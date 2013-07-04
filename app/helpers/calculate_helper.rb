module CalculateHelper

  # genere les colonne necesaires pour decaler chaque categorie en fonction de sa depth
  def generate_columns_for_export(cat, ofset, indent)
    out = ""
    # (cat.depth - 2).times do 
    1.times do 
      out << "#{indent}%td.col2"
    end
    return out
  end
# ----------- fonctions calcul nombres d'elements pour export --------------
# calculs faits en recurs: peuvent etre simplifies en utilisant cat.descendants.each {|d| d.count_elements }

  def count_elements_recurs(cat, klass)
    sum = 0
    cat.children.each do |sub_cat|
      sum += klass.find_by_saison(:all, :conditions => { :category_id => sub_cat.id}).count
      sum += count_elements_recurs(sub_cat, klass) if sub_cat.has_children?
    end
    return sum
  end
  
  # factures de la categorie cat
  def count_elements_sub_cat_facture(cat)
    sum = 0
    # factures
    sum += Facture.find_by_saison(:all, :conditions => { :category_id => cat.id}).count
    if cat.has_children?
       sum += count_elements_recurs(cat, Facture)
    end
    return (sum)
  end

  def count_elements_sub_cat_vente(cat)
    saison_id = session[:current_saison_id]
    sum = 0
    # factures
    sum += Vente.find_by_saison(:all, :conditions => { :category_id => cat.id}).count
    if cat.has_children?
       sum += count_elements_recurs(cat, Vente)
    end
    return (sum)
  end

  def count_putoproduit_sub_cat_recurs(cat)
    sum = 0
    if cat.has_children?
      cat.children.each do |sub_cat|
        Produit.find_by_saison(:all, :conditions => { :category_id => sub_cat.id}).each do |p| 
          sum += p.putoproduits.count
        end
        sum += count_putoproduit_sub_cat_recurs(sub_cat)
      end
    end
    return (sum)
  end

  # putoproduits d'une categorie de produit
  def count_elements_cat_produit(cat)
    sum = 0
    # putoproduits de la categorie cat
    Produit.find_by_saison(:all, :conditions => { :category_id => cat.id}).each do |p| 
      sum += p.putoproduits.count
    end
        
    # putoproduits des sous-categorie de cat
    if cat.has_children?
       sum += count_putoproduit_sub_cat_recurs(cat)
    end
    return (sum)
  end
  
  # nombre d'elements (factures, pulves, ...) de la categorie Agricole, Maison ou Invest
  # specifique pour l'affichage actuel
  def count_elements_of_a_cat(cat)
    saison_id = session[:current_saison_id]
    nfac = npu = 0
    # factures
    if cat.has_children?
       nfac += count_elements_recurs(cat, Facture)
    end
    if cat.eql?(Category.root_agri)
      pro_cat = Category.root_produit
      npu += count_putoproduit_sub_cat_recurs(Category.root_produit)
    end
    return (nfac+npu)
  end
  
  # construit la somme xls a inserer
  def sum(plage)
    # puts "=SOMME(A#{plage[0]}:A#{plage[1]})"
    "=SOMME(A#{plage[0]}:A#{plage[1]})"
  end
  
  # somme pour category niveau 1 (Agricole, Maison, Invest)
  def xls_sum_cat_level1_facture(line, cat)
    ncat = cat.descendants.count
    ncat += Category.find_by_code("produit").descendants.count if cat.eql?(Category.root_agri)
    # correction car plage trop longue d'une ligne pour Invest et Maison
    # le -1 est soustrait pour la cat Agri sans doute via l'appel a count_elements_of_a_cat (?)
    ncat -= 1 unless cat.eql?(Category.root_agri)
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
    return(xls_sum_sub_cat_produit(line, Category.root_produit))
  end

  # somme pour category de produits utilises (presente dans le tableau comme faisant partie des factures..)
  def xls_sum_sub_cat_produit(line, cat)
    ncat = cat.descendants.count
    npu = count_elements_cat_produit(cat)
    lenght = line + ncat + npu - 1
    plage = [line, lenght]
    # puts "#{cat.code} descendants : #{cat.descendants.count}"
    # puts "#{cat.code} npu : #{npu}"
    # puts "#{cat.code} ncat : #{ncat}"
    # puts "#{cat.code} lenght : #{lenght}"
    return sum(plage) unless (ncat + npu).eql?(0)
  end

  def xls_sum_sub_cat_produit_old(line, cat)
    ncat = cat.descendants.count
    npu = count_elements_cat_produit(cat)
    lenght = line + ncat + npu - 1
    plage = [line, lenght]
    # puts "#{cat.code} descendants : #{cat.descendants.count}"
    # puts "#{cat.code} npu : #{npu}"
    # puts "#{cat.code} ncat : #{ncat}"
    # puts "#{cat.code} lenght : #{lenght}"
    return sum(plage) unless (ncat + npu).eql?(0)
  end
end
