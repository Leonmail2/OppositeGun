extends RigidBody
signal button_on
signal button_off

var threshold = 0
var button_is_on = false
var cooldown = false
var object_on_button = null
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

#func _integrate_forces(state):
#	var total_force := 0
#	for i in range(0,state.get_contact_count()):
#		print(state.get_contact_impulse(i))
#		total_force += state.get_contact_impulse(i)
#	if cooldown != true:
#		if total_force > threshold and not button_is_on:
#			button_is_on = true
#			emit_signal("button_on")
#			cooldown = true
#			$CooldownTimer.start()
#		elif total_force < threshold and button_is_on:
#			button_is_on = false
#			emit_signal("button_off")
#			cooldown = true
#			$CooldownTimer.start()
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


#func _on_CooldownTimer_timeout():
#	cooldown = false


func _on_Area_body_entered(body):
	if body is RigidBody and body.mode == RigidBody.MODE_RIGID and object_on_button == null:
		if body.mass > 6:
			emit_signal("button_on")
			object_on_button = body


func _on_Area_body_exited(body):
	if body == object_on_button:
		emit_signal("button_off")
		object_on_button = null
