extends KinematicBody2D

export (int, 0, 1000) var max_move_speed
export (int, 0, 100) var move_speed_increment
export (int, 0, 1000) var jump_force
export (int, 0, 100) var gravity
export (int, 0, 1000) var max_fall_speed
export (float, 1, 5) var wall_friction
export (bool) var have_pickaxe
 
onready var anim_player = $PlayerAnimation
onready var sprite = $PlayerSprite
var PickaxeCollision = preload("res://Objects/PickaxeCollision.tscn")
 
var y_velo = 0
var facing_right = true
var move_speed = 0;
 
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
	var grounded = is_on_floor()
	
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
  

	if grounded:
		if move_speed == 0:
			play_anim("idle")
		else:
			play_anim("walk")
	else:
		play_anim("jump")
		
func dig():
	if Input.is_action_pressed("dig"):
		var direction = 0
		if Input.is_action_pressed("move_up"):
			direction = 1
		elif Input.is_action_pressed("move_down"):
			direction = 3
		elif sprite.flip_h:
			direction = 2
		var pickaxe_collision = PickaxeCollision.instance()
		pickaxe_collision.rotation = direction * 90
		add_child(pickaxe_collision)











