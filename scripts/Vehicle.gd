extends KinematicBody2D

var bullet_scene=preload("res://scenes/Bullet.tscn")
export (int) var speed_move=500
export(float) var shoot_per_second=5
var shoot_rate
var can_shoot=true
var special=true
var velocity=Vector2()
var direction=Vector2()
var acceleration=Vector2(0.2,0.2)
var player_index = 0
	

# Called when the node enters the scene tree for the first time.
func _ready():
	shoot_rate=1/shoot_per_second
	$Shoot_timer.wait_time=shoot_rate
	pass # Replace with function body.


func input():
	
	direction=Vector2()
	
	if Input.is_action_pressed("up"):
		direction.y-=1;
	if Input.is_action_pressed("down"):
		direction.y+=1;
	if Input.is_action_pressed("left"):
		direction.x-=1
	if Input.is_action_pressed("right"):
		direction.x+=1	
	
	if(abs(Input.get_joy_axis(player_index,0)) > 0.2):
		direction.x = Input.get_joy_axis(player_index,0)
	
	if(abs(Input.get_joy_axis(player_index,1)) > 0.2):
		direction.y = Input.get_joy_axis(player_index,1)
	
	direction=direction.normalized()*speed_move
		
	if Input.is_action_pressed("shoot"):
		
		if can_shoot:
			
			can_shoot=false
			shoot()
			$Shoot_timer.start()
		
	pass

func shoot():
	
	var bullet=bullet_scene.instance()
	bullet.position=$bullet_spawn.global_position
	get_parent().add_child(bullet)
	
	
	pass	
	
func _physics_process(delta):
	
	velocity+=Vector2()
	
	input()
	
	velocity.x=lerp(velocity.x,direction.x,acceleration.x)	
	velocity.y=lerp(velocity.y,direction.y,acceleration.y)	
	
	#move_and_collide(velocity*delta)
	move_and_slide(velocity)
	
	
	pass	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#print(str($Shoot_timer.time_left))
	pass


func _on_Timer_timeout():
	can_shoot=true
	pass # Replace with function body.
