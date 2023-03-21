extends Node2D

var safe_image = preload("res://filler_art/filler_safe_tile.png")
var hole_image = preload("res://filler_art/filler_hole_tile.png")

@onready var animatedSprite

var tile_change_time

var animation
var texture
var sprite 

var state = 0
var map_pos : Vector2

# Called when the node enters the scene tree for the first time.
func _ready():
	sprite = get_node("Sprite2D")
	sprite.texture = texture


func set_state(new_state):
	animatedSprite = $AnimatedSprite2D
	var last_state = state
	state = new_state
	match last_state:
		Data.SAFE:
			animatedSprite.play("Green_Safe_Flashing")
			
	match state:
		Data.SAFE:
			animatedSprite.play("Green_Safe_Static")
		Data.DANGER:
			animatedSprite.play("Red_Danger_Static")
		_:
			pass

func random_state():
	randomize()
	set_state(randi() % Data.state_count)
	

func start_effect():
	if state == 1:
		Data.player.die()
	
func end_effect():
	pass
	
func end_effect_of_state(s):
	pass


func _on_timer_timeout():
	
