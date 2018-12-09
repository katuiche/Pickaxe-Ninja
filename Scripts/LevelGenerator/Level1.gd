extends Node2D

var Generator = load('res://Scripts/LevelGenerator/Generator.gd')

onready var tilemap = $GameTileMap
onready var background = $Background

export (int, 10, 1000) var map_width
export (int, 10, 1000) var map_height

func _ready():
	generate()
	background.region_rect.size.x = map_width * tilemap.cell_size.x
	background.region_rect.size.y = map_height * tilemap.cell_size.y
	pass

func generate():
	var generator = Generator.new(map_width,map_height,2)
	#generator.create_cave_perlin(0)
	for c in 50:
		generator.create_cave_perlin_worm(round(rand_range(500,1000)))
	generator.clean_grid()
	generator.draw_to_tilemap(tilemap)
	
