require 'chronic_duration'
require 'date'
require 'time'
require 'json'
require 'monitis-SDK'

config = YAML.load File.open("config.yml")
config = config[:monitis]

SCHEDULER.every '1m', :first_in => 0 do

  contact = Contact.new(
    config[:api_key],
    config[:api_secret],
    true
  )

  buzzwords = ['OAPI', 'TPO EP3', 'TPO EP9', 'NGCR', 'LoConnect']
  buzzword_counts = Hash.new({ value: 0 })

  response = contact.getRecentAlerts(0, '', '', 50)
  fd=0
  rd=0
  alert_counts = Hash.new({ value: 0 })
  ary = Array.new
  ARRAY_pie=([['Alert', 'Percentage']])
  oapi_cnt=0
  loconnect_cnt=0
  tpo_ep3_cnt=0
  tpo_ep9_cnt=0
  ngcr_cnt=0
  rows = response['data'].map do |record|
	#puts record
	if  record['dataName'] == "OapiProdCustomMonitor" || record['dataName'] ==  "CustomLoConnect" || record['dataName'] == "TPO_EP9_CUSTOM_MONITOR" || record['dataName'] ==  "NextGenConceptRelease" || record['dataName'] == "TPO_EP9_CUSTOM_MONITOR" 
		if  record['dataName'] == "OapiProdCustomMonitor"
			oapi_cnt += 1
		end
		if  record['dataName'] ==  "CustomLoConnect"
			loconnect_cnt += 1
		end
		if  record['dataName'] == "TPO_EP9_CUSTOM_MONITOR"
			tpo_ep9_cnt += 1
		end
		if  record['dataName'] ==  "TPO_EP3_CUSTOM_MONITOR"
			tpo_ep3_cnt += 1
		end
		if  record['dataName'] ==  "NextGenConceptRelease"
			ngcr_cnt += 1
		end
	end
  end if response
  #buzzwords = ['OAPI', 'TPO EP3', 'TPO EP9', 'NGCR', 'LoConnect']
  #puts "oapi cnt #{oapi_cnt}"
  #puts "loconnect cnt #{loconnect_cnt}"
  #puts "tpo_ep3 cnt #{tpo_ep3_cnt}"
  #puts "tpo_ep9 cnt #{tpo_ep9_cnt}"
  #puts "ngcr cnt #{ngcr_cnt}"
  buzzword_counts[0] = { label: "OAPI", value: "#{oapi_cnt}"} 
  buzzword_counts[1] = { label: "TPO EP3", value: "#{tpo_ep3_cnt}"} 
  buzzword_counts[2] = { label: "TPO EP9", value: "#{tpo_ep9_cnt}"} 
  buzzword_counts[3] = { label: "NGCR", value: "#{ngcr_cnt}"} 
  buzzword_counts[4] = { label: "LOC onnect", value: "#{loconnect_cnt}"} 
  ARRAY_pie.push(['OAPI',oapi_cnt])	
  ARRAY_pie.push(['LoConnect',loconnect_cnt])	
  ARRAY_pie.push(['TPO_EP3',tpo_ep3_cnt])	
  ARRAY_pie.push(['TPO_EP9',tpo_ep3_cnt])	
  ARRAY_pie.push(['NGCR',ngcr_cnt])	

  send_event('pie_widget',slices:  ARRAY_pie)
  send_event('alert_cnt_widget', { items: buzzword_counts.values })
end
