tool
extends Spatial

var spin_modifier = 2.3
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var back_spinner = $OppositeGun/Spinner
onready var middle_spinner = $OppositeGun/PowerSpinny
onready var front_spinner = $OppositeGun/GrabbyThings

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$OppositeGun/Spinner.rotate_z(2*spin_modifier*delta)
	$OppositeGun/PowerSpinny.rotate_z(-2*spin_modifier*delta)
	$OppositeGun/GrabbyThings.rotate_z(1*spin_modifier*delta)
	#spin_modifier = lerp(spin_modifier,0,delta*2.4)
	#if spin_modifier < 0.02:
	#	spin_modifier = 20.0
