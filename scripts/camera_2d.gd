extends Camera2D
@onready var truck: RigidBody2D = $"../Truck"
@onready var camera2D: Camera2D = $"."
#var targetZoom : Vector2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var speedPercent = minf(1,abs(truck.linear_velocity.x) / 500)
	camera2D.position = truck.position
	var floatZoom = lerp(1.0, 0.7, speedPercent)
	var targetZoom = floatZoom * Vector2.ONE
	camera2D.zoom = camera2D.zoom.lerp(targetZoom, 0.1)
