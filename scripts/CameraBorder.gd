extends StaticBody2D

var camera_size
export var padding=Vector2(20,20)

func _ready():
	
	#signal to detect if the window is resized
	get_tree().get_root().connect("size_changed",self,"window_resized")
	
	
	camera_size=get_viewport_rect().size
	camera_size+=padding
	
	
	$border_1.global_position=Vector2()-padding
	$border_1.shape.set_extents(Vector2(camera_size.x,padding.y))
	
	$border_2.global_position=Vector2(camera_size.x,0)
	$border_2.shape.set_extents(Vector2(padding.x,camera_size.y))
	
	$border_3.global_position=Vector2(0,camera_size.y)
	$border_3.shape.set_extents(Vector2(camera_size.x,padding.y))
	
	$border_4.global_position=Vector2()-padding
	$border_4.shape.set_extents(Vector2(padding.x,camera_size.y))
	
	pass # Replace with function body.

func window_resized():
	
	camera_size=get_viewport_rect().size
	camera_size+=padding
	
	
	$border_1.global_position=Vector2()-padding
	$border_1.shape.set_extents(Vector2(camera_size.x,padding.y))
	
	$border_2.global_position=Vector2(camera_size.x,0)
	$border_2.shape.set_extents(Vector2(padding.x,camera_size.y))
	
	$border_3.global_position=Vector2(0,camera_size.y)
	$border_3.shape.set_extents(Vector2(camera_size.x,padding.y))
	
	$border_4.global_position=Vector2()-padding
	$border_4.shape.set_extents(Vector2(padding.x,camera_size.y))
	
	pass
