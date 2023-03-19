extends RigidBody2D

var speed = 100
var current_tile
var on_map = false

func _ready():
	Data.player = self

# Called every frame. 'delta' is the elapsed time since the previous frame.
var i = 0
func _process(delta):
	i += 1
	var new_tile = Data.map.get_tile(position)
	on_map = true
	if new_tile == null:
		#print("off map " + str(i))
		on_map = false
	elif new_tile != current_tile:
		new_tile.start_effect()
		if current_tile != null:
			current_tile.end_effect()
		current_tile = new_tile
	
func _integrate_forces(s):
	var lv = Vector2.ZERO
	
	var right = Input.is_action_pressed("d")
	var left = Input.is_action_pressed("a")
	var up = Input.is_action_pressed("w")
	var down = Input.is_action_pressed("s")
	
	if right:
		lv.x += 1
	if left:
		lv.x -= 1
	if up:
		lv.y -= 1 
	if down:
		lv.y += 1
		
	lv = lv.normalized()
	lv *= speed
	
	s.set_linear_velocity(lv)

func die():
	print("dead")
	Data.label.text = "You Have Fallen"
	$ClearTimer.wait_time = 3 
	$ClearTimer.start()


func _on_clear_timer_timeout():
	Data.label.text = ""
