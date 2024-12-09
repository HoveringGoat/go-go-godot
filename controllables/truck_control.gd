extends CharacterBody2D


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
			

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta


	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = InputControl.inputDirection
	
	if direction:
		var force = direction.x * acceleration
		if velocity.normalized().x != direction.normalized().x:
			force *= 2
		velocity.x += force
		if abs(velocity.x) > maxSpeed:
			velocity.x *= maxSpeed / abs(velocity.x)
	elif velocity.x != 0:
		velocity.x *= 1.0-friction
		if abs(velocity.x) < 0.001:
			velocity.x = 0
	
	var speed = velocity.x
	if velocity.x != 0:
		facingRight = velocity.x > 0
	#	move_and_collide()
	var velocityForce = -(force + abs(velocity.x) * 50)
	if move_and_slide(): # true if collided
		for i in get_slide_collision_count():
			var col = get_slide_collision(i)
			if col.get_collider() is RigidBody2D:
				if col.get_collider().name != "GroundBody":
					col.get_collider().apply_force(col.get_normal() * velocityForce)
					print("force applied is %s" %velocityForce)
					
