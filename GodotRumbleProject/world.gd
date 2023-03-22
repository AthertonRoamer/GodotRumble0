extends Node2D

var carrot_scene = preload("res://carrot.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	Data.world = self
	
func set_carrot(pos):
	var c = carrot_scene.instantiate()
	c.position = pos
	add_child.call_deferred(c)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
