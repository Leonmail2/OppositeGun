extends BasePhysicsObject


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var is_opposite = false #regularaly small, not always large
export var jump_distance = Vector3()

export var small_mass = 3

export var large_mass = 8

func opposite():
	is_opposite = !is_opposite
	if !is_opposite: #if transforming into large cube
		global_transform.origin += jump_distance 
		mass = large_mass
	else:
		mass = small_mass
	$Small.visible = is_opposite
	$Large.visible = !is_opposite
	$Small2.disabled = !is_opposite
	$Large2.disabled = is_opposite

# Called when the node enters the scene tree for the first time.
func _ready():
	$Small.visible = is_opposite
	$Large.visible = !is_opposite
	$Small2.disabled = !is_opposite
	$Large2.disabled = is_opposite
	if !is_opposite:
		mass = large_mass
	else:
		mass = small_mass
	sleeping = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
