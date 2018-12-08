extends Camera2D

onready var left_border = $LeftBorder
onready var right_border = $RightBorder


func _process(delta):
	var width = get_viewport().size.x
	var height = get_viewport().size.y
	
	left_border.global_position.x = get_camera_screen_center ( ).x -width/2.4
	right_border.global_position.x = get_camera_screen_center ( ).x +width/2.4
	
	left_border.scale.y = height
	right_border.scale.y = height
	pass
