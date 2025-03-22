class_name LaserPart
extends Node2D

enum LaserPartType {TOP, MIDDLE, END}

var laser_type : LaserPartType = LaserPartType.MIDDLE
var laser_enabled = false

@onready var collision_shape_2d: CollisionShape2D = $Area2D/CollisionShape2D
@onready var sprite_2d: Sprite2D = $Sprite2D

func _process(delta: float) -> void:
	match (laser_type):
		LaserPartType.TOP:
			if laser_enabled:
				sprite_2d.frame = 50
			else:
				sprite_2d.frame = 49
		LaserPartType.MIDDLE:
			sprite_2d.frame = 8
			sprite_2d.visible = laser_enabled
		LaserPartType.END:
			if laser_enabled:
				sprite_2d.frame = 59
			else:
				sprite_2d.frame = 58
	

func _physics_process(delta: float) -> void:
	collision_shape_2d.disabled = !laser_enabled
