extends Node

const LEVEL = preload("res://Scenes/level.tscn")

var death_color_rect : ColorRect

func _ready() -> void:
	pass


func _process(delta: float) -> void:
	pass


func die():
	print("die")
	death_color_rect.position = MainCamera2D.get_instance().global_position - Vector2(5000, 5000) 
	death_color_rect.get_node("AnimationPlayer").current_animation = "death"
	Player.get_instance().die()
	UI.show_continue_panel()

func continue_game(yes : bool):
	if yes:
		get_tree().change_scene_to_packed(LEVEL)
