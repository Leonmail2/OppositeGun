extends StaticBody

export var light_group = ""
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var is_opposite = false

func toggle_blacklight_elements(value):
	for element in get_tree().get_nodes_in_group(light_group):
		element.blacklight(value)
# Called when the node enters the scene tree for the first time.
func _ready():
	$Light.mesh.surface_get_material(1).set_shader_param("albedo",Color(1,1,1))
	$Light.mesh.surface_get_material(1).set_shader_param("emission",Color(1,1,1))
	$Light/OmniLight.visible = true
	toggle_blacklight_elements(false)

func opposite():
	is_opposite = !is_opposite
	if is_opposite: #if light is off
		$Light.mesh.surface_get_material(1).set_shader_param("albedo",Color(0,0,0))
		$Light.mesh.surface_get_material(1).set_shader_param("emission",Color(0,0,0))
		$Light/OmniLight.visible = false
		toggle_blacklight_elements(true)
	else:
		$Light.mesh.surface_get_material(1).set_shader_param("albedo",Color(1,1,1))
		$Light.mesh.surface_get_material(1).set_shader_param("emission",Color(1,1,1))
		$Light/OmniLight.visible = true
		toggle_blacklight_elements(false)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
