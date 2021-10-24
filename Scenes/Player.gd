extends KinematicBody


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


var velocity = Vector3()
var gravity_enabled = true
var movement_enabled = true

var movement_joystick_pos = Vector2()
var offhand_joystick_pos = Vector2()


onready var camera = $PlayerContainer/ARVROrigin/ARVRCamera
onready var player_container = $PlayerContainer

onready var left_controller = $PlayerContainer/ARVROrigin/LeftController
onready var right_controller = $PlayerContainer/ARVROrigin/RightController

var footstep_countdown := 0.25
var footstep_interval := 0.25
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	footstep_countdown -= footstep_interval*delta
	if footstep_countdown <= 0:
		pass

func _physics_process(delta):
	$PlayerCollider.global_transform.origin.x = camera.global_transform.origin.x
	$PlayerCollider.global_transform.origin.z = camera.global_transform.origin.z
	if movement_enabled:
		#dealing with movement based on hand position
		if is_on_floor():
			var corrected_direction = Vector3()
			#add vectors from basis onto corrected direction
			corrected_direction += camera.global_transform.basis.x * movement_joystick_pos.x
			corrected_direction += camera.global_transform.basis.z * -movement_joystick_pos.y
			#ensure resulting vector is flat
			corrected_direction.y = 0
			#smoothly interpolate up to speed
			velocity = lerp(velocity,corrected_direction*ProjectSettings.get_setting("game_settings/player_speed"),delta*ProjectSettings.get_setting("game_settings/player_accel"))
			#make sure y velocity doesn't interfere with anything
			velocity.y = 0
	if not is_on_floor() and gravity_enabled:
		velocity.y += -ProjectSettings.get_setting("physics/3d/default_gravity") * delta
	if !movement_enabled:
		velocity.x = 0
		velocity.z = 0
	move_and_slide(velocity,Vector3.UP)
	#rotate player according to blah blah blah
	var t1 = Transform()
	var t2 = Transform()
	var rot = Transform()
	
	t1.origin = -camera.transform.origin
	t2.origin = camera.transform.origin
	rot = rot.rotated(Vector3(0.0, 1.0, 0.0), -ProjectSettings.get_setting("game_settings/turn_rate") * delta*offhand_joystick_pos.x)
	player_container.transform *= t2 * rot * t1


func _on_LeftController_joystick_movement(new_joystick_pos):
	movement_joystick_pos = new_joystick_pos


func _on_RightController_joystick_movement(new_joystick_pos):
	offhand_joystick_pos = new_joystick_pos
