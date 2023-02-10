extends Camera2D

@onready
var topleft: Node = $Boundary/TopLeft
@onready
var bottomright: Node = $Boundary/BottomRight

# Called when the node enters the scene tree for the first time.
func _ready():
	limit_top = topleft.position.y
	limit_bottom = bottomright.position.y
	limit_left = topleft.position.x
	limit_right = bottomright.position.x
