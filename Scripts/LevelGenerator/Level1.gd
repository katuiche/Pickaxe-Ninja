extends "res://Scripts/LevelGenerator/BaseFunctions.gd"

onready var tilemap = $GameTileMap
onready var background = $Background

export (int, 10, 500) var map_width
export (int, 10, 500) var map_height

func _ready():
	generate()
	background.region_rect.size.x = map_width * tilemap.cell_size.x
	background.region_rect.size.y = map_height * tilemap.cell_size.y
	pass

func generate():
	var grid = create_grid(map_width,map_height,1)
	grid = create_caves(grid, 20)
	grid = clean_grid(grid)
	draw_to_tilemap(grid, tilemap)
	pass
