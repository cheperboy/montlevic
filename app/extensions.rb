class Hash
  def pretty
    out = "Hash : <br>"
    if(self.class.equal?(Hash))
      self.each do |key, value|
        out+= "#{key} => {"
        out+= value.pretty2(1)
        out+= "<br>"
      end
    else
      out+= self.to_s
    end
    out+= "<br>"
    return out
  end
  
  def pretty2(n)
    dd = "<dd>"
    out=""
    if(self.class.equal?(Hash))
     out+=""
     self.each do |key, value|
        n.times {out += dd}
        out += "#{key} => "
        (n+1).times {out += dd}
        out += "{"
        out += value.pretty3
        #out += value.to_s
        
        (n+1).times {out += dd}
        out += "}"
      end
      n.times {out += dd}
    else
      out += "#{self}"
    end
    out += ""
  end

  def pretty3
    out=""
    if(self.class.equal?(Hash))
      self.each do |key, value|
        out+= "<dd><dd>"
        out += "#{key} => #{value}"
      end
    else
      out += "#{self.to_s}"
    end
    out+= ""
  end
  
end
# END OF CLASS Hash

class Array

  def to_s
    out = ''
    return out if (self.empty? || self.nil?)
    self.each do |c|
      out += c.to_s + ' '
    end
    out
  end

end
# END OF CLASS Array

class Integer

  def almost_eql?(value, threshold = 2)
   ((self - value).abs < threshold)
  end

  def display
    if(self == 0)
      return "-" 
    else
      return self.to_s
    end
  end

end
# END OF CLASS Integer

class Float

  def almost_eql?(value, threshold = 2)
   ((self - value).abs < threshold)
  end

  # redefinition de la methode to_s 
  # avec en argument le nombre de chiffre apres la virgule
  alias_method :orig_to_s, :to_s

  def display(precision = 0)
    return "-" if ((-0.01 < self) && (self < 0.01))
    return self.to_i if (self == self.to_i)
    # return self if precision == 0
    return (sprintf("%.#{precision}f", self))
    # return (self * 10 ** precision).round.to_f / 10 ** precision
  end

  # def to_s(arg = nil)
  #   if arg.nil?
  #     orig_to_s
  #   else
  #     sprintf("%.#{arg}f", self)
  #   end
  # end

  def pretty(val)
    precision = 1
    return "" if (val.equal?(0))
    return "" if (val == 0.0)
    return val.to_i if (val == val.to_i)
    return val if precision == 0
    return (val * 10 ** precision).round.to_f / 10 ** precision
  end
end
# END OF CLASS FLOAT
