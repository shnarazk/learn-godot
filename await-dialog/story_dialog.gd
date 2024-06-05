extends Control

signal get_prompt

# Called when the node enters the scene tree for the first time.
func _ready():
	$HBoxContainer/TellFrame/Prompt.visible = false

# TODO: \t でスプリット表示したい
func print_lines(lines: Array):
	for line in lines:
		$HBoxContainer/TellFrame/Lines.text = line
		$HBoxContainer/TellFrame/Prompt.visible = true
		$HBoxContainer/TellFrame/Prompt.grab_focus()
		await get_prompt
	$HBoxContainer/TellFrame/Lines.text = ''

func _on_prompt_pressed():
	$HBoxContainer/TellFrame/Prompt.visible = false
	get_prompt.emit()
