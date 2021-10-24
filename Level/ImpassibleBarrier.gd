extends StaticBody


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var is_opposite = false #default is impassible
# Called when the node enters the scene tree for the first time.
func _ready():
	$ImpassibleBarrier/Impassable.visible = true
	$ImpassibleBarrier/Passable.visible = false
	$ImpassibleBarrier/StaticBody/CollisionShape.disabled = false

func opposite():
	is_opposite = !is_opposite
	$ImpassibleBarrier/Impassable.visible = !is_opposite
	$ImpassibleBarrier/Passable.visible = is_opposite
	$ImpassibleBarrier/StaticBody/CollisionShape.disabled = !is_opposite
	if !is_opposite: #impassible
		$ImpassibleBarrier.mesh.surface_get_material(0).set_shader_param("albedo",Color(0.098039, 0.098039, 0.098039, 0.741176))
	else:
		$ImpassibleBarrier.mesh.surface_get_material(0).set_shader_param("albedo",Color(0.098039, 0.098039, 0.098039, 0.20))


	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
