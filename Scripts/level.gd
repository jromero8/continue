extends Node2D

const CIRCULAR_BLADE = preload("res://Scenes/Traps/circular_blade.tscn")
const LASER = preload("res://Scenes/Traps/laser.tscn")

@onready var tile_map_layer: TileMapLayer = $TileMapLayer
@onready var death_color_rect: ColorRect = $DeathColorRect

func _ready() -> void:
	Global.death_color_rect = death_color_rect
	Global.level_started_time = Time.get_ticks_msec()
	fill_tilemap(tile_map_layer)
	Audio.stop_sound(AudioClass.AUDIO_CODE.LEVEL_1)
	Audio.play_sound(AudioClass.AUDIO_CODE.LEVEL_1)


func fill_tilemap(t : TileMapLayer):
	for i in t.get_used_cells():
		var c = t.get_cell_source_id(i)
		match c:
			0:
				if t.get_cell_atlas_coords(i) == Vector2i(5, 5):
					var obj = LASER.instantiate()
					obj.global_position = t.global_position + Vector2(i * 32) + Vector2(16, 16)
					var d : TileData = t.get_cell_tile_data(i)
					obj.laser_start = d.get_custom_data("StartTime")
					t.set_cell(i)
					t.add_child(obj)
			1:
				var obj = CIRCULAR_BLADE.instantiate()
				obj.global_position = t.global_position + Vector2(i * 32) + Vector2(16, 16)
				t.set_cell(i)
				t.add_child(obj)
