extends RigidBody2D
@onready var sprite2D = $Sprite2D
@onready var pinJoint2D = $PinJoint2D
@onready var grabArea = $GrabArea

var isBeingControlled : bool = true
var fixedClawRotation : float = 0
var force = 200
var maxForce = 30000
var naturalAngle :float = 0
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var currentRotation = get_rotation_degrees()
	var lerpedRotation = lerpf(currentRotation, naturalAngle, .02)
	set_rotation_degrees(lerpedRotation)
	var posDiff = InputControl.mousePosition - global_position
	var forceVector = posDiff * force
	if forceVector.length() > maxForce:
		forceVector = forceVector.normalized()*maxForce
	apply_force(forceVector)
	
	if InputControl.mousePressed:
		if sprite2D.frame == 0:
			sprite2D.frame = 1
			grab()
		else:
			sprite2D.frame = 0
			release()
	
	if pinJoint2D.node_b:
		var grabbedBody = get_node(pinJoint2D.node_b)
		if grabbedBody != null:
			look_at(grabbedBody.position)
			rotation -= fixedClawRotation


func grab():
	# check and see if we have any collisions on the check and if we do then
	# spawn a joint connecting them to the crane hand
	for body in grabArea.get_overlapping_bodies():
		if body is RigidBody2D:
			if body.name != "GroundBody" and body != self :
				pinJoint2D.node_b = body.get_path()
				var rot = rotation_degrees
				look_at(body.position)
				rot = rotation_degrees - rot
				fixedClawRotation = (rot/180 * PI)
				rotation -= fixedClawRotation
				return
	
func release():
	# remove any connections
	pinJoint2D.set_node_b("")
	fixedClawRotation = 0
	
