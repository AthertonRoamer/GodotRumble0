extends Node2D

var tile_scene = preload("res://tile.tscn")
var terrain : Dictionary = {}
var tile_size = 64
var map_size = Vector2(10, 10)
# Called when the node enters the scene tree for the first time.

var i = 0
func _ready():
	Data.map = self
	for x in range(0, map_size.x):
		for y in range(0, map_size.y):
			var t = tile_scene.instantiate()
			randomize()
			if randi() % 2 == 0:
				t.set_state(Data.SAFE)
			else:
				t.set_state(Data.DANGER)
			t.position = Vector2(x, y ) * tile_size
			t.map_pos = Vector2(x, y)
			add_child(t)
			terrain[Vector2(x, y)] = get_child(i)
			i += 1 
	set_ran_carrot()

func get_tile(pos):
	pos -= position
	pos += Vector2(tile_size / 2, tile_size / 2)
	pos.x = int(pos.x)
	pos.y = int(pos.y)
	var x = pos.x - (int(pos.x) % tile_size)
	var y = pos.y - (int(pos.y) % tile_size)
	x = x / tile_size
	y = y / tile_size
	if terrain.has(Vector2(x, y)):
		return terrain[Vector2(x, y)]
	else:
		return null

func flush_row(num):
	for tile_pos in terrain:
		if tile_pos.y == num:
			terrain[tile_pos].random_state()
	
	

var row_counter : int = 0
func _on_timer_timeout():
	if Data.active:
		flush_row(row_counter)
		row_counter += 1 
		row_counter = row_counter % int(map_size.y)
	
func set_ran_carrot():
	var cx = position.x + (randi() % int(map_size.x)) * tile_size
	var cy = position.y + (randi() % int(map_size.y)) * tile_size
	get_parent().set_carrot(Vector2(cx, cy))
