extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var scene
# Called when the node enters the scene tree for the first time.

func _ready():
	var VR = ARVRServer.find_interface("OpenVR")
	if VR and VR.initialize():
		get_viewport().arvr = true
		#get_viewport().hdr = false

		OS.vsync_enabled = false
		Engine.target_fps = 90
	else:
		get_tree().quit(-1)
	
	scene = load("res://EntryScene/MainMenu.tscn").instance()
	add_child(scene)
	scene.connect("start_game",self,"load_game")

func load_game():
	scene.queue_free()
	var game = load("res://Level/MainLevel.tscn").instance()
	add_child(game)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
