extends Marker2D
var mousePosition : Vector2 = Vector2.ZERO
@onready var markerRight: Marker2D = $MarkerRight
@onready var markerLeft: Marker2D = $"."
@export var parentPosition : vector2 
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

#mousePosition = get_local_mouse_position()
	#Lock this marker to its parents Marker location
#	if parent.type == Marker2D
#		this = parent.markerposition
		
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if parentPosition:
		markerLeft.position = parentPosition
#	mousePosition = get_global_mouse_position()
#	mousePosition = mousePosition.normalized()
#	var mouseAngle = -(mousePosition.x / mousePosition.y)
#	beamArm.rotation = mouseAngle
#	print("mouse angle = %s" %mouseAngle)
#	print("mouse pos = %s" %mousePosition)
#	markerRight.position = mousePosition
