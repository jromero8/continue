class_name MainCamera2D
extends Camera2D

static var instance : Camera2D

func _ready() -> void:
	instance = self

static func get_instance() -> Camera2D:
	return instance

func _process(delta: float) -> void:
	var p = Player.get_instance()
	if p != null:
		
		if p.dead:
			global_position = Vector2(global_position.x, p.global_position.y)
		else:
			global_position = p.global_position
	if global_position.y > 0:
		global_position.y = 0
