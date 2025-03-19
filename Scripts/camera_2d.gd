extends Camera2D


func _process(delta: float) -> void:
	var p = Player.get_instance()
	if p != null:
		global_position = p.global_position
	if global_position.y > 100:
		global_position.y = 100
