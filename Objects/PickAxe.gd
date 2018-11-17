extends Node2D

onready var pickaxe_sprite = get_node("PickaxeSprite")
onready var player_sprite = get_node( "../PlayerSprite")
onready var player = get_node("..")

export (int, 0,360) var stand_angle

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _process(delta):
	if player.have_pickaxe:
		visible = true
		pickaxe_sprite.flip_h = player_sprite.flip_h
		if player_sprite.flip_h:
			pickaxe_sprite.rotation_degrees = stand_angle
		else:
			pickaxe_sprite.rotation_degrees = -stand_angle
		pass
	else:
		visible = false