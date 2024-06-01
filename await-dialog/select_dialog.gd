extends Node2D
signal selected(value)


func _ready():
	pass # visible = false


func open(title, str1, str2) -> int:
	if title == "":
		$Title.visible = false
	else:
		$Title.text = "[center][b]%s[/b][/center]" % title
		$Title.visible = true
	$ButtonL.text = str1
	$ButtonR.text = str2
	visible = true
	$ButtonL.grab_focus()    # 重要なので消さないこと
	var val = await selected
	visible = false
	return val

func _event():
	pass

func _on_button_1_pressed():
	print("l")
	selected.emit(1)


func _on_button_2_pressed():
	print("r")
	selected.emit(2)
