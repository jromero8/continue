class_name DeathArea2D
extends Area2D

signal death

func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		Global.die()
		death.emit()
