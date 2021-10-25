extends Spatial
signal start_game

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func on_start_button_pressed():
	emit_signal("start_game")

func on_quit_button_pressed():
	get_tree().quit(0)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
