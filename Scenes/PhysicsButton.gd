extends Spatial
signal button_on
signal button_off

export var button_threshold = 0.001
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$ButtonCase/Button/ForceSensor.threshold = button_threshold


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_ForceSensor_button_off():
	emit_signal("button_off")
	$AnimationPlayer.play("ButtonGoingUp")


func _on_ForceSensor_button_on():
	emit_signal("button_on")
	$AnimationPlayer.play("ButtonGoingDown")
