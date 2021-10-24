extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var does_blacklight_affect_stand = false
var is_blacklight_on = false

# Called when the node enters the scene tree for the first time.
func _ready():
	is_blacklight_on = false
	$ButtonStand.mesh.surface_get_material(0).set_shader_param("emission_energy",0)
	add_to_group("large_room_emissive_stands")

func blacklight(new_value):
	if does_blacklight_affect_stand:
		is_blacklight_on = new_value
		if is_blacklight_on:
			$ButtonStand.mesh.surface_get_material(0).set_shader_param("emission_energy",1.3)
		else:
			$ButtonStand.mesh.surface_get_material(0).set_shader_param("emission_energy",0)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
