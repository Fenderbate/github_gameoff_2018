extends Node2D

onready var tweenNode = get_node("Position2D/TweenNode")

var is_running = false
var tween1 = true


func _process(delta):
	if !is_running && tween1==true:
		is_running = true
		tweenNode.interpolate_property(self,"position",position,position + Vector2(0,50),100,Tween.TRANS_LINEAR,Tween.EASE_OUT)
		tweenNode.start()
	if !is_running && tween1==false:
		is_running = true
		tweenNode.interpolate_property(self,"position",position,position + Vector2(0,-50),100,Tween.TRANS_LINEAR,Tween.EASE_OUT)
		tweenNode.start()


func _on_TweenNode_tween_completed(object, key):
	is_running = false
	if tween1:
		tween1 = false
	else:
		tween1 = true
