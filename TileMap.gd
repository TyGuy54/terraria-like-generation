extends TileMap

# setting a max width and height 
@export var max_x = 200
@export var max_y = 200

# making a new perlin noise 
var noise = FastNoiseLite.new()

func _ready():
	# randomize()
	
	# randomizing the seed
	noise.seed = randi()
	# setting the octaves to 0
	noise.domain_warp_fractal_octaves = 0
	#noise.period = 5
	#noise.persistance = 0.588
	# setting the lacunarity to 2.43
	noise.domain_warp_fractal_lacunarity = 2.43
	
	generate_level()

# dubug stuff for resetting the scence and generating a new map
func _unhandled_input(event):
	if event is InputEventMouseButton:
		if event.button_mask == MOUSE_BUTTON_MASK_RIGHT:
			print("Reloading...")
			get_tree().reload_current_scene()

# generating the level 
func generate_level():
		# making a grid that 200X200 using for loops
		for x in max_x:
			for y in max_y:
				# making an id (for the moment this will aloways be 0)
				# to decid what blocks to place
				var tile_id = generate_id(noise.get_noise_2d(x, y))
				# if the id is 0 then place that block on the grid
				if tile_id != -1:
					set_cell(0, Vector2i(x, y), tile_id, Vector2i(1, 1)) 
					

# generates an id to decide weahter or not to place a block
# for now 0 is a dirt block and -1 is an empty block
func generate_id(noise_level: float):
	if noise_level <= 0:
		return -1
	else:
		return 0
