extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func start_conversation(lines, item):
	$MessageBox.start_conversation(lines, item)

func select_from(left, right) -> bool:
	visible = true
	$MessageBox.display_message('選ぶのじゃ')
	$Selector.show_options(left, right)
	await $Selector.selected
	$Selector.hide_options()
	$MessageBox.hide()
	return $Selector.right_selected
