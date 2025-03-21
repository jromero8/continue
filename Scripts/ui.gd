extends Control

@onready var continue_yes_no_panel: PanelContainer = $CanvasLayer/ContinueYesNoPanel

func show_continue_panel() -> void:
	continue_yes_no_panel.visible = true

func hide_continue_panel() -> void:
	continue_yes_no_panel.visible = false


func _on_continue_yes_pressed() -> void:
	hide_continue_panel()
	Global.continue_game(true)


func _on_continue_no_pressed() -> void:
	hide_continue_panel()
	Global.continue_game(false)
