
SCHEDULER.every '20s' do

array_oapi=0
array_tpo_ep3=0
array_tpo_ep9=0
array_NGCR=0
array_loconnect=0
File.open("/home/ubuntu/git/Monitis/java/monitorID_oapi.txt", "r") do |f|
   f.each_line do |line|
    array_oapi=line.to_f
   end
  end

File.open("/home/ubuntu/git/Monitis/java/monitorID_tpo_ep3.txt", "r") do |f|
   f.each_line do |line|
    array_tpo_ep3=line.to_f
   end
  end
File.open("/home/ubuntu/git/Monitis/java/monitorID_tpo_ep9.txt", "r") do |f|
   f.each_line do |line|
    array_tpo_ep9=line.to_f
   end
  end
File.open("/home/ubuntu/git/Monitis/java/monitorID_loconnect.txt", "r") do |f|
   f.each_line do |line|
    array_loconnect=line.to_f
   end
  end
File.open("/home/ubuntu/git/Monitis/java/monitorID_NGCR.txt", "r") do |f|
   f.each_line do |line|
    array_NGCR=line.to_f
   end
  end

  send_event('tpo_ep3',   { value: array_tpo_ep3 })
  send_event('tpo_ep9',   { value: array_tpo_ep9 })
  send_event('oapi',   { value: array_oapi })
  send_event('lo_connect',   { value: array_loconnect })
  send_event('ngcr',   { value: array_NGCR })
end
