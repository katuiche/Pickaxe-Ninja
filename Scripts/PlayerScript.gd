extends KinematicBody2D

export (int, 0, 1000) var max_move_speed
export (int, 0, 100) var move_speed_increment
export (int, 0, 1000) var jump_force
export (int, 0, 100) var gravity
export (int, 0, 1000) var max_fall_speed
export (float, 1, 5) var wall_friction
export (bool) var have_pickaxe
export (int, 0, 300) var dig_depth
export (int, 5, 40) var dig_width
 
onready var anim_player = $PlayerAnimation
onready var sprite = $PlayerSprite
onready var pickaxe = $PickAxe

signal clear_tiles(pos_x1, pos_y1, pos_x2, pos_y2)
 
var y_velo = 0
var facing_right = true
var move_speed = 0;
var grounded = is_on_floor()

func _ready():
	play_anim("Idle_B")
	
	
	
	
	
	
 
func _physics_process(delta):
	movement()
	dig()
	
	
	
	
	
 
func flip():
	facing_right = !facing_right
	sprite.flip_h = !sprite.flip_h
	
	
	
	
	
	
 
func play_anim(anim_name):
	if anim_player.is_playing() and anim_player.current_animation == anim_name:
		return
	anim_player.play(anim_name)
	
	
	
	
	

func movement():
	grounded = is_on_floor()
	if Input.is_action_pressed("move_right"):
		move_speed += move_speed_increment
		if move_speed < 0:
			move_speed += move_speed_increment*2
		if is_on_wall() and y_velo > 0 and !grounded:
			if Input.is_action_just_pressed("jump"):
				y_velo = -jump_force
				move_speed = -max_move_speed
			else:
				y_velo /= wall_friction
		else:
			play_anim("Walk");
				
	if Input.is_action_pressed("move_left"):
		move_speed -= move_speed_increment
		if move_speed > 0:
			move_speed -= move_speed_increment*2
		if is_on_wall() and y_velo > 0 and !grounded:
			if Input.is_action_just_pressed("jump"):
				y_velo = -jump_force
				move_speed = max_move_speed
			else:
				y_velo /= wall_friction
		else:
			play_anim("Walk")
				
	if move_speed > max_move_speed:
		move_speed = max_move_speed
		
	if move_speed < -max_move_speed:
		move_speed = -max_move_speed
		
	if is_on_ceiling() and y_velo < 0:
		y_velo = 0

	move_and_slide(Vector2(move_speed, y_velo), Vector2(0, -1))
   

	y_velo += gravity
	if grounded and Input.is_action_just_pressed("jump"):
		y_velo = -jump_force
	if grounded and y_velo >= 5:
		y_velo = 5
	if y_velo > max_fall_speed:
		y_velo = max_fall_speed
   
	if facing_right and move_speed < 0:
		flip()
	if !facing_right and move_speed > 0:
		flip()

	if move_speed != 0 and !Input.is_action_pressed("move_right") and !Input.is_action_pressed("move_left"):
		move_speed /= 2
		if abs(move_speed) < 10:
			move_speed = 0
			
	if Input.is_action_just_released("move_right") or Input.is_action_just_released("move_left") or !is_on_floor():
		_on_PlayerAnimation_animation_finished(anim_player.current_animation)
	

		
func dig():
	if Input.is_action_just_pressed("dig"):
		var direction = 0
		if Input.is_action_pressed("move_up"):
			direction = 90
		elif Input.is_action_pressed("move_down"):
			direction = 270
		elif sprite.flip_h:
			direction = 180
			
		match direction:
			0: emit_signal("clear_tiles", global_position.x, global_position.y-dig_width, global_position.x+dig_depth, global_position.y+dig_width)
			90: emit_signal("clear_tiles", global_position.x-dig_width, global_position.y-dig_depth, global_position.x+dig_width, global_position.y)
			180: emit_signal("clear_tiles", global_position.x-dig_depth, global_position.y-dig_width, global_position.x, global_position.y+dig_width)
			270: emit_signal("clear_tiles", global_position.x-dig_width, global_position.y, global_position.x+dig_width, global_position.y+dig_depth) 







func _on_PlayerAnimation_animation_finished(anim_name):
	if !is_on_floor():
		if y_velo > 0:
			play_anim("Jump_down")
		elif y_velo < 0:
			play_anim("Jump_up")
	else:
		match anim_name:
			"Idle_A":
				if randi()%11+1 > 2:
					play_anim("Idle_AtoB")
				else:
					play_anim("Idle_A")
			"Idle_B":
				if randi()%11+1 > 8:
					play_anim("Idle_BtoA")
				else:
					play_anim("Idle_B")
			"Idle_AtoB":
				play_anim("Idle_B")
			"Idle_BtoA":
				play_anim("Idle_A")
			_:
				play_anim("Idle_B")
				
			

