extends Light2D

var daynight = DayNightModule

func _ready():
	visible = false
	daynight.connect("lights_on", self, "_on_daynight_lights_on")
	daynight.connect("lights_off", self, "_on_daynight_lights_off")

func _on_daynight_lights_on():
	visible = true

func _on_daynight_lights_off():
	visible = false
