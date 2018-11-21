extends KinematicBody2D


var speed=500
var velocity=Vector2()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
	
#	pass

func _physics_process(delta):

	velocity=Vector2()
	velocity.x+=1
	velocity=velocity*speed
	var collision=move_and_collide(velocity*delta)
	
	
	# if the collider has a hit method this calls the method
	if collision:
		if collision.collider.has_method("hit"):
			collision.collider.hit()
		
	pass


func _on_VisibilityNotifier2D_viewport_exited(viewport):
	
	queue_free()
	pass # Replace with function body.
