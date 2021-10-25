extends Spatial
signal button_pressed

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export (NodePath) var GUIParent = null
export var action = 'join'
var highlighted = false
# Called when the node enters the scene tree for the first time.
func _ready():
	$Button.mesh.material.set_shader_param("mode",0)
	
func _on_VRButton_area_entered(area):
	$Button.mesh.material.set_shader_param("mode",1)

func _on_VRButton_area_exited(area):
	$Button.mesh.material.set_shader_param("mode",0)
	
func on_interact():
	emit_signal("button_pressed")

# Called every frame. 'delta' is the elapsed time since the previous frame.
