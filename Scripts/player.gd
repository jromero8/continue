class_name Player
extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -450.0
const COYOTE_TIME = 100

static var instance : Player = null
var last_grounded = 0
var dead = false
var death_animation_executed = false

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite_2d: Sprite2D = $Sprite2D

static func get_instance() -> Player:
	return instance

func _ready() -> void:
	instance = self

func _process(delta: float) -> void:
	set_animation()

func _physics_process(delta: float) -> void:
	if !dead:
		# Add the gravity.
		if is_on_floor():
			last_grounded = Time.get_ticks_msec()
		else:
			velocity += get_gravity() * delta

		# Handle jump.
		if Input.is_action_just_pressed("ui_accept") and Time.get_ticks_msec() - last_grounded <= COYOTE_TIME:
			velocity.y = JUMP_VELOCITY

		# Get the input direction and handle the movement/deceleration.
		# As good practice, you should replace UI actions with custom gameplay actions.
		var direction := Input.get_axis("ui_left", "ui_right")
		if direction:
			velocity.x = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

func set_animation():
	if dead:
		if animation_player.current_animation != "die" && !death_animation_executed:
			print("anim:" + animation_player.current_animation)
			animation_player.current_animation = "die"
			death_animation_executed = true
		return
	
	var running = false;
	if velocity.x > 0:
		sprite_2d.flip_h = false
		running = true;
	if velocity.x < 0:
		sprite_2d.flip_h = true
		running = true;
		
	if is_on_floor():
		if running:
			if velocity.y == 0:
				animation_player.current_animation = "run"
		else:
			animation_player.current_animation = "idle"
	else:
		if animation_player.current_animation != "jump" && animation_player.current_animation != "":
			animation_player.current_animation = "jump"
	
func die():
	print("-")
	dead = true
