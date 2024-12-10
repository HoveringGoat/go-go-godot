extends RigidBody2D


@export var maxSpeed : float = 500.0
@export var acceleration : float = 750.0
@export var friction : float = 0.01
@onready var sprite_2d = $Sprite2D
@onready var collisionShape2D: CollisionShape2D = $CollisionShape2D
@onready var collisionShape2D2: CollisionShape2D = $CollisionShape2D2

@export var facingRight : bool = false:
	set (value):
		if value != facingRight:
			facingRight = value
			sprite_2d.flip_h = not value



func _physics_process(delta):
	if abs(linear_velocity.x) < maxSpeed:
		var direction = InputControl.inputDirection
		var appliedForce = (direction * acceleration * delta * 1000)
		apply_force(appliedForce)

	
