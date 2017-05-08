extends Node2D

export var rot_speed = 75
onready var circle_entity = get_node(".")

func _ready():
	set_fixed_process(true)

func _fixed_process(delta):
	circle_entity.rotate(deg2rad(rot_speed * delta))