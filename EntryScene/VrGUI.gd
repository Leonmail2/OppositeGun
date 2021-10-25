extends Spatial
signal start_game_as_host
signal start_game_as_client
var input_disabled = false
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func recive_button_press(button_id):
	print("button recived :",button_id)
	if not input_disabled:
		if button_id == "host":
			emit_signal("start_game_as_host")
			input_disabled = true
		elif button_id == "join":
			emit_signal("start_game_as_client")
			input_disabled = true
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
