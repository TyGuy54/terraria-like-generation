extends TileMap

# setting a max width and height 
@export var max_x = 500
@export var max_y = 500

# making a new perlin noise 
var noise = FastNoiseLite.new()

@onready var selector = $selector

enum {
	DIRT = 0,
	TREE = 2,
	FLOWERS = 3,
	WATER = 4,
}

func _ready():
	randomize()
	noise.seed = randi()%1000
	noise.domain_warp_fractal_octaves = 0
	noise.domain_warp_fractal_lacunarity = 2.43
	
	generate_level()

# generating the level 
func generate_level():
		for x in max_x:
			var ground = abs(noise.get_noise_2d(x, 0) * 60)
			for y in range(ground, max_y):
				if noise.get_noise_2d(x, y) > -0.25:
					set_cell(0, Vector2i(x, y), DIRT, Vector2i(0, 0)) 
					place_flowers(x, y)
					
func place_flowers(x, y):
	if randi()%2 == 1 and get_cell_source_id(0, Vector2i(x, y-1)) == -1:
		if noise.get_noise_2d(x, y) >= -0.2:
			set_cell(0, Vector2i(x, y-1), TREE, Vector2i(1, 1)) 

func _physics_process(delta):
	if Input.is_action_pressed("m_left"):
		var tile = local_to_map(selector.mouse_pos * 8)
		var tile_id = get_cell_source_id(0, tile)
		
		var new_id = -1
		
		if tile_id != -1:
			if tile_id < 0:
				new_id = (tile_id + 1)
			set_cell(0, tile, new_id)
	
	if Input.is_action_pressed("m_right"):
		var tile = local_to_map(selector.mouse_pos * 8)
		set_cell(0, tile, 0, Vector2i(0, 0)) 
