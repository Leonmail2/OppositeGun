extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var does_blacklight_affect_stand = false
var is_blacklight_on = false

# Called when the node enters the scene tree for the first time.
func _ready():
	is_blacklight_on = false
	$ButtonStand.get_active_material(0).set_shader_param("emission_energy",0)

func blacklight(new_value):
	if does_blacklight_affect_stand:
		print(does_blacklight_affect_stand)
		is_blacklight_on = new_value
		if is_blacklight_on:
			$ButtonStand.get_active_material(0).set_shader_param("emission_energy",1.5)
		else:
			$ButtonStand.get_active_material(0).set_shader_param("emission_energy",0)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
