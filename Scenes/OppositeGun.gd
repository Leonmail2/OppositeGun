extends HoldableObject
class_name OppositeGun

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var indicator = $OppositeGunEffects/OppositeGun/Indicator
var is_in_opposite_mode = false setget set_is_in_opposite_mode #can be in opposite or gravity gun mode

var is_gravity_gun_engaged := false setget set_gravity_gun_engaged
var gravity_gun_object = null

export var gravity_gun_acceleration = 6

var can_fire_opposite = true

func reset_can_fire_opposite():
	can_fire_opposite = true

func set_is_in_opposite_mode(new):
	is_in_opposite_mode = new
	if is_gravity_gun_engaged:
		on_trigger_unpressed()
	if is_in_opposite_mode:
		indicator.mesh.surface_get_material(1).set_shader_param("emission",Color(0.760784, 0.376471, 0))
	else:
		print("here")
		indicator.mesh.surface_get_material(1).set_shader_param("emission",Color(0, 0.196078, 0.862745))
	#indicator.mesh.material.set_shader_param("is_in_opposite_mode",is_in_opposite_mode)

func set_gravity_gun_engaged(new):
	is_gravity_gun_engaged = new
	#do cool sounds and effects here
	
	
# Called when the node enters the scene tree for the first time.
func _ready():
	set_is_in_opposite_mode(is_in_opposite_mode)
	force_ungrip()

func _on_Controller_button_pressed(controller_type,button_id):
	if controller_type == "oculus" and button_id == JOY_OCULUS_BY:
		$SwitchModes.play()
		set_is_in_opposite_mode(!is_in_opposite_mode)

func on_trigger_pressed():
	if not is_in_opposite_mode:
		if not is_gravity_gun_engaged:
			$GravityRayCast.force_raycast_update()
			var collision = $GravityRayCast.get_collider()
			print(collision)
			if collision != null and collision.has_method("can_gravity_gun_pick_up"):
				if collision.can_gravity_gun_pick_up():
					is_gravity_gun_engaged = true
					gravity_gun_object = collision
					$GravityGunFiring.playing = true
	else:
		if can_fire_opposite:
			can_fire_opposite = false
			$OppositeRayCast.force_raycast_update()
			var collision = $OppositeRayCast.get_collider()
			print(collision)
			$OppositeGunEffects/AnimationPlayer.play("Recoil")
			$OppositeSoundEffect.play()
			$Timer.start()
			if collision != null and collision.has_method("opposite"):
				collision.opposite()

func on_trigger_unpressed():
	if is_gravity_gun_engaged:
		$GravityGunFiring.stop()
		$GravityGunPowerDown.play()
	is_gravity_gun_engaged = false
	gravity_gun_object = null
		

func picked_up(controller):
	.picked_up(controller)
	indicator.mesh.surface_get_material(1).set_shader_param("emission_energy",2.5)
	#print(indicator.material[1])
	#indicator.material[1].set_shader_param("emission_energy",2.5)

func dropped(controller_velocity):
	.dropped(controller_velocity)
	is_gravity_gun_engaged = false
	gravity_gun_object = null
	indicator.mesh.surface_get_material(1).set_shader_param("emission_energy",0)
	#indicator.material.set_shader_param("emission_energy",0)

func force_ungrip():
	.force_ungrip()
	indicator.mesh.surface_get_material(1).set_shader_param("emission_energy",0)
	#indicator.material.set_shader_param("emission_energy",0)

	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func _physics_process(delta):
	if is_gravity_gun_engaged:
		if gravity_gun_object != null:
			var force_vector = ($GravityGunFocalPoint.global_transform.origin - gravity_gun_object.global_transform.origin)*gravity_gun_acceleration
			gravity_gun_object.set_linear_velocity(force_vector)


func _on_Timer_timeout():
	reset_can_fire_opposite()
