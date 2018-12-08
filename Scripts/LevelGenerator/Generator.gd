var Grid = load('res://Class/Grid.gd')

var grid

func _init(width, height, defaultTile):
	self.grid = create_grid(width, height, defaultTile)

func clean_grid():
	var check = false
	while !check:
		check = true
		for y in range(1, grid.height-1):
			for x in range(1, grid.width-1):
				var points = 0
				points += int(grid.get(x,y-1) != -1)
				points += int(grid.get(x,y+1) != -1)
				points += int(grid.get(x-1,y) != -1)
				points += int(grid.get(x+1,y) != -1)
				if points <= 1 and grid.get(x,y) != -1:
					grid.set(x,y,-1)
					check = false
				if points >= 3 and grid.get(x,y) == -1:
					grid.set(x,y,choose([grid.get(x+1,y), grid.get(x-1,y), grid.get(x,y-1), grid.get(x,y+1)]))
					check = false
	
	
func create_grid(width, height, tile):
	return Grid.new(width, height, tile)
	

func draw_to_tilemap(tilemap):
	for y in range(0, grid.height):
		for x in range(0, grid.width):
			tilemap.set_cell(x,y, grid.get(x,y))
	
	
func create_caves(caves):
	var height = grid.height
	var width = grid.width
	for c in range(caves):
		var worm = {pos = Vector2(round(rand_range(0,width)),round(rand_range(0,height))), size = round(rand_range(3,5))}
		for d in range(rand_range(1,10)):
			worm.pos.x += round(rand_range(-2,2))
			worm.pos.y += round(rand_range(-1,1))
			worm.size += round(rand_range(-1,1))
			grid.set_circle(worm.pos.x, worm.pos.y, worm.size, -1)
	
func choose(array):
	for item in array:
		if item != -1:
			return item
	return -1