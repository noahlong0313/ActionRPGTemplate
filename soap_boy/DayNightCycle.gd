extends CanvasModulate

const NIGHT_COLOR = Color("#091d3a")
const DAY_COLOR = Color("#ffffff")
const EVENING_COLOR = Color("#bf6b5a")

const TIME_SCALE = 0.03

var time = 0

func _process(delta:float) -> void:
	self.time += delta * TIME_SCALE
	var value = (sin(time) + 1) / 2
	self.color = get_source_colour(value).linear_interpolate(get_target_colour(value), value)
	print(time)

func get_source_colour(value):
	return NIGHT_COLOR.linear_interpolate(EVENING_COLOR, value)

func get_target_colour(value):
	return EVENING_COLOR.linear_interpolate(DAY_COLOR, value)
