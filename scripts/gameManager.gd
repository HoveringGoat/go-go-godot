extends Node
@export var blockScene : PackedScene
@onready var blockHolder: Node2D = $blockHolder

func _ready():
	Signals.spawnBlock.connect(createBlock)

func createBlock(mousePosition : Vector2):
	var block = blockScene.instantiate()
	block.setRandomBlockSize()
	block.position = mousePosition
	blockHolder.add_child(block)
	
