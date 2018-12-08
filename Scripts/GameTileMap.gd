extends TileMap

func clear_area(pos_x1, pos_y1, pos_x2, pos_y2, damage):
	for x in range(pos_x1, pos_x2,cell_size.x): 
		for y in range(pos_y1, pos_y2,cell_size.y):
			if get_cellv(world_to_map(Vector2(x, y))) != -1:
				set_cellv(world_to_map(Vector2(x, y)), -1)
			

func _on_clear_tiles(pos_x1, pos_y1, pos_x2, pos_y2, damage):
	clear_area(pos_x1, pos_y1 - global_position.y, pos_x2, pos_y2 - global_position.y, damage)
 