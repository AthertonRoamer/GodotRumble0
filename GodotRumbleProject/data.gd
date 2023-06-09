extends Node
signal clear_car

enum{
	SAFE,
	DANGER
}

var player : Node
var map : Node
var label : Label
var door : Node
var world : Node
var carrot_counter
var active = true
var space = false

var phase = 0
var phase_count = 5

var state_count = 2

func advance_phase():
	phase += 1 
	if phase < phase_count:
		map.set_ran_carrot()
	else:
		active = false
		player.die("You have won!!")
		world.get_node("PushSpace").visible = true
		phase = 0
		
func end():
	active = true
	world.get_node("PushSpace").visible = false
	label.text = ""
	player.carrots = 0
	carrot_counter.set_num(0)
	player.position = player.start_pos
	player.set_position(Vector2(793, 404))
	map.set_ran_carrot()
	player.open_door()
	emit_signal("clear_car")
	get_tree().reload_current_scene()
	
	
func kill():
	active = false
	world.get_node("PushSpace").visible = true
	phase = 0
	pass
	
func restart():
	pass
	
func _process(delta):
	if Input.is_action_just_pressed("ui_accept") and active == false:
		end()
	
