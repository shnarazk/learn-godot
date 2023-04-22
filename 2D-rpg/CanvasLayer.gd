extends CanvasLayer

@export
var view: bool = false:
	set(value):
		visible = value
		$Viewport/Node3D.spin = value

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Model.texture = $Viewport.get_texture()


func _on_message_box_show_item():
	self.view = true
