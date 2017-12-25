current_valuation = 0
current_karma = 0
nextgen=1
currentgen=2
dashboard=3

SCHEDULER.every '3s' do
  last_valuation = current_valuation
  last_karma     = current_karma
  current_valuation = rand(100)
  current_karma     = rand(200000)

  #send_event('valuation', { current: current_valuation, last: last_valuation })
  #send_event('karma', { current: current_karma, last: last_karma })
  #send_event('synergy',   { value: rand(100) })
  send_event('nextgen_widget',   { value: nextgen})
  send_event('currentgen_widget',   { value: currentgen})
  send_event('gohome_widget',   { value: dashboard})
end
