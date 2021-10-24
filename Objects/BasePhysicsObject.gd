extends RigidBody
class_name BasePhysicsObject
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var gravity_gun_can_pick_up : bool

func can_gravity_gun_pick_up():
	return gravity_gun_can_pick_up
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.




	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
