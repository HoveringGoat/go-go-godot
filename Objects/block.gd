extends CharacterBody2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += 1 * delta
	#	move_and_collide()
	move_and_slide()
