extends CanvasLayer

var seeds := 0

@onready var label = $Label

func add_seed():
	seeds += 1
	label.text = str(seeds)
