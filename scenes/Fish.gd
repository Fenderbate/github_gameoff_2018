extends KinematicBody2D


export(float) var FISH_VELOCITY = 300

var dir = Vector2(-1,0)
var pos = Vector2()
var motion = Vector2(1, 0)
func _ready():
	position = pos
	

func _physics_process(delta):
	motion = dir.normalized() * FISH_VELOCITY * delta
	var collision = move_and_collide(motion)
	
	if (collision):
		if (collision.collider.is_in_group("player")):
			collision.collider.hit()
		get_parent().remove_child(self)

	

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
