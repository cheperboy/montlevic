module CategoryHelper

  def print_tree
    out = "<ul>"
    Category.roots.each do |root|
      out += "<li>#{root.name}</li>"
      out += "<ul>"
      root.children.each do |cat|
        out += "<li>#{cat.name}</li>"
        out += print_tree_recurs(cat)
      end
    out += "</ul>"
    end
    out += "</ul>"
  end

  def print_tree_recurs(cat)
    out = ""
    if cat.has_children?
      out = "<ul>"
      cat.children.each do |cat|
        out += "<li>#{cat.name}</li>"
        out += print_tree_recurs(cat) if cat.has_children?
      end
      out += "</ul>"
    end
    return out
  end

  def space(num)
    out = ""
    num.times do 
      out << "<pre>&nbsp;&nbsp;&nbsp;&nbsp;</pre>"
    end
    out
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
        out += space(cat.depth)
        out += "#{cat.name}</option>"
      else
        out << "<option disabled='disabled'>"
        out << space(cat.depth)
        out << "#{cat.name}</option>"
        out << select_cat_from_tree_recurs(cat, selected_obj)
      end
    end
    out
  end
  
  def select_cat_from_tree(obj, col, root, selected_obj)
    select_name = obj + '[' + col.to_s + ']'
    out = "<select name='#{select_name}'>"
    out << select_cat_from_tree_recurs(root, selected_obj)
    out << "</select>"
  end
    
  def form_tr_select_cat_from_tree(form, obj, root, name, col, id, display_name, selected_obj, options = nil)
    out = ''
    out += '<tr><td class="label">'
    out += form.label col.to_sym, name
    out += ' : </td>'
    out += '<td class="field">'
    unless options.nil?
      out += select_cat_from_tree(obj, col, root, selected_obj)
    else
      out += select_cat_from_tree(obj, col, root, selected_obj)
    end
    out += '</td></tr>'
    return out
  end

    
end