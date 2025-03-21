extends Node2D

const CIRCULAR_BLADE = preload("res://Scenes/circular_blade.tscn")

@onready var tile_map_layer: TileMapLayer = $TileMapLayer
@onready var death_color_rect: ColorRect = $DeathColorRect


func _ready() -> void:
	Global.death_color_rect = death_color_rect
	fill_tilemap(tile_map_layer)


func fill_tilemap(t : TileMapLayer):
	for i in t.get_used_cells():
		var c = t.get_cell_source_id(i)
		if c == 1:
			var obj = CIRCULAR_BLADE.instantiate()
			obj.global_position = t.global_position + Vector2(i * 32) + Vector2(16, 16)
			t.set_cell(i)
			t.add_child(obj)
