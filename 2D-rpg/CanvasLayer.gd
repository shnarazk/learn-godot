extends CanvasLayer

@export
var view: bool = false:
	set(value):
		visible = value
		$Viewport/Node3D.spin = value
		if value:
			$AudioStreamPlayer.play()
		else:
			$AudioStreamPlayer.stop()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	$Model.texture = $Viewport.get_texture()

func _on_message_box_show_item():
	self.view = true
