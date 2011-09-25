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

  def display(*args)
    precision = args[1]
    options = args.extract_options!
    
    if (self.eql?(0))
      unless options[:with_zero]
        return "-"
      end 
    end
    if precision.nil?
      precision = Setting::FLOAT_PRECISION
    end
    return (sprintf("%.#{precision}f", self.to_f))
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
  #affiche un float avec options
  # Options:
  # - display() : precision choisie dans Settings, '-' si valeure = 0,0
  # - display(:with_zero => true) : '0.0' si valeure = 0,0
  # - display(2) : 2 chiffres apres la virgule, ecrase les Settings
  # - display(2, :with_zero => true) : 2 chiffres apres la virgule, ecrase les Settings et 0.0 si valeur=0
  def display(*args)
    # Rails.logger.error "Setting::FLOAT_PRECISION: #{Setting::FLOAT_PRECISION.to_s}"
    options = args.extract_options!
    precision = Setting::FLOAT_PRECISION
    precision = args[0] unless args[0].nil?
    if ((-0.01 < self) && (self < 0.01))
      if options[:with_zero]
        return (sprintf("%.#{precision}f", self.to_f))
      else
        return "-"
      end 
    end
    return (sprintf("%.#{precision}f", self.to_f))
  end

  def to_s(arg = nil)
    if arg.nil?
      orig_to_s
    else
      sprintf("%.#{arg}f", self)
    end
  end

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
