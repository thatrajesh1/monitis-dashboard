class Dashing.Text extends Dashing.Widget
	@accessor 'value', Dashing.AnimatedValue


onData: (data) ->
    if data.value == 1
      $(@node).css('background-color', '#6699ff')
    if data.value == 2
      $(@node).css('background-color', '#ffaa00')
    if data.value == 3
      $(@node).css('background-color', '#ffb3e6')
    if data.value == 4
      $(@node).css('background-color', '#47BBB3')
