class_name Player
extends CharacterBody2D

const BLOOD_SPLASH = preload("res://Scenes/blood_splash.tscn")
const SPEED = 500.0
const JUMP_VELOCITY = -1000.0
const COYOTE_TIME = 100

static var instance : Player = null
var last_grounded = 0
var dead = false
var death_animation_executed = false
var dash_time = 0
var current_direction = 1
var run_speed = 1

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite_2d: Sprite2D = $Sprite2D

static func get_instance() -> Player:
	return instance

func _ready() -> void:
	instance = self

func _process(delta: float) -> void:
	set_animation()

func _physics_process(delta: float) -> void:
	var gravity = get_gravity()
	if !dead:
		
		if Input.is_action_pressed("run"):
			run_speed = 1.5
		else:
			run_speed = 1
		
		dash_time -= delta * 5
		if dash_time < 0:
			dash_time = 0
		if Input.is_action_just_pressed("dash") and is_on_floor() and dash_time <= 0:
			dash_time = 1
		
		# Add the gravity.
		if is_on_floor():
			last_grounded = Time.get_ticks_msec()
		else:
			velocity += gravity * delta
		
		if is_on_wall():
			last_grounded = Time.get_ticks_msec()

		# Get the input direction and handle the movement/deceleration.
		# As good practice, you should replace UI actions with custom gameplay actions.
		if dash_time > 0:
			velocity.x = current_direction * SPEED * 3
		else: 
			var direction := Input.get_axis("ui_left", "ui_right")
			if direction:
				if direction != 0:
					current_direction = direction
				velocity.x = direction * SPEED * run_speed
			else:
				velocity.x = move_toward(velocity.x, 0, SPEED * .5)
		
		# Handle jump.
		if Input.is_action_just_pressed("ui_accept") and Time.get_ticks_msec() - last_grounded <= COYOTE_TIME:
			velocity.y = JUMP_VELOCITY

		if is_on_wall() and velocity.y > 200:
			velocity.y = 200
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity += gravity * delta
		
	move_and_slide()

func set_animation():
	animation_player.speed_scale = 1
	if dead:
		if animation_player.current_animation != "die" && !death_animation_executed:
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
	if is_on_wall() and velocity.y > 0:
		animation_player.current_animation = "wall_slide"
		return
	
	if dash_time > 0:
		animation_player.current_animation = "dash"
		return
		
	if is_on_floor():
		if running:
			if velocity.y == 0:
				animation_player.current_animation = "run"
				if run_speed > 1:
					animation_player.speed_scale = run_speed
					
		else:
			animation_player.current_animation = "idle"
	else:
		if animation_player.current_animation != "jump" && animation_player.current_animation != "":
			animation_player.current_animation = "jump"
	
func die(death_type : Global.DeathType):
	if !dead:
		dead = true
		var b = BLOOD_SPLASH.instantiate()
		get_parent().add_child(b)
		b.global_position = global_position
		sprite_2d.visible = false
