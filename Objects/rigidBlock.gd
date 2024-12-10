extends RigidBody2D
@export var CollisionShape_2D: CollisionShape2D
@export var Sprite_2D: Sprite2D
var rng = RandomNumberGenerator.new()

func setBlockSize(scalingVector):
	Sprite_2D.scale = scalingVector
	CollisionShape_2D.scale = scalingVector

func setRandomBlockSize():
	var randomX = rng.randf_range(.2, 2.5)
	var randomY = rng.randf_range(.1, .3)
	var scalingVector = Vector2(randomX,randomY)
	setBlockSize(scalingVector)
