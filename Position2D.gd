extends KinematicBody2D

export(PackedScene) var Bala
export(PackedScene) var Laser
export(PackedScene) var Fish
export(PackedScene) var Bubble

var angle = 0
var direction = true
var vectorDirection
var vectorPosition
var timer = 0
var timer2 = 0
var counter = 0

onready var state = ShotState.new(self)

const STATE_SHOT   = 0
const STATE_LASER  = 1
const STATE_BUBBLE = 2
const STATE_FISH   = 3


# Called when the node enters the scene tree for the first time.
func _ready():
	
	set_physics_process(true)
	pass # Replace with function body.

func _physics_process(delta):
	state._fixed_process(delta)
	pass
	
func set_state(new_state):
	#state.exit()
	
	if new_state == STATE_SHOT:
		state = ShotState.new(self)
	elif new_state == STATE_LASER:
		state = LaserState.new(self)
	elif new_state == STATE_BUBBLE:
		state = BubbleState.new(self)
	elif new_state == STATE_FISH:
		state = FishState.new(self)
	
	pass
	
	
# class ShotState ----------------------------------------------------

class ShotState:
	var boss
	var timer2 = 0
	func _init(boss):
		self.boss = boss
		
		pass
	
	func _fixed_process(delta):
		boss.timer+=1
		timer2 +=1
		if boss.angle<=-0.3:
			boss.direction = true
		if boss.angle>=0.4:
			boss.direction = false
			 
		if boss.direction:
			boss.rotate(0.01)
			boss.angle += 0.01
		if !boss.direction:
			boss.rotate(-0.01)
			boss.angle -= 0.01
		if boss.timer==10 || boss.timer==17 || boss.timer==24:
			var bala_instance = boss.Bala.instance()
			boss.vectorPosition = boss.get_node("Sprite2/PositionBullet").global_position + boss.position - boss.get_node("Sprite2").global_position
			bala_instance.pos = boss.vectorPosition
			bala_instance.pos.x = boss.get_node("Sprite2").position.x *2.5 
	
			boss.vectorDirection = boss.get_node("Sprite2/PositionBullet").global_position
			boss.vectorDirection.x = boss.get_node("Sprite2/PositionBullet").global_position.x - boss.global_position.x
			boss.vectorDirection.y = boss.get_node("Sprite2/PositionBullet").global_position.y - boss.global_position.y
			
			bala_instance.dir = boss.vectorDirection
			boss.get_parent().add_child(bala_instance)
		
		if boss.timer>60:
			boss.timer = 0
		if timer2 >= 300:
			boss.set_state(boss.STATE_LASER)
			timer2 = 0
		pass
	
	func _exit():
		pass
		
# class LaserState---------------------------------------------------------------------------
class LaserState:
	var boss
	var timer2 = 0
	func _init(boss):
		self.boss = boss
		
		pass
	
	func _fixed_process(delta):
		
		print(timer2)
		if boss.angle!=0.2:
			if boss.angle<=-0.3:
				boss.direction = true
			if boss.angle>=0.4:
				boss.direction = false
			 
			if boss.direction:
				boss.rotate(0.01)
				boss.angle += 0.01
			if !boss.direction:
				boss.rotate(-0.01)
				boss.angle -= 0.01
		else:
			var laser_instance = boss.Laser.instance()
			laser_instance.pos = Vector2(-72,-130)
			
			boss.get_parent().add_child(laser_instance)
			timer2 +=1
		if timer2 >= 50:
			boss.set_state(boss.STATE_FISH)
			timer2 = 0
		pass
	
	func _exit():
		pass
	
# class fishstate-----------------------------------------------------------------------------
class FishState:
	var boss
	var timerFish = 0
	func _init(boss):
		self.boss = boss
		
		pass
	
	func _fixed_process(delta):
		boss.timer+=1
		
		timerFish +=1
		if boss.angle<=-0.3:
			boss.direction = true
		if boss.angle>=0.4:
			boss.direction = false
			 
		if boss.direction:
			boss.rotate(0.01)
			boss.angle += 0.01
		if !boss.direction:
			boss.rotate(-0.01)
			boss.angle -= 0.01
		if boss.timer==10 || boss.timer==17 || boss.timer==24:
			var bala_instance = boss.Bala.instance()
			boss.vectorPosition = boss.get_node("Sprite2/PositionBullet").global_position + boss.position - boss.get_node("Sprite2").global_position
			bala_instance.pos = boss.vectorPosition
			bala_instance.pos.x = boss.get_node("Sprite2").position.x *2.5 
	
			boss.vectorDirection = boss.get_node("Sprite2/PositionBullet").global_position
			boss.vectorDirection.x = boss.get_node("Sprite2/PositionBullet").global_position.x - boss.global_position.x
			boss.vectorDirection.y = boss.get_node("Sprite2/PositionBullet").global_position.y - boss.global_position.y
			
			bala_instance.dir = boss.vectorDirection
			boss.get_parent().add_child(bala_instance)
		
		if timerFish == 10 ||  timerFish == 25 || timerFish == 40 || timerFish == 55 || timerFish == 70:
			var fish_instance = boss.Fish.instance()
			boss.vectorPosition = Vector2(1024,rand_range(-201,200))
			fish_instance.pos = boss.vectorPosition
			boss.get_parent().add_child(fish_instance)
			
		print(timerFish)
		if boss.timer>60:
			boss.timer = 0
		if timerFish >= 300:
			boss.set_state(boss.STATE_BUBBLE)
			timerFish = 0
		pass
	
	func _exit():
		pass
	
# class bubblestate-----------------------------------------------------------------------------
class BubbleState:
	var boss
	var timerBubble = 0
	func _init(boss):
		self.boss = boss
		
		pass
	
	func _fixed_process(delta):
		boss.timer+=1
		
		timerBubble+=1
		if boss.angle<=-0.3:
			boss.direction = true
		if boss.angle>=0.4:
			boss.direction = false
			 
		if boss.direction:
			boss.rotate(0.01)
			boss.angle += 0.01
		if !boss.direction:
			boss.rotate(-0.01)
			boss.angle -= 0.01
		if boss.timer==10 || boss.timer==17 || boss.timer==24:
			var bala_instance = boss.Bala.instance()
			boss.vectorPosition = boss.get_node("Sprite2/PositionBullet").global_position + boss.position - boss.get_node("Sprite2").global_position
			bala_instance.pos = boss.vectorPosition
			bala_instance.pos.x = boss.get_node("Sprite2").position.x *2.5 
	
			boss.vectorDirection = boss.get_node("Sprite2/PositionBullet").global_position
			boss.vectorDirection.x = boss.get_node("Sprite2/PositionBullet").global_position.x - boss.global_position.x
			boss.vectorDirection.y = boss.get_node("Sprite2/PositionBullet").global_position.y - boss.global_position.y
			
			bala_instance.dir = boss.vectorDirection
			boss.get_parent().add_child(bala_instance)
		
		if timerBubble == 10 ||  timerBubble == 40 || timerBubble == 70 || timerBubble == 100:
			var bubble_instance = boss.Bubble.instance()
			boss.vectorPosition = Vector2(rand_range(-701,0),600)
			bubble_instance.pos = boss.vectorPosition
			boss.get_parent().add_child(bubble_instance)
			
		print(timerBubble)
		if boss.timer>60:
			boss.timer = 0
		if timerBubble >= 300:
			boss.set_state(boss.STATE_SHOT)
			timerBubble = 0
		pass
	
	func _exit():
		pass