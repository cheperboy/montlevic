module CategoryHelper

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
    out << "<th>Depth</th>"
    out << "<th>Leaf?</th>"
    out << "<th>Factures</th>"
    out << "</tr>"
    Category.roots.each do |root|
      out << "<tr>"
      out << "<td>#{root.name}</td>"
      out << "<td>"
      out <<  link_to_edit(root.class, root.id)
      out << "</td>"
      out << print_td_info(root)
      out << "</tr>"
      root.children.each do |cat|
        out << "<tr>"
        out << "<td>"
        out << indent_cat_name(cat.depth, cat.name)
        out << "</td>"
        out << "<td>"
        out <<  link_to_edit(cat.class, cat.id)
        out << "</td>"
        out << print_td_info(cat)
        out << "</tr>"
        out << print_tree_with_links_recurs(cat)
      end
    end
    out << "</table>"
    return out.to_s
  end

  def print_tree_with_links_recurs(cat)
    out = ""
    if cat.has_children?
      cat.children.each do |cat|
        out << "<tr>"
        out << "<td>"
        out << indent_cat_name(cat.depth, cat.name)
        # <span style='padding-left: #{cat.depth*15}px;'>#{cat.name}</span></td>"
        out << "</td>"
        out << "<td>"
        out <<  link_to_edit(cat.class, cat.id)
        out << "</td>"
        out << print_td_info(cat)
        out << "</tr>"
        out << print_tree_with_links_recurs(cat) if cat.has_children?
      end
    end
    return out
  end

  def print_td_info(cat)
    out = ""
    out << "<td>#{cat.depth}</td>"
    out << "<td>#{cat.is_childless?}</td>"
    out << "<td>#{cat.factures.count}</td>"
    out << "<td>"
    if cat.factures.count>0 && cat.has_children?
		  out << image_tag('img-nok.png')
		else
		  out << image_tag('img-ok.png')
		end
    out << "</td>"
    return out
  end
    

  def space(num)
    out = ""
    num.times do 
      out << "<pre>&nbsp;&nbsp;&nbsp;&nbsp;</pre>"
    end
    out
  end

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
  def select_cat_from_tree(obj, col, root, selected_obj, options = nil)
    select_name = obj + '[' + col.to_s + ']'
    out = "<select name='#{select_name}'>"
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
  def select_cat_from_root(obj, col, root, selected_obj, options = nil)
    select_name = obj + '[' + col.to_s + ']'
    out = "<select name='#{select_name}'>"
    Category.roots.each do |root|
      selected = ''
      selected = 'selected="selected"' if (selected_obj && selected_obj.id && (root.id == selected_obj.id))
      out << "<option value=#{root.id} #{selected}>"
      out << "#{root.name.camelize}</option>"
      out << select_cat_from_root_recurs(root, selected_obj)
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