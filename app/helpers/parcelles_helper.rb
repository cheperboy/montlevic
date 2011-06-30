module ParcellesHelper
  
  def percent_of_zone(parcelle, zone_id)
    zone = Zone.find(zone_id)
    zonetopa = Zonetopa.find_by(zone_id, parcelle.id)
    if zonetopa.nil?
      value = 0
    else
      value = zonetopa.value
    end
    percent = value * 100 / parcelle.surface
    if percent == 100
      color = 'green'
    else
      color = 'red'
    end
    out = '<td style="color: ' + color + ';">' + percent.to_s + ' %</td>'
    return out
  end

end
