extends Node2D

const BLOOD_DROP = preload("res://Scenes/blood_drop.tscn")

var rng : RandomNumberGenerator

var last_blood = 0

func _ready() -> void:
	rng = RandomNumberGenerator.new()
	activate_blood()

func _process(delta: float) -> void:
	if Input.is_action_pressed("ui_accept"):
		if Time.get_ticks_msec() > last_blood + 500:
			last_blood = Time.get_ticks_msec()
			activate_blood()


func activate_blood():
	for i in range(0, 30):
		var b = BLOOD_DROP.instantiate()
		b.global_position = global_position
		
		var v = Vector2(rng.randf_range(-1, 1), rng.randf_range(-1, 1))
		v = v * 800
		b.linear_velocity = v
		
		b.size = Vector2(1, 1) * rng.randf_range(0.25, 1)
		call_deferred("add_child", b)
