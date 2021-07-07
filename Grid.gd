extends TileMap

var tile_size = get_cell_size()
var half_tile_size = tile_size / 2
var grid_size = Vector2(16, 16)
var grid = []

onready var Obstacle = preload("res://Obstacle.tscn")

enum ENTITY_TYPES {PLAYER, OBSTACLE, COLLECTIBLE}

func _ready():
	randomize()
	# 1. Create the grid Array
	for x in range(grid_size.x):
		grid.append([])
		for y in range(grid_size.y):
			grid[x].append(null)
	
	var player = get_node("Player")
	var start_pos = update_child_pos(player)
	
	# 2. Create obstacles
	var positions = []
	for n in range(5):
		var grid_pos = Vector2(randi() % int(grid_size.x), randi() % int(grid_size.y))
		if not grid_pos in positions:
			positions.append(grid_pos)
	
	for pos in positions:
		var new_obstacle = Obstacle.instance()
		new_obstacle.position = map_to_world(pos)
		grid[pos.x][pos.y] = ENTITY_TYPES.OBSTACLE
		add_child(new_obstacle)


func is_cell_vacant(pos, direction):
	# Return true if the cell is vacant, else false
	print("is cell vacant")
	var grid_pos = world_to_map(pos) + direction
	if grid_pos.x < grid_size.x and grid_pos.x >= 0 and grid_pos.y < grid_size.y and grid_pos.y >= 0:
		return grid[grid_pos.x][grid_pos.y] == null
	return false


func update_child_pos(child_node):
	# Move a child to a new position in the grid Array
	# Returns the new target world position of the child
	var grid_pos = world_to_map(child_node.position)
	grid[grid_pos.x][grid_pos.y] = null
	
	var new_grid_pos = grid_pos + child_node.velocity
	grid[new_grid_pos.x][new_grid_pos.y] = ENTITY_TYPES.PLAYER  # child_node.type
	
	var target_pos = map_to_world(new_grid_pos)
	return target_pos
