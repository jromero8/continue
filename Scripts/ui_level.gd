extends Control

@onready var label_time: Label = $CanvasLayer/VBoxContainer/HBoxContainer/LabelTime

func _process(delta: float) -> void:
	if Global.last_death_time == -1:
		label_time.text = str((Time.get_ticks_msec() - Global.level_started_time) / 1000)
		
