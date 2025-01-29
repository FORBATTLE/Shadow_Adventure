extends Area2D

var speed = 750
var direction = Vector2.RIGHT

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _physics_process(delta):
	
	#position += transform.x * speed * delta
	pass

func _on_body_entered(body: Node2D) -> void:
	#if body.is_in_group("Enemies"):
		#body.queue_free()
	#queue_free()
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position += direction * speed * delta
	pass
