var array
var width
var height

func _init(width,height, value=null):
	self.array = _create_grid(width,height, value)
	self.height = height
	self.width = width
	pass
	
func get(x,y):
	if x > width or x < 0 or y > height or y < 0:
		return null
	return array[y][x]
	
func get_line(y):
	if y > height or y < 0:
		return null
	return array[y]
	
func get_column(x):
	if x > width or x < 0:
		return null
	var column = []
	for c in range(0, array.size()):
		column.append(array[x])
	return column
	
func _create_grid(width, height, value = null):
	var grid = []
	for y in range(0,height):
		grid.append([])
		for x in range(0, width):
			grid[y].append(value)
	return grid
	
func set_circle(x, y, r, value):
	for yy in range(y - (r + 1), y + (r + 1)):
		for xx in range(x - (r + 1), x + (r + 1)):
			if ((xx - x) * (xx - x) + (yy - y) * (yy - y)) <= r * r and xx < width and yy < height and xx >= 0 and yy >= 0 :
				array[yy][xx] = value
				
func set_rectangle(x1, y1, x2, y2, value):
	if x1 > x2:
		var x3 = x1
		x1 = x2
		x2 = x3
		
	if y1 > y2:
		var y3 = y1
		y1 = y2
		y2 = y3
		
	if x1 < 0:
		x1 = 0
	if y1 < 0:
		y1 = 0
	if x2 > width:
		x2 = width
	if y2 > height:
		y2 = height
		
	for y in range(y1, y2):
		for x in range(x1, x2):
			array[y][x] = value
			
func fill(value):
	for y in range(0,height):
		for x in range(0, width):
			array[y][x] = value
			
func set(x,y,value):
	array[y][x] = value
