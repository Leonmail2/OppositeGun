extends HoldableObject
class_name OppositeGun

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var indicator = $OppositeGunEffects/OppositeGun/Indicator
var is_in_opposite_mode = false setget set_is_in_opposite_mode #can be in opposite or gravity gun mode


func set_is_in_opposite_mode(new):
	is_in_opposite_mode = new
	#indicator.mesh.material.set_shader_param("is_in_opposite_mode",is_in_opposite_mode)
	
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func on_button_press(controller_type,button_id):
	if button_id == JOY_OCULUS_BY:
		is_in_opposite_mode = ! is_in_opposite_mode

func on_trigger_pressed():
	if not is_in_opposite_mode:
		pass

func on_trigger_unpressed():
	if not is_in_opposite_mode:
		pass

func picked_up(controller):
	.picked_up(controller)
	print(indicator.material[1])
	#indicator.material[1].set_shader_param("emission_energy",2.5)

func dropped(controller_velocity):
	.dropped(controller_velocity)
	#indicator.material.set_shader_param("emission_energy",0)

func force_ungrip():
	.force_ungrip()
	#indicator.material.set_shader_param("emission_energy",0)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
