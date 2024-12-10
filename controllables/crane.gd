extends RigidBody2D
@onready var sprite2D = $Sprite2D
@onready var pinJoint2D = $PinJoint2D
@onready var grabArea = $GrabArea

var isBeingControlled : bool = true
# Called when the node enters the scene tree for the first time.
var force = 200
var maxForce = 50000
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var posDiff = InputControl.mousePosition - position
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


func grab():
	# check and see if we have any collisions on the check and if we do then
	# spawn a joint connecting them to the crane hand
	for body in grabArea.get_overlapping_bodies():
		if body is RigidBody2D:
			if body.name != "GroundBody" and body != self :
				pinJoint2D.node_b = body.get_path()
				return
	
func release():
	# remove any connections
	pinJoint2D.set_node_b("")
