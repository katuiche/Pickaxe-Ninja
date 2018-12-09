extends Camera2D

onready var left_border = $LeftBorder
onready var right_border = $RightBorder

var zoom_in = false

func _process(delta):
	var width = get_viewport().size.x
	var height = get_viewport().size.y
	
	left_border.global_position.x = get_camera_screen_center ( ).x -width/2.4
	right_border.global_position.x = get_camera_screen_center ( ).x +width/2.4
	
	left_border.scale.y = height
	right_border.scale.y = height
	
	if Input.is_action_just_pressed('map_zoom'):
		if not zoom_in:
			zoom.x = 10
			zoom.y = 10
			zoom_in = true
		else:
			zoom.x = 0.8
			zoom.y = 0.8
			zoom_in = false
	pass
