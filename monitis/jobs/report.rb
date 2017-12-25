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

  response = contact.getRecentAlerts(0, '', '', 200)
  fd=0
  rd=0
  alert_counts = Hash.new({ value: 0 })
  rows = response['data'].map do |record|
	#puts record
    	fd = DateTime.parse(record['failDate'])
	fd = fd.new_offset('-08:00')
    	rd = DateTime.parse(record['recDate'])

	#puts "#{record['dataName']} .... #{fd.strftime("%m-%d-%y %R %P")}"
	#puts fd
        #puts fd.strftime("%d/%m/%y %R")
        #puts fd.strftime("%m-%d-%y %R %P")
	if  record['dataName'] == "OapiProdCustomMonitor" || record['dataName'] ==  "CustomLoConnect" || record['dataName'] == "TPO_EP9_CUSTOM_MONITOR" || record['dataName'] ==  "NextGenConceptRelease" || record['dataName'] == "TPO_EP9_CUSTOM_MONITOR" 
		if !alert_counts.key?(record['dataId']) 
		  
		  #puts "Inserting #{record['dataName']} .... #{fd.strftime("%m-%d-%y %R %P")}"
		  alert_counts[record['dataId']] = { label: record['dataName'], value: (fd.strftime("%m-%d-%y %R %P")) }
		end
	end

   # {
   #   name:      record['dataName'].slice(0, 20),
   #   down:      fd.strftime("%d/%m/%y %R"),
   #   up:        rd.strftime("%d/%m/%y %R"),
   #   down_time: ChronicDuration.output(record['downTime'], :format => :short)
   # }
  #puts "------"
  end if response
  #puts "ooooooooooooooooooooooooooooooooooooooooooo"
  #puts "#{alert_counts.inspect}"

  status = response['status']

  #send_event('monitis-recent-alerts', { rows: rows, status: status })
  send_event('alerts', { items: alert_counts.values })
end
