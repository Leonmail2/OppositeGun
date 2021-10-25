extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("TramStartingPos")
	$AnimationPlayer.play("TramDoorClosed")
	yield(get_tree().create_timer(3),"timeout")
	$AnimationPlayer.play("TramDoorOpening")
	$AudioStreamPlayer3D.play()

func open_door():
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
