extends Node

onready var player = $Player

onready var level_intro = load("res://Scenes/Levels/Intro.tscn")
onready var level_1 = load("res://Scenes/Levels/Level1.tscn")

var depth = 0

var current_level
var current_level_name

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _process(delta):
	depth = player.global_position.y
	var new_level = get_level(depth)
	if new_level != current_level_name:
		load_level(new_level)
	pass

func get_level(depth):
	if depth < 5000:
		return level_intro
	elif depth < 99999999999:
		return level_1

func load_level(load_level):
	var level_obj
	if load_level == level_intro:
		level_obj = level_intro.instance()
	elif load_level == level_1:
		level_obj = level_1.instance()
		level_obj.position = Vector2(0, 5100)
	if current_level != null:
		current_level.free()
	current_level_name = load_level
	current_level = level_obj
	
	current_level.get_node('GameTileMap').connect("clear_tiles", player, "_on_clear_tiles")
	
	add_child(level_obj)