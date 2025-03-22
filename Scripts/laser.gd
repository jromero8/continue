extends Node2D

const LASER_PART = preload("res://Scenes/Traps/laser_part.tscn")

var last_laser = 0
var laser_start = 0
var laser_enable_time = 1000
var laser_disabled_time = 2000
var length = 4

func _ready() -> void:
	construct_laser()
	last_laser = laser_start

func _process(delta: float) -> void:
	var current_time = Time.get_ticks_msec() - Global.level_started_time
	
	if current_time > last_laser + laser_enable_time + laser_disabled_time:
		last_laser = last_laser + laser_enable_time + laser_disabled_time
	
	if current_time > last_laser and current_time < last_laser + laser_enable_time:
		for p in get_children():
			p.laser_enabled = true
	
	if current_time > last_laser + laser_enable_time and current_time < last_laser + laser_enable_time + laser_disabled_time:
		for p in get_children():
			p.laser_enabled = false


func construct_laser():
	for i in range(0, length):
		var p = LASER_PART.instantiate()
		add_child(p)
		p.global_position = global_position + Vector2(0, 32 * i)
		if i == 0:
			p.laser_type = LaserPart.LaserPartType.TOP
		if i == length - 1:
			p.laser_type = LaserPart.LaserPartType.END
			
