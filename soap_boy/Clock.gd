extends ColorRect

var daynight = DayNightModule

func _ready():
	visible = false
	daynight.connect("time_changed", self, "_on_time_changed")

func _on_time_changed():
	$Time.text = str(daynight.time)
