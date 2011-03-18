module VerifsHelper

  def color(test)
    if test.result.equal?(false) && test.level.equal?(Verif::HIGH)
      return 'red'
    elsif test.result.equal?(false) && test.level.equal?(Verif::LOW)
      return 'orange'
    elsif test.result.equal?(true)
      return 'green'
    end
  end

end
