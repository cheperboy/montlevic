module CategoryHelper

  def print_way(cat)    
    out = ""
    if (cat.ancestors.include?(Category.root_facture))
      cat.path(:from_depth => -(cat.depth-2), :to_depth => cat.depth).each{|c| out += ".#{c.code}"}
    else # Produit, Labour, Vente ou Pulve
      cat.path(:from_depth => -(cat.depth-1), :to_depth => cat.depth).each{|c| out += ".#{c.code}"}
    end
    return out
  end

  def print_tree
    out = "<ul>"
    Category.roots.each do |root|
      out << "<li>#{root.name}</li>"
      out << "<ul>"
      root.children.each do |cat|
        out << "<li>#{cat.name} - #{cat.is_maison?}</li>"
        out << print_tree_recurs(cat)
      end
    out << "</ul>"
    end
    out << "</ul>"
  end
  def print_tree_recurs(cat)
    out = ""
    if cat.has_children?
      out = "<ul>"
      cat.children.each do |cat|
        out << "<li>#{cat.name} - #{cat.is_maison?}</li>"
        out << print_tree_recurs(cat) if cat.has_children?
      end
      out << "</ul>"
    end
    return out
  end

  def print_tree_with_links
    out = "<table class=table_data>"
    out << "<tr>"
    out << "<th>Nom</th>"
    out << "<th></th>"
    out << "<th></th>"
    if admin?
      out << "<th>Depth</th>"
      out << "<th>Leaf?</th>"
      out << "<th>Factures</th>"
      out << "<th>Ancestry</th>"
    end
    out << "<th></th>"
    out << "<th></th>"
    out << "</tr>"
    Category.roots.each do |root|
      out << print_tree_with_links_tr(root)
      out << print_tree_with_links_recurs(root)
    end
    out << "</table>"
    return out.to_s
  end
  def print_tree_with_links_recurs(cat)
    out = ""
    if cat.has_children?
      cat.children.each do |cat|
        out << print_tree_with_links_tr(cat)
        out << print_tree_with_links_recurs(cat) if cat.has_children?
      end
    end
    return out
  end
  def print_tree_with_links_tr(cat)
    out = ""
    out << "<tr>"
    out << "<td>" << indent_cat_name(cat.depth, cat.name) << "</td>"
    # out << print_td_info(cat)
    out << "<td>" <<  link_to_show(cat.class, cat.id) << "</td>"
    out << "<td>" <<  link_to_edit(cat.class, cat.id) << "</td>"
    if admin?
      out << "<td>" <<  link_to_delete(cat.class, cat.id) << "</td>"
      out << "<td>#{cat.depth}</td>"
      out << "<td>#{cat.is_childless?}</td>"
      out << "<td>#{cat.factures.count}</td>"
    end
    out << "<td>#{print_way(cat)}</td>"
    out << "<td>"
    if cat.valid_is_not_leaf_has_elements?
		  out << image_tag('img-ok.png')
		else
		  out << image_tag('img-nok.png')
		end
    if cat.factures.count>0 && cat.has_children?
		  out << image_tag('img-nok.png')
		else
		  out << image_tag('img-ok.png')
		end
    out << "</td>"
    out << "</tr>"
    return out
  end
  
  def space(num)
    out = ""
    num.times do 
      out << "<pre>&nbsp;&nbsp;&nbsp;&nbsp;</pre>"
    end
    out
  end

  # select categories dans un <tr> et avec formulaire passe en parametre
  def form_tr_select_cat_from_tree(form, obj, root, name, col, id, display_name, selected_obj, *args)
    options = args.extract_options!
    out = ''
    out += '<tr><td class="label">'
    out += form.label col.to_sym, name
    out += ' : </td>'
    out += '<td class="field">'
    out += select_cat_from_tree(obj, col, root, selected_obj, options)
    out += '</td></tr>'
    return out
  end
  
  # select categories sans <tr> sans form
  def tag_select_cat_from_tree(obj,     root,                   col,          id, display_name, selected_obj, *args)
    options = args.extract_options!
    out = ''
    out += select_cat_from_tree_for_tag(obj, col, root, selected_obj, options)
    return out
  end
  def select_cat_from_tree_for_tag(obj, col, root, selected_obj, *args)
    options = args.extract_options!
    select_name = obj.class.to_s.downcase + '[' + col.to_s + ']'
    call = '"' + update_category(obj, 'facture') + '"'
    out = "<select name='#{select_name}' id='element_cat' onchange=#{call}>"
    out << select_cat_from_tree_recurs(root, selected_obj)
    out << "</select>"
  end
  
  #TODO cette fonction doit etre remise a sa forme initiale: supprimer l'appel 'update_category'
  def select_cat_from_tree(obj, col, root, selected_obj, *args)
    options = args.extract_options!
    select_name = obj + '[' + col.to_s + ']'
    out = "<select name='#{select_name}' onchange => update_category('#{obj}', facture)>"
    out << select_cat_from_tree_recurs(root, selected_obj)
    out << "</select>"
  end
  def select_cat_from_tree_recurs(root, selected_obj)
    to_select = false
    selected = "notselected"
    out = ""
    root.children.each do |cat|
      selected = ''
      if (selected_obj && selected_obj.category_id && (cat.id == selected_obj.category_id))
        selected = 'selected="selected"'
      end
      if cat.is_childless?
        out << "<option  value=#{cat.id} #{selected}>"
        out << space(cat.depth)
        out << "#{cat.name}</option>"
      else
        out << "<option disabled='disabled'>"
        out << space(cat.depth)
        out << "#{cat.name}</option>"
        out << select_cat_from_tree_recurs(cat, selected_obj)
      end
    end
    out
  end

  def form_tr_select_cat_from_root(form, obj, root, name, col, id, display_name, selected_obj, *args)
    options = args.extract_options!
    out = ''
    out += '<tr><td class="label">'
    out += form.label col.to_sym, name
    out += ' : </td>'
    out += '<td class="field">'
    out += select_cat_from_root(obj, col, root, selected_obj, options)
    out += '</td></tr>'
    return out
  end
  def select_cat_from_root(obj, col, roots, selected_obj, options = nil)
    select_name = obj + '[' + col.to_s + ']'
    out = "<select name='#{select_name}'>"
    # si une seule categorie est passe en parametre
    if roots.class.eql?(Category)
      root = roots
      selected = ''
      selected = 'selected="selected"' if (selected_obj && selected_obj.id && (root.id == selected_obj.id))
      out << "<option value=#{root.id} #{selected}>"
      out << "#{root.name.camelize}</option>"
      out << select_cat_from_root_recurs(root, selected_obj)
      # si plusieurs categories sont passees en parametre
    else
      roots.each do |root|
        selected = ''
        selected = 'selected="selected"' if (selected_obj && selected_obj.id && (root.id == selected_obj.id))
        out << "<option value=#{root.id} #{selected}>"
        out << "#{root.name.camelize}</option>"
        out << select_cat_from_root_recurs(root, selected_obj)
      end
    end
    out << "</select>"
  end
  def select_cat_from_root_recurs(upcat, selected_obj)
    out = ""
    upcat.children.each do |cat|
      selected = ''
      selected = 'selected="selected"' if (selected_obj && selected_obj.id && (cat.id == selected_obj.id))
      out << "<option  value=#{cat.id} #{selected}>"
      out << space(cat.depth)
      out << "#{cat.name}</option>"
      out << select_cat_from_root_recurs(cat, selected_obj) if cat.has_children?
    end
    out
  end
  
end