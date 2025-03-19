extends Node2D
@onready var tile_map_layer: TileMapLayer = $TileMapLayer
@onready var death_color_rect: ColorRect = $DeathColorRect


func _ready() -> void:
	Global.death_color_rect = death_color_rect
	fill_tilemap(tile_map_layer)


func fill_tilemap(t : TileMapLayer):
	for i in t.get_used_cells():
		var c = t.get_cell_source_id(i)
		if c == 3:
			print(str(c))
