extends Position2D

export(PackedScene) var Bala

var angle = 0
var direction = true
var vectorDirection
var vectorPosition
var timer =0


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	timer+=1
	
	if angle<=-0.3:
		direction = true
	if angle>=0.4:
		direction = false
		 
	if direction:
		rotate(0.01)
		angle += 0.01
	if !direction:
		rotate(-0.01)
		angle -= 0.01
	
	if timer==10 || timer==17 || timer==24:
		
		var bala_instance = Bala.instance()
		vectorPosition = $Sprite2/PositionBullet.global_position - global_position
		bala_instance.pos = vectorPosition
		bala_instance.pos.y -= 190
		bala_instance.pos.x += 30
		print(vectorPosition)
		vectorDirection = $Sprite2/PositionBullet.global_position
		vectorDirection.x = $Sprite2/PositionBullet.global_position.x - global_position.x
		vectorDirection.y = $Sprite2/PositionBullet.global_position.y - global_position.y
		
		bala_instance.dir = vectorDirection
		
		get_parent().add_child(bala_instance)
	if timer>60:
		timer = 0
	pass
