extends Node
@export var blockScene : PackedScene
@onready var blockHolder: Node2D = $blockHolder

func _ready():
	Signals.spawnBlock.connect(createBlock)

func createBlock(mousePosition : Vector2):
	var tempBlock = blockScene.instantiate()
	tempBlock.position = mousePosition
	blockHolder.add_child(tempBlock)
