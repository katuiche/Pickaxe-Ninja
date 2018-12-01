extends TileMap

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

onready var canvas = $canvas

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass


func clear_area(pos_x1, pos_y1, pos_x2, pos_y2, damage):
	canvas.draw_rect(Rect2(Vector2(pos_x1,pos_y1),Vector2(pos_x2,pos_y2)), Color(1.0,0.0,0.0))
	for x in range(pos_x1, pos_x2,cell_size.x): 
		for y in range(pos_y1, pos_y2,cell_size.y):
			set_cellv(world_to_map(Vector2(x, y)), -1)
			

func _on_clear_tiles(pos_x1, pos_y1, pos_x2, pos_y2, damage):
	clear_area(pos_x1, pos_y1, pos_x2, pos_y2, damage)
 