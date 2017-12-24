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

  response = contact.getRecentAlerts(0, '', '', 10)
  fd=0
  rd=0
  alert_counts = Hash.new({ value: 0 })
  rows = response['data'].map do |record|
	#puts record
    	fd = DateTime.parse(record['failDate'])
	fd = fd.new_offset('-08:00')
    	rd = DateTime.parse(record['recDate'])
	#alert_counts[record['dataId']] = { label: record['dataName'], value: (rd) }
	

	puts fd
        puts fd.strftime("%d/%m/%y %R")
	alert_counts[record['dataId']] = { label: record['dataName'], value: (fd.strftime("%d/%m/%y %R")) }

   # {
   #   name:      record['dataName'].slice(0, 20),
   #   down:      fd.strftime("%d/%m/%y %R"),
   #   up:        rd.strftime("%d/%m/%y %R"),
   #   down_time: ChronicDuration.output(record['downTime'], :format => :short)
   # }
  end if response

  status = response['status']

  #send_event('monitis-recent-alerts', { rows: rows, status: status })
  send_event('alerts', { items: alert_counts.values })
end
