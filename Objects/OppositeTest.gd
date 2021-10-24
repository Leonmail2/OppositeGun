extends RigidBody


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


export var gravity_gun_can_pick_up : bool

func can_gravity_gun_pick_up():
	return gravity_gun_can_pick_up



# Called when the node enters the scene tree for the first time.
func _ready():
	$MeshInstance.show()
	$MeshInstance2.hide()

export var is_opposite = false

func opposite():
	is_opposite = !is_opposite
	$MeshInstance.hide()
	$MeshInstance2.hide()
	if not is_opposite:
		$MeshInstance.show()
	else:
		$MeshInstance2.show()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
