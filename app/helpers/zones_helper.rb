module ZonesHelper

  def td_with_color(value, compare)
    if value == compare
      color = 'green'
    else
      color = 'red'
    end
    out = '<td style="color: ' + color + ';">' + value.to_s(2) + ' %</td>' 
  end  
  
  def percent_of_parcelle(zone, parcelle_id, col)
    parcelle = Parcelle.find(parcelle_id)
    zonetopa = Zonetopa.find_by(zone.id, parcelle_id)
    if zonetopa.nil?
      value = 0
    else
      value = zonetopa.value
    end
    percent = value * 100 / zone.surface
    if col
      color = 'black'
    else
      if percent == 100
        color = 'green'
      else
        color = 'red'
      end
    end
    out = '<td style="color: ' + color + ';">' + percent.to_s(2) + ' %</td>'
    return out
  end

  def percent_of_parcelle_value(zone, parcelle_id)
    parcelle = Parcelle.find(parcelle_id)
    zonetopa = Zonetopa.find_by(zone.id, parcelle_id)
    if zonetopa.nil?
      value = 0
    else
      value = zonetopa.value
    end
    percent = value * 100 / zone.surface
  end

end
