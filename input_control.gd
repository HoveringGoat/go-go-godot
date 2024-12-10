extends Control

var mousePosition : Vector2 = Vector2.ZERO
var inputDirection : Vector2 = Vector2.ZERO
# gets all inputs
# if a device is being "controlled" it can get the inputs it should receive from here

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	inputDirection = Input.get_vector("left", "right", "up", "down").normalized()
	mousePosition = get_local_mouse_position()
	if Input.is_action_just_pressed("spawnBlock"):
		Signals.spawnBlock.emit(mousePosition)