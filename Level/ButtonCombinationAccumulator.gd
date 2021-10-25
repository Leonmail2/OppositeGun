extends Spatial
signal combination_achived
signal combination_failed

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var button1pressed = false
var button2pressed = false
var button3pressed = false

func check_if_all_buttons_are_pressed():
	if button1pressed == true and button2pressed == true and button3pressed == true:
		emit_signal("combination_achived")
	else:
		emit_signal("combination_failed")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_Button1_on():
	button1pressed = true
	check_if_all_buttons_are_pressed()

func _on_Button2_on():
	button2pressed = true
	check_if_all_buttons_are_pressed()

func _on_Button3_on():
	button3pressed = true
	check_if_all_buttons_are_pressed()

func _on_Button1_off():
	button1pressed = false
	check_if_all_buttons_are_pressed()
	
func _on_Button2_off():
	button2pressed = false
	check_if_all_buttons_are_pressed()

func _on_Button3_off():
	button3pressed = false
	check_if_all_buttons_are_pressed()
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
