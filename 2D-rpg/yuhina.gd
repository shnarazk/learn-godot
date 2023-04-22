extends CharacterBody2D

signal yohina_hitorigoto_1

@export
var controller: Node = null

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
	if controller != null and controller.visible:
		return
	velocity = Vector2.ZERO # The player's movement vector.
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
		$Sprite.animation = "migi aruki"
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
		$Sprite.animation = "hidari aruki"
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
		$Sprite.animation = "default"
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
		$Sprite.animation = "ue aruki"
	if velocity.length() > 0:
		velocity = velocity.normalized() * 60
		#$Sprite.play()
	else:
		pass # $Sprite.stop()
#		if panel != null:
#			panel.visible = true
#			message_box.text = "もっと意味あること呟けよ"
#	elif panel != null:
#		panel.visible = false
	move_and_slide()
#
