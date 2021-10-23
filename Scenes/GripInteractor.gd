extends Area
signal player_interacted

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var type = "null"

onready var obj_ref = get_node("../")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func on_interact(node):
	emit_signal("player_interacted",node)

func get_obj_ref():
	return obj_ref
