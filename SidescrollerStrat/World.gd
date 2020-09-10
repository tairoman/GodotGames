extends Node2D

export (NodePath) var world_tile_map_path = "./TileMap"

# size in 64-pixel chunks
export(int) var world_width = 10
export(int) var ground_height = 7

onready var world_tile_map := get_node(world_tile_map_path) as TileMap

func _ready():
    _generate_world()
    
func _process(_delta):
    if Input.is_action_pressed("ui_cancel"):
        get_tree().quit()

func _generate_world():
    for chunk_x in range(-world_width, world_width + 1):
        var offset := 0
        for tileType in [0, 1, 1]: # depth
            _set_tile(tileType, chunk_x, ground_height + offset)
            offset = offset + 1

func _set_tile(tileType : int, chunk_x : int, chunk_y : int):
    var tile_pos := world_tile_map.world_to_map(Vector2(chunk_x * 64, chunk_y * 64))
    world_tile_map.set_cellv(tile_pos, tileType)
