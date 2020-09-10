extends Node2D

export (NodePath) var world_tile_map_path = "./TileMap"

export (PackedScene) var wall_scene = preload("res://Wall.tscn")

const chunk_size := 64

# unit in chunks
export(int) var world_width = 10
export(int) var ground_height = 7
export(int) var wall_spacing = 8

onready var world_tile_map := get_node(world_tile_map_path) as TileMap

func _ready():
    _generate_world()
    
func _process(_delta):
    if Input.is_action_pressed("ui_cancel"):
        get_tree().quit()

func _generate_world() -> void:
    for chunk_x in range(-world_width, world_width + 1):
        var offset := 0
        for tileType in [0, 1, 1]: # depth
            _set_tile(tileType, chunk_x, ground_height + offset)
            offset = offset + 1
            
        if (_should_put_wall(chunk_x)):
            _create_wall(chunk_x)

func _set_tile(tileType : int, chunk_x : int, chunk_y : int) -> void:
    var world_vec := Vector2(_to_world(chunk_x), _to_world(chunk_y))
    var tile_pos := world_tile_map.world_to_map(world_vec)
    world_tile_map.set_cellv(tile_pos, tileType)

func _should_put_wall(chunk_x : int) -> bool:
    # We don't want any wall at x=0
    return chunk_x != 0 and chunk_x % wall_spacing == 0
    
func _create_wall(chunk_x : int) -> void:
    var wall = wall_scene.instance()
    add_child(wall)
    wall.position.y = _to_world(ground_height)
    wall.position.x = _to_world(chunk_x)
    
func _to_world(chunk : int) -> int:
    return chunk * chunk_size
    
func _to_chunk(world : int) -> int:
    return world / chunk_size
