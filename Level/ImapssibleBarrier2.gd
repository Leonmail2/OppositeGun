extends StaticBody


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var is_opposite = false
# Called when the node enters the scene tree for the first time.
func _ready():
	$ImpassibleBarrier2/Impassable.visible = true
	$ImpassibleBarrier2/Passable.visible = false
	$ImpassibleBarrier2/Impassable2.visible = true
	$ImpassibleBarrier2/Passable2.visible = false
	$ImpassibleBarrier2/StaticBody/CollisionShape.disabled = false

func opposite():
	is_opposite = !is_opposite
	$ImpassibleBarrier2/Impassable.visible = !is_opposite
	$ImpassibleBarrier2/Passable.visible = is_opposite
	$ImpassibleBarrier2/Impassable2.visible = !is_opposite
	$ImpassibleBarrier2/Passable2.visible = is_opposite
	$ImpassibleBarrier2/StaticBody/CollisionShape.disabled = is_opposite
	if !is_opposite: #impassible
		$ImpassibleBarrier2.mesh.surface_get_material(0).set_shader_param("albedo",Color(0.098039, 0.098039, 0.098039, 0.741176))
	else:
		$ImpassibleBarrier2.mesh.surface_get_material(0).set_shader_param("albedo",Color(0.098039, 0.098039, 0.098039, 0.20))


	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
