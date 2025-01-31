extends CharacterBody2D


var SPEED = 300.0
const JUMP_VELOCITY = -400.0
@onready var AP: AnimationPlayer = $AnimationPlayer


@export var arrow = preload("res://Player/Samurai_Archer/arrow.tscn")

func _physics_process(delta: float) -> void:
	# Add the gravity.
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
		
	
	shoot()
	move_and_slide()
func shoot():
	if Input.is_action_just_pressed("ui_accept"):
		var new_arrow = arrow.instantiate()
		var arrow_vec = $bow.global_position - $ArcPlayer.global_position
		arrow_vec = arrow_vec.normalized()
		new_arrow.direction = arrow_vec
		new_arrow.global_position = $bow.global_position
		get_tree().get_root().add_child(new_arrow)

	

	
