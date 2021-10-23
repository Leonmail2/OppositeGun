extends RigidBody
class_name HoldableObject
signal picked_up
signal dropped

onready var hand_offset = $HandOffset
export var type = "null"

var in_hand = false
var player_ref = null
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func get_grip_offset():
	return $HandOffset.transform.origin

func picked_up(player):
	if in_hand == false:
		emit_signal("picked_up")
		set_mode(MODE_KINEMATIC)
		player.object = self
		player_ref = player
		in_hand = true
		player.object_in_hand = true
		return true
	else:
		emit_signal("attempted_pick_up")
		return false

func dropped(controller_velocity):
	set_mode(MODE_RIGID)
	if in_hand:
		in_hand = false
		sleeping = false
		player_ref = null
		emit_signal("dropped")
		apply_central_impulse(controller_velocity)

func force_ungrip():
	set_mode(MODE_RIGID)
	if in_hand:
		in_hand = false
		sleeping = false
		if player_ref != null:
			player_ref.object = null
			player_ref.object_in_hand = false
			player_ref.object_type = null
			player_ref = null


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
