extends CharacterBody2D


var SPEED = 300.0
const JUMP_VELOCITY = -400.0
@onready var AP: AnimationPlayer = $AnimationPlayer
var facing_direction = 1  # 1 = Right, -1 = Left

@export var arrow = preload("res://Player/Samurai_Archer/arrow.tscn")
var can_shoot = true
var shoot_timer 

func _ready():
	# Create and configure the timer
	shoot_timer = Timer.new()
	shoot_timer.wait_time = 0.5  # 0.5-second delay
	shoot_timer.one_shot = true
	shoot_timer.timeout.connect(_reset_shoot)
	add_child(shoot_timer)

func _physics_process(delta: float) -> void:
	# Add the gravity.
	var move_input = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	
	if move_input != 0:
		facing_direction = 1 if move_input > 0 else -1

	
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_up") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	


	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction>0:
		$"Regular Archer".flip_h = false
	elif direction<0:
		$"Regular Archer".flip_h = true
		
	
	
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	if Input.is_action_just_pressed("ui_right") and is_on_floor():
		AP.play("Run")
		
	elif Input.is_action_just_pressed("ui_right") and is_on_floor():
		AP.play("LRun")
	if Input.is_action_just_pressed("ui_accept") and can_shoot:
		fire_projectile()
	
	move_and_slide()
#func shoot():
	#if Input.is_action_just_pressed("ui_accept"):
		#var new_arrow = arrow.instantiate()
		#var arrow_vec = $bow.global_position - $ArcPlayer.global_position
		#arrow_vec = arrow_vec.normalized()
		#new_arrow.direction = arrow_vec
		#new_arrow.global_position = $bow.global_position
		#get_tree().get_root().add_child(new_arrow)
func fire_projectile():
	can_shoot = false  # Prevent shooting until cooldown ends
	shoot_timer.start()  # Start cooldown timer
	var new_arrow = arrow.instantiate()
	var spawn_offset = Vector2(-25, 0) if facing_direction == 1 else Vector2(-150, 0)#Left dir
	new_arrow.position = $bow.global_position + spawn_offset  # Spawn at a specified node (GunPoint)
	new_arrow.set_direction(facing_direction)  # Call the function to set direction
	get_parent().add_child(new_arrow)
	
func _reset_shoot():
	can_shoot = true  # Allow shooting again

	
