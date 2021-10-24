extends ARVRController
signal joystick_movement

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var laser_distance = 15
onready var global_vars = get_node("/root/GlobalData")

export var press_to_grip = false
var controller_type = "touch"

#sensing whether grip and trigger are pressed
var trigger_val = 0.0
var trigger_pressed = false

var grip_val = 0.0
var grip_pressed = false


#dealing with objects that are gripped
var object_in_hand = false
var object = null
var object_type = null

var interactable_component_gripped = false
var interactable_component_reference = null

var hand = null
var is_dominant_hand = false

var current_hand_interactor = null


#controls if the players hands can interact with anything
var can_interact = true


#related to hand velocity
var controller_velocity = Vector3(0, 0, 0)
var prior_controller_position = Vector3(0, 0, 0)
var prior_controller_velocities = []

# Called when the node enters the scene tree for the first time.
func _ready():
	if get_controller_name() == "touch":
		controller_type = "touch"
	elif get_controller_name() == "vive":
		controller_type = "vive"
	if controller_id == 1:
		hand = "left"
	else:
		hand = "right"
	
	if hand == ProjectSettings.get_setting("game_settings/dominant_hand"):
		is_dominant_hand = true
	else:
		is_dominant_hand = false

func trigger_pressed():
	if object != null and object.has_method("on_trigger_pressed"):
		object.on_trigger_pressed()
	

func trigger_unpressed():
	if object != null and object.has_method("on_trigger_unpressed"):
		object.on_trigger_unpressed()

func grip_pressed():
	if current_hand_interactor != null:
		if current_hand_interactor.type == "objectgrip":
			if not object_in_hand:
				var object = current_hand_interactor.get_obj_ref()
				object.picked_up(self)
				$ItemHolderPos.remote_path = object.get_path()
				#object_in_hand = true # this is done on the networked object end
				if object.type == "gun":
					$ItemHolderPos.transform.origin = $ItemHolderPosDefault.transform.origin + object.get_grip_offset()

func grip_unpressed():
	if object == null:
		object_in_hand = false
	if object_in_hand:
		$ItemHolderPos.remote_path = ""
		object.dropped(controller_velocity)
		object = null
		object_in_hand = false
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#0 is x, 1 is y, 2 is trigger and forth is grip
	#deal with object in hand
	if object_in_hand:
		$Hand.hide()
	else:
		$Hand.show()
		
	#movement stuff
	var joystic_pos = Vector2(get_joystick_axis(0),get_joystick_axis(1))
	if joystic_pos.length() < 0.2:
		emit_signal("joystick_movement",Vector2(0.0,0.0))
	else:
		emit_signal("joystick_movement",joystic_pos)

	#trigger_code
	trigger_val = get_joystick_axis(2)
	if trigger_val > 0.6 and trigger_pressed == false and can_interact:
		trigger_pressed = true
		trigger_pressed()
	if trigger_val < 0.6 and trigger_pressed == true and can_interact:
		trigger_pressed = false
		trigger_unpressed()
	
	if controller_type == "touch":
		grip_val = get_joystick_axis(4)
		if grip_val > 0.6 and grip_pressed == false and can_interact:
			grip_pressed = true
			grip_pressed()
		if grip_val < 0.6 and grip_pressed == true and can_interact:
			grip_pressed = false
			grip_unpressed()

func _physics_process(delta):
	#calculate controller velocity
	if get_is_active():
		controller_velocity = Vector3(0, 0, 0)

		if prior_controller_velocities.size() > 0:
			for vel in prior_controller_velocities:
				controller_velocity += vel

			# Get the average velocity, instead of just adding them together.
			controller_velocity = controller_velocity / prior_controller_velocities.size()

		prior_controller_velocities.append((global_transform.origin - prior_controller_position) / delta)

		controller_velocity += (global_transform.origin - prior_controller_position) / delta
		prior_controller_position = global_transform.origin

		if prior_controller_velocities.size() > 10:
			prior_controller_velocities.remove(0)


func _input(event):
	pass


func _on_Controller_button_pressed(button):
	if object_in_hand and object.has_method("_on_Controller_button_pressed"):
		object._on_Controller_button_pressed("oculus",button)
		


func _on_InteractionArea_area_entered(area):
	#print(area)
	if area.has_method("on_interact"):
		current_hand_interactor = area


func _on_InteractionArea_area_exited(area):
	if current_hand_interactor != null and current_hand_interactor == area:
		current_hand_interactor = null
