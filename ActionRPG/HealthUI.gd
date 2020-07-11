extends Control


export(NodePath) var health_stats_path
export(Texture) var empty_health_texture
export(Texture) var full_health_texture

onready var health_stats = get_node(health_stats_path)
onready var hearts_container = $HeartsContainer

onready var last_health = health_stats.health

func _add_heart(texture_type : Texture):
    var heart_rect = TextureRect.new()
    heart_rect.texture = texture_type
    hearts_container.add_child(heart_rect)
    
func _add_empty_heart():
    _add_heart(empty_health_texture)
    
func _add_full_heart():
    _add_heart(full_health_texture)

func _populate_hearts():
    for i in range(health_stats.max_health):
        if i < health_stats.health:
            _add_full_heart()
        else:
            _add_empty_heart()

# Called when the node enters the scene tree for the first time.
func _ready():
    #$Label.text = "Health: %s" % health_stats.health
    _populate_hearts()
    health_stats.connect("health_changed", self, "_on_health_changed")

func _on_health_changed():
    var children = hearts_container.get_children()
    var num_hearts_change = sign(health_stats.health - last_health)
    if (num_hearts_change == 0):
        return
    for i in range(last_health, health_stats.health, num_hearts_change):
        if num_hearts_change < 0:
            # health decreased
            children[i - 1].texture = empty_health_texture
        elif num_hearts_change > 0:
            # health increased
            children[i].texture = full_health_texture
    last_health = health_stats.health
