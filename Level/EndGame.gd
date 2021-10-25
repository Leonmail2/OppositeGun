extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func end_game():
	yield(get_tree().create_timer(0.6),"timeout")
	get_tree().quit(0)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
