extends Polygon2D

@onready var tile_set: Node2D = $"../ResizableTiles"
@onready var snap_points: Node2D = $"../SnapPoints"
@onready var you_win_label: Label = $YouWinLabel

var win = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	win = true
	for i in range(tile_set.get_child_count()):
		if (tile_set.get_child(i).position != snap_points.get_child(i).position):
			win = false
	
	if win:
		you_win_label.visible = true
		await get_tree().create_timer(3.0).timeout
		get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
