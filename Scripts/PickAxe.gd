extends Node2D

onready var pickaxe_sprite = get_node("PickaxeSprite")
onready var player_sprite = get_node( "../PlayerSprite")
onready var player = get_node("..")

export (int, 0,360) var stand_angle

func _process(delta):
	visible = player.have_pickaxe
		
func swing(direction):
	if player.have_pickaxe:
		pickaxe_sprite.rotation_degrees = -direction + 90
		z_index = 20
