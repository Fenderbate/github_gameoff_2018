extends KinematicBody2D

var bullet_scene=preload("res://scenes/Bullet.tscn")
export (int) var speed_move=250
export(float) var shoot_per_second=5
var shoot_rate
var can_shoot=true
var special=true
var velocity=Vector2()

# Called when the node enters the scene tree for the first time.
func _ready():
	shoot_rate=1/shoot_per_second
	$Shoot_timer.wait_time=shoot_rate
	pass # Replace with function body.

func input():
	
	velocity=Vector2()
	
	if Input.is_action_pressed("up"):
		velocity.y-=1;
	if Input.is_action_pressed("down"):
		velocity.y+=1;
	if Input.is_action_pressed("left"):
		velocity.x-=1
	if Input.is_action_pressed("right"):
		velocity.x+=1	
		
	if Input.is_action_pressed("shoot"):
		
		if can_shoot:
			
			can_shoot=false
			shoot()
			$Shoot_timer.start()
		
	velocity=velocity.normalized()*speed_move	
	
	
	pass

func shoot():
	
	var bullet=bullet_scene.instance()
	bullet.position=$bullet_spawn.position
	get_parent().add_child(bullet)
	
	
	pass	
	
func _physics_process(delta):
	
	input()
	move_and_collide(velocity*delta)
	 
	
	pass	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#print(str($Shoot_timer.time_left))
	pass


func _on_Timer_timeout():
	can_shoot=true
	pass # Replace with function body.
