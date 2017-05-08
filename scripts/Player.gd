extends RigidBody2D

var input_states = preload("res://scripts/input_states.gd")

export var jump_force = 500
export var extra_gravity = 500

var Purple = Color(0.54902,0.07451,0.984314,1)
var Cyan = Color(0.207843,0.886275,0.94902,1)
var Magenta = Color(1,0,0.501961,1)
var Yellow = Color(0.964706,0.87451,0.054902,1)

var jump_action = input_states.new("jump_action")

var currentColor = ""

onready var PlayerSprite = get_node("Sprite")
onready var Player = get_node(".")

func _ready():
	set_fixed_process(true)
	set_applied_force(Vector2(0, extra_gravity))
	Player.set_mode(1)
	setRandomColor()
	
func _fixed_process(delta):
	if jump_action.check() == 1:
		Player.set_mode(2)
		set_axis_velocity(Vector2(0, -jump_force))
		
func setRandomColor():
	randomize()
	var index = randi() % 4
	
	if index == 0:
		currentColor = "Cyan"
		PlayerSprite.set_modulate(Cyan)
	elif index == 1:
		currentColor = "Yellow"
		PlayerSprite.set_modulate(Yellow)
	elif index == 2:
		currentColor = "Magenta"
		PlayerSprite.set_modulate(Magenta)
	elif index == 3:
		currentColor = "Purple"
		PlayerSprite.set_modulate(Purple)

func _on_Collision( collider ):
	if collider.get("Tag") == "ColorSwitcher":
		setRandomColor()
		collider.queue_free()
	
	if collider.get("Tag") == currentColor:
		pass
	elif collider.get("Tag") != currentColor and collider.get("Tag") != "ColorSwitcher":
		Die()

func Die():
	get_tree().change_scene("res://scenes/main.tscn")