extends Panel

signal showItem

@onready
var message = $message

var active: bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	visible = false

func start_conversation(lines, show_item):
	visible = true
	for l in lines:
		message.text = l
		$AnimationPlayer.current_animation = "talk"
		$AnimationPlayer.play()
		$Timer.start()
		await $Timer.timeout
	visible = false
	if show_item:
		showItem.emit()
