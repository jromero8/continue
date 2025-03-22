extends Control

@onready var continue_yes_no_panel: PanelContainer = $CanvasLayer/ContinueYesNoPanel
@onready var continue_yes: Button = $CanvasLayer/ContinueYesNoPanel/VBoxContainer/HBoxContainer/ContinueYes
@onready var continue_no: Button = $CanvasLayer/ContinueYesNoPanel/VBoxContainer/HBoxContainer/ContinueNo
@onready var continue_rage_quit: Button = $CanvasLayer/ContinueYesNoPanel/VBoxContainer/HBoxContainer/ContinueRageQuit

func show_continue_panel() -> void:
	continue_yes_no_panel.visible = true
	continue_yes.grab_focus()

func hide_continue_panel() -> void:
	continue_yes_no_panel.visible = false


func _on_continue_yes_pressed() -> void:
	if continue_yes.has_focus():
		hide_continue_panel()
		Global.continue_game(true)


func _on_continue_no_pressed() -> void:
	if continue_no.has_focus():
		return
		#hide_continue_panel()
		#Global.continue_game(false)


func _on_continue_rage_quit_pressed() -> void:
	if continue_rage_quit.has_focus():
		get_tree().quit()
