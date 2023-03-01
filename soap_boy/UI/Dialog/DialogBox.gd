extends ColorRect

export var dialogPath = "res://Dialog/xxx.json"
export(float) var textSpeed = 0.05

var dialog

var phraseNum = 0
var finished = false

signal dialog_ended

func _process(_delta):
	$Indicator.visible = finished
	if Input.is_action_just_pressed("select_1"):
		if finished:
			nextPhrase()
		else:
			$Text.visible_characters = len($Text.text)

func startDialog():
	$Timer.wait_time = textSpeed
	dialog = getDialog()
	assert(dialog, "Dialog not found")
	nextPhrase()

func getDialog() -> Array:
	var f = File.new()
	assert(f.file_exists(dialogPath), "File path does not exist")
	
	f.open(dialogPath, File.READ)
	var json = f.get_as_text()
	
	var output = parse_json(json)
	
	if typeof(output) == TYPE_ARRAY:
		return output
	else:
		return []

func nextPhrase() -> void:
	if phraseNum >= len(dialog):
		emit_signal ("dialog_ended")
		return
	
	finished = false
	
	$Name.bbcode_text = dialog[phraseNum]["Name"]
	$Text.bbcode_text = dialog[phraseNum]["Text"]
	
	$Text.visible_characters = 0
	
	var f = File.new()
	var img = "res://NPC/Portraits/" + dialog[phraseNum]["Name"] + dialog[phraseNum]["Emotion"] + ".png"
	if f.file_exists(img):
		$Portrait.texture = load(img)
	else: $Portrait.texture = null
	
	
	while $Text.visible_characters < len($Text.text):
		$Text.visible_characters += 1
		
		$Timer.start()
		yield($Timer, "timeout")
	
	finished = true
	phraseNum += 1
	return

func _on_DialogBox_dialog_ended():
	phraseNum = 0
