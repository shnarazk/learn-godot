extends Control

signal selected
var right_selected: bool = false
var selected_already: bool = false

func show_options(left: String, right: String):
	$SelectButtonLeft.text = left
	$SelectButtonRight.text = right
	selected_already = false
	visible = true

func hide_options():
	visible = false

func _on_select_button_1_pressed():
	right_selected = false
	if not selected_already:
		selected_already = true
		selected.emit()

func _on_select_button_2_pressed():
	right_selected = true
	if not selected_already:
		selected_already = true
		selected.emit()
