extends ColorRect

var daynight = DayNightModule

func _process(delta):
	if daynight.time >= 2:
		$Time.text = str("DAY")
	if daynight.time >= 8:
		$Time.text = str("DUSK")
	if daynight.time >= 14:
		$Time.text = str("NIGHT")
	if daynight.time >= 20:
		$Time.text = str("DAWN")
