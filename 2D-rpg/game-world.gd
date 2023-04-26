extends Node2D

@onready
var scene1: PackedScene = preload("res://Stage1.tscn")

@onready
var scene2: PackedScene = preload("res://Stage2.tscn")

var current_scene: PackedScene = null
var current_stage: Node = null
var selecting: bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	switch_stage(scene1)

func _physics_process(_delta):
	if Input.is_action_pressed("ui_accept") and not selecting:
		$ItemViewer.view = false

func switch_stage(scene: PackedScene):
	if current_stage != null:
		remove_child(current_stage)
	current_scene = scene
	current_stage = scene.instantiate()
	add_child(current_stage)
	$Yuhina.position = current_stage.yuhina_start_at
	current_stage.controller = $Control
	current_stage.yuhina = $Yuhina
	current_stage.connect("start_conversation", $Control.start_conversation)
	current_stage.connect("change_stage", self.change_stage)

func change_stage(next: int):
	$AnimationPlayer.current_animation = "Warp"
	$AnimationPlayer.play()
	$Timer.start()
	await $Timer.timeout
	if next == 1:
		switch_stage(scene1)
	elif next == 2:
		switch_stage(scene2)

