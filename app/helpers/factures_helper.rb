module FacturesHelper

  def sum_reports_cout(reportable_id)
    reportable = Reportable.find(reportable_id)
    reports = reportable.reports
    total = 0
    reports.each do |report|
      total += report.cout
    end
    
    if total == reportable.cout
      color = 'green'
    else
      color = 'red'
    end
    out = '<td style="color: ' + color + ';">' + total.to_s + ' € | </td>'
    return out
  end
  
  def sum_reports_cout_popup(reportable_id)
    reportable = Reportable.find(reportable_id)
    reports = reportable.reports
    total = 0
    reports.each do |report|
      total += report.cout
    end
    
    if total == reportable.cout
      color = 'green'
    else
      color = 'red'
    end
    out = '<p style="color: ' + color + ';">' + total.to_s + ' €.</p>'
    return out
  end
  
  def link_to_head(col, display)
    link_to_remote  display.to_s,
                    :url => { :action => "list", :order => col.to_s },
                    :update => 'list_facture'

  end


end
