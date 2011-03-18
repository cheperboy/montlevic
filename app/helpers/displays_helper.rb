module DisplaysHelper
  
#  def h_to_s(parcelle)
#    out = "debut<br>"
#    if(parcelle.class.equal?(Hash))
#      parcelle.each do |key, value|
#        out+= "#{key} => {"
#        out+= print_value(value, 1)
#        out+= "<br>"
#      end
#    else
#      out+= parcelle
#    end
#    out+= "<br>"
#    return out
#  end
#  def print_value(val, n)
#    dd = "<dd>"
#    out=""
#    if(val.class.equal?(Hash))
#     out+=""
#     val.each do |key, value|
#        n.times {out += dd}
#        out += "#{key} => "
#        (n+1).times {out += dd}
#        out += "{"
#        out += print_value3(value)
#        #out += value.to_s
#        
#        (n+1).times {out += dd}
#        out += "}"
#      end
#      n.times {out += dd}
#    else
#      out += "#{val}"
#    end
#    out += ""
#  end
#
#  def print_value3(val)
#    out=""
#    if(val.class.equal?(Hash))
#      val.each do |key, value|
#        out+= "<dd><dd>"
#        out += "#{key} => #{value}"
#      end
#    else
#      out += "#{val.to_s}"
#    end
#    out+= ""
#  end
#  
#  
#  
#  
#
#  def print_value_new(val, n)
#    dd = "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"
#    out=""
#    if(val.class.equal?(Hash))
#     out+=""
#     val.each do |key, value|
#        n.times {out += dd}
#        out += "#{key} => <br>"
#        (n+1).times {out += dd}
#        out += "{"
#        out += print_value(value, n+1)
#        #out += value.to_s
#        
#        (n+1).times {out += dd}
#        out += "}"
#      end
#      n.times {out += dd}
#    else
#      out += "#{val}"
#    end
#    out += ""
#  end
#  
#  
#  
#  
#  
#  
#  
#  
#  
#  
#  
#  def smy_display(parcelle)
#    out = "debut<br>"
#    if(parcelle.class.equal?(Hash))
#      parcelle.each do |key, value|
#        out+= "#{key} => {"
#        out+= print_value(value)
#        out+= "<br><dd>}<br>"
#      end
#    else
#      out+= parcelle
#    end
#    out+= "<br>"
#    return out
#  end
#
#  def sprint_value(val)
#    out=""
#    if(val.class.equal?(Hash))
#      val.each do |key, value|
#        out += "<br><dd>"
#        out += "#{key} => <br><dd><dd>{"
#        out += print_value2(value)
#        out += "<br><dd><dd>}"
#      end
#    else
#      out += "#{val}"
#    end
#    out += ""
#  end
#
#  def sprint_value2(val)
#    out=""
#    if(val.class.equal?(Hash))
#      val.each do |key, value|
#        out+= "<br><dd><dd>"
#        out += "#{key} => #{value}"
#      end
#    else
#      out += "#{val.to_s}"
#    end
#    out+= ""
#  end

end
