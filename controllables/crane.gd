extends Node2D

@onready var craneArmA = %CraneArmA
@onready var craneArmB = %CraneArmB
@onready var armBAttachPoint = %ArmBAttachPoint
@onready var armAAttachPoint = %ArmAAttachPoint
@export var claw: Node2D

const REDCIRCLE = preload("res://redcircle.tscn")
const BLUECIRCLE = preload("res://bluecircle.tscn")
var lastCraneAnchorPosition : Vector2
var blue : Sprite2D
var minAltitude : float = 100
var naturalAngle: float = 40
var naturalXPos : float

func _ready():
	#print("Arm B attach point: %s" % (armBAttachPoint.global_position - position))
	#print("Arm A origin point: %s" % (craneArmA.position))
	
	#var red = REDCIRCLE.instantiate()
	#red.position = craneArmB.position
	#$Node2D.add_child(red)
	
	craneArmB.position = claw.position
	craneArmA.look_at(armBAttachPoint.global_position)
	craneArmA.rotate(0.5*PI)
	naturalXPos = craneArmA.global_position.x
	
	#blue = BLUECIRCLE.instantiate()
	#$Node2D.add_child(blue)
	#blue.position = armAAttachPoint.global_position - position

func _physics_process(delta):
	# calculate movement since last frame
	var diff = (claw.global_position-position) - craneArmB.position
	# match arm on claw
	craneArmB.position += diff
	craneArmB.position.y -= 10
	#craneArmA.position = armBAttachPoint.global_position - position
	
	# adjust y offset of main arm
	craneArmA.position.y += diff.y
	# the x component will need to be made up by rotating the arms together
	# diff the the offset from craneArmA orgin to its new location
	#craneArmA.position += diff
	# adjust the rotation to be correct
	#craneArmA.look_at(lastCraneAnchorPosition)
	#craneArmA.rotate(-0.5*PI)
	var currentRotation = craneArmA.get_rotation_degrees()
	var pos = armAAttachPoint.global_position
	var lerpedRotation = lerpf(currentRotation, naturalAngle, .1)
	craneArmA.set_rotation_degrees(lerpedRotation)
	pos -= armAAttachPoint.global_position
	craneArmA.position.y += pos.y
	refocus()
	
	craneArmA.position.x = lerp(craneArmA.position.x, naturalXPos, 0.5)
	var detachment = armBAttachPoint.global_position - armAAttachPoint.global_position
	craneArmA.position.y += detachment.y
	if craneArmA.position.y > minAltitude:
		craneArmA.position.y = lerp(craneArmA.position.y, minAltitude, 0.2)
		detachment = armBAttachPoint.global_position - armAAttachPoint.global_position
		
	if detachment.x < -2:
		if detachment.x < -30:
			pass
		#invalid rotate arms
		craneArmA.rotate(-2*PI * 1.0/180.0)
		detachment = armBAttachPoint.global_position - armAAttachPoint.global_position
		craneArmA.position.y += detachment.y
		refocus()
	elif detachment.x > 5:
		var adjustment = detachment.x - 5
		craneArmA.position.x += adjustment
	
func refocus():
	craneArmB.look_at(armAAttachPoint.global_position)
	craneArmB.rotate(-0.5*PI)
	
	craneArmA.look_at(armBAttachPoint.global_position)
	craneArmA.rotate(0.5*PI)
