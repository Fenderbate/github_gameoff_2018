extends KinematicBody2D


export(float) var BUBBLE_VELOCITY = 150

var dir = Vector2(0,-1)
var pos = Vector2()
var motion = Vector2(1, 0)
func _ready():
	position = pos
	

func _physics_process(delta):
	motion = dir.normalized() * BUBBLE_VELOCITY * delta
	var collision = move_and_collide(motion)
	
	if (collision):
		if (collision.collider.is_in_group("player")):
			collision.collider.hit()
		get_parent().remove_child(self)

	

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()