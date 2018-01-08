SCHEDULER.every '120s' do

  sla_buzzwords = ['OAPI', 'TPO EP3', 'TPO EP9', 'NGCR', 'LoConnect']
  sla_buzzword_counts = Hash.new({ value: 0 })

  array_oapi_monthly=0
  array_tpo_ep3_monthly=0
  array_tpo_ep9_monthly=0
  array_NGCR_monthly=0
  array_loconnect_monthly=0
File.open("/home/ubuntu/git/Monitis/java/monitorID_oapi_December.txt", "r") do |f|
   f.each_line do |line|
    array_oapi_monthly=line.to_f
   end
  end

File.open("/home/ubuntu/git/Monitis/java/monitorID_tpo_ep3_December.txt", "r") do |f|
   f.each_line do |line|
    array_tpo_ep3_monthly=line.to_f
   end
  end
File.open("/home/ubuntu/git/Monitis/java/monitorID_tpo_ep9_December.txt", "r") do |f|
   f.each_line do |line|
    array_tpo_ep9_monthly=line.to_f
   end
  end
File.open("/home/ubuntu/git/Monitis/java/monitorID_loconnect_December.txt", "r") do |f|
   f.each_line do |line|
    array_loconnect_monthly=line.to_f
   end
  end
File.open("/home/ubuntu/git/Monitis/java/monitorID_NGCR_December.txt", "r") do |f|
   f.each_line do |line|
    array_NGCR_monthly=line.to_f
   end
  end

  
  sla_buzzword_counts[0] = { label: "OAPI", value: "#{array_oapi_monthly}"}
  sla_buzzword_counts[1] = { label: "TPO EP3", value: "#{array_tpo_ep3_monthly}"}
  sla_buzzword_counts[2] = { label: "TPO EP9", value: "#{array_tpo_ep9_monthly}"}
  sla_buzzword_counts[3] = { label: "NGCR", value: "#{array_NGCR_monthly}"}
  sla_buzzword_counts[4] = { label: "LOC onnect", value: "#{array_loconnect_monthly}"}


  #send_event('tpo_ep3_monthly',   { value: array_tpo_ep3_monthly })
  #send_event('tpo_ep9_monthly',   { value: array_tpo_ep9_monthly })
  #send_event('oapi_monthly',   { value: array_oapi_monthly })
  #send_event('lo_connect_monthly',   { value: array_loconnect_monthly })
  #send_event('ngcr_monthly',   { value: array_NGCR_monthly })
  send_event('monthly_sla_widget', { items: sla_buzzword_counts.values })
end
