extends Control


func start_conversation(lines: Array[String], item: int):
	$MessageBox.start_conversation(lines, item)

func select_from(left, right) -> bool:
	visible = true
	$MessageBox.display_message('選ぶのじゃ')
	$Selector.show_options(left, right)
	await $Selector.selected
	$Selector.hide_options()
	$MessageBox.hide()
	return $Selector.right_selected
