extends RigidBody2D

var size = 1
@onready var sprite_2d: Sprite2D = $Sprite2D

func _process(delta: float) -> void:
	sprite_2d.look_at(sprite_2d.global_position + linear_velocity.normalized())
	sprite_2d.scale = size
