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
	
	if hand == global_vars.dominant_hand:
		is_dominant_hand = true
	else:
		is_dominant_hand = false
		$InteractionRaycastHover.monitorable = false
		$InteractionRaycastHover.monitoring = false

func trigger_pressed():
	trigger_pressed = true
	var interactor = $InteractionRaycast.get_collider()
	if interactor != null and interactor.has_method("on_interact") and is_dominant_hand == true:
		interactor.on_interact()
	if object_in_hand and object.has_method("on_trigger_pull"):
		object.on_trigger_pull()
	
	if current_hand_interactor != null:
		if current_hand_interactor.type == "interactable_component":
			current_hand_interactor.start_grip(self)
			interactable_component_reference = current_hand_interactor
			interactable_component_gripped = true
	

func trigger_unpressed():
	if object_in_hand and object.has_method("on_trigger_end_pull"):
		object.on_trigger_end_pull()
	if interactable_component_gripped:
		if interactable_component_reference != null:
			interactable_component_reference.end_grip()
		interactable_component_reference = null
		interactable_component_gripped = false

func grip_pressed():
	if current_hand_interactor != null:
		if current_hand_interactor.type == "objectgrip":
			if not object_in_hand:
				var object = current_hand_interactor.get_obj_ref()
				object.picked_up(self,get_tree().get_network_unique_id())
				#object_in_hand = true # this is done on the networked object end
				if object.type == "gun":
					global_vars.current_magazine_type = object.get_magazine_type()
		
		
		if current_hand_interactor.type == "ammoholder":
			current_hand_interactor.spawn_bullet(self)

func grip_unpressed():
	if object == null:
		object_in_hand = false
		object_in_hand = false
	if object_in_hand:
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
	if object_in_hand and object != null:
		if object.type == "gun" or object.type == "objectoffset":
			var object_scale = object.scale
			if not GlobalData.gunsmoothing:
				var grip_pos_offset_transform = object.get_grip_offset()
				var grip_pos_vector_offset = object.global_transform.origin - grip_pos_offset_transform.origin
				object.global_transform = Transform($ItemHolderPos.global_transform.basis,$ItemHolderPos.global_transform.origin + grip_pos_vector_offset)
				object.scale = object_scale
			else:
				#var refpoint = get_parent().global_transform.origin
				#var grip_pos_offset = object.get_grip_offset()
				
				#var itemholderpos = $ItemHolderPos.global_transform
				
				#var target_pos = Transform(itemholderpos.basis,itemholderpos.origin-grip_pos_offset.origin)
				#var current_pos = object.global_transform
				
				#var newpos = current_pos.interpolate_with(target_pos,global_vars.gunsmoothingamount)
				pass
	
				#object.global_transform = newpos
		elif object.type == "object":
			var object_scale = object.scale
			object.global_transform = $ItemHolderPos.global_transform
			object.scale = object_scale
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
	
	var collider = $InteractionRaycast.get_collider()
	var collision_distance = $InteractionRaycast.global_transform.origin.distance_to($InteractionRaycast.get_collision_point())
	if object_in_hand == false:
		if collider != null and collider.has_method("on_interact") and collision_distance < laser_distance and is_dominant_hand == true:
			$Laser.show()
		else:
			$Laser.hide()

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
	if button == JOY_OCULUS_AX:
		if object_in_hand and object.has_method("recive_button_input"):
			object.recive_button_input(button)


func _on_InteractionArea_area_entered(area):
	#print(area)
	if area.has_method("on_interact"):
		current_hand_interactor = area


func _on_InteractionArea_area_exited(area):
	if current_hand_interactor != null and current_hand_interactor == area:
		current_hand_interactor = null
