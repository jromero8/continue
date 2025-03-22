extends Node

enum DeathType {FALL, EXPLODE}

const LEVEL = preload("res://Scenes/level.tscn")

var death_color_rect : ColorRect
var level_started_time : float
var last_death_time : float = -1

func _ready() -> void:
	last_death_time = -1


func _process(delta: float) -> void:
	pass


func die(death_type : DeathType = DeathType.EXPLODE):
	var p : Player = Player.get_instance()
	if !p.dead:
		last_death_time = Time.get_ticks_msec()
		print("die")
		death_color_rect.position = MainCamera2D.get_instance().global_position - Vector2(5000, 5000) 
		death_color_rect.get_node("AnimationPlayer").current_animation = "death"
		p.die(death_type)
		UI.show_continue_panel()

func continue_game(yes : bool):
	if yes:
		last_death_time = -1
		get_tree().change_scene_to_packed(LEVEL)
