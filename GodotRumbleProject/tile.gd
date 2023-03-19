extends Node2D

var safe_image = preload("res://filler_art/filler_safe_tile.png")
var hole_image = preload("res://filler_art/filler_hole_tile.png")

var texture

var sprite 

var state = 0
var map_pos : Vector2

func set_state(new_state):
	state = new_state
	if new_state == 0:
		if sprite is Sprite2D:
			sprite.texture = safe_image
		texture = safe_image
	elif new_state == 1:
		if sprite is Sprite2D:
			sprite.texture = hole_image
		texture = hole_image

# Called when the node enters the scene tree for the first time.
func _ready():
	sprite = get_node("Sprite2D")
	sprite.texture = texture


func random_state():
	randomize()
	set_state(randi() % Data.state_count)
	

func start_effect():
	if state == 1:
		Data.player.die()
	
func end_effect():
	pass
