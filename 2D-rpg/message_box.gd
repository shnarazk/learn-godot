extends Panel

signal showItem(index)

@onready
var message = $message

var active: bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	visible = false

func start_conversation(lines: Array[String], show_item: int):
	visible = true
	for l in lines:
		message.text = l
		$AnimationPlayer.current_animation = "talk"
		$AnimationPlayer.play()
		$Timer.start()
		await $Timer.timeout
	visible = false
	if show_item != 0:
		showItem.emit(show_item)

func display_message(text: String):
	visible = true
	message.text = text

