extends Spatial
class_name Door

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var is_open = false
var is_moving = false
# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("Closed")

func _on_Button_pressed():
	$AudioStreamPlayer3D.play()
	is_open	= true
	if is_moving:
		var time_to_advance = 1 - $AnimationPlayer.get_current_animation_position()
		$AnimationPlayer.play("DoorOpening")
		$AnimationPlayer.advance(time_to_advance)
	else:
		$AnimationPlayer.play("DoorOpening")
	is_moving = true

func _on_Button_unpressed():
	$AudioStreamPlayer3D.play()
	is_open = false
	if is_moving:
		var time_to_advance = 1 - $AnimationPlayer.get_current_animation_position()
		$AnimationPlayer.play("DoorClosing")
		$AnimationPlayer.advance(time_to_advance)
	else:
		$AnimationPlayer.play("DoorClosing")
	is_moving = true

func _on_door_stopped_moving():
	is_moving = false
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
