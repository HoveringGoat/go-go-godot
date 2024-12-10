extends RigidBody2D



@export var maxSpeed : float = 500.0
@export var acceleration : float = 10.0
@export var friction : float = 0.01
@onready var sprite_2d = $Sprite2D
@export var force = 1000
@export var facingRight : bool = false:

	set (value):
		if value != facingRight:
			facingRight = value
			sprite_2d.flip_h = not value

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
