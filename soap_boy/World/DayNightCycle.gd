extends CanvasModulate

const NIGHT_COLOR = Color("#091d3a")
const DAY_COLOR = Color("#ffffff")
const EVENING_COLOR = Color("#bf6b5a")

const day_length = 24.0
const day_length_in_seconds = 10
const sun_rise = 6.0
const sun_set = 18.0
var time = 0.0

var lights_on_triggered = false
var lights_off_triggered = false

signal lights_on
signal lights_off
signal time_changed

func _process(delta):
	time += (delta * day_length) / day_length_in_seconds
	var value = (sin((time / day_length) * (2 * PI)) + 1.0) / 2.0;
	self.color = get_source_colour(value).linear_interpolate(get_target_colour(value), value)
	get_path()
	if time >= 14.0 && !lights_on_triggered:
		emit_signal("lights_on")
		lights_on_triggered = true
	if time >= 2.0 && !lights_off_triggered:
		emit_signal("lights_off")
		lights_off_triggered = true
	if time >= day_length:
		time = 0
		lights_on_triggered = false
		lights_off_triggered = false
	print(get_current_time_24())

func get_source_colour(value):
	return NIGHT_COLOR.linear_interpolate(EVENING_COLOR, value)

func get_target_colour(value):
	return EVENING_COLOR.linear_interpolate(DAY_COLOR, value)

#24hr Functions
func get_current_time_24():
	return fmod(time, day_length)

func sleep():
	time = (floor(time / day_length) * day_length) + day_length + sun_rise #Sleep until 6 in the morning next day

func get_day():
	return floor(time / day_length)

func get_weekday():
	return get_day() % 7
