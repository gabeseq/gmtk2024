extends Polygon2D

@onready var hitbox: CollisionPolygon2D = $Area2D/CollisionPolygon2D
@onready var tile: Polygon2D = $"."
@onready var snap_points: Node2D = $"../../SnapPoints"
@onready var INITIAL_SCALE = tile.global_scale

const DEFAULT_SCALE = Vector2(1,1)
const MIN_SCALE = 0.5
const MAX_SCALE = 2.0
const SCALE_INCREMENT = 0.1


var dragging = false
var hovering = false
var tile_offset = 0
var scale_factor = 1.0
var my_snap_point = null
var is_snapped = false
var update_scale = false
var testnode: Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hitbox.polygon = tile.polygon
	hitbox.global_position = tile.global_position
	tile.global_scale = DEFAULT_SCALE
	for pt in snap_points.get_children():
		if pt.get_meta("id") == tile.get_meta("id"):
			my_snap_point = pt

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	hitbox.polygon = tile.polygon
	hitbox.global_position = tile.global_position
	if my_snap_point != null and abs(tile.position.x - my_snap_point.position.x) < 32 and abs(tile.position.y - my_snap_point.position.y) < 32 and abs(tile.global_scale - INITIAL_SCALE) <= Vector2(2*SCALE_INCREMENT, 2*SCALE_INCREMENT):
		tile.color = Color(0, 255, 0)
		is_snapped = true
	else:
		tile.color = Color(1,0,1)
		is_snapped = false
	
	if is_snapped and not dragging:
		tile.position = my_snap_point.position
		tile.global_scale = INITIAL_SCALE
	pass
	
func _input(event):
	if hovering and Input.is_action_pressed("ScrollUp"):
		if scale_factor == MAX_SCALE:
			pass
		get_bigger()
		tile.global_scale = DEFAULT_SCALE * scale_factor
		tile.global_position = event.global_position
	if hovering and Input.is_action_pressed("ScrollDown"):
		if scale_factor == MIN_SCALE:
			pass
		get_smaller()
		tile.global_scale = DEFAULT_SCALE * scale_factor
		tile.global_position = event.global_position
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if (hovering):
			# Start dragging if the click is inside the polygon.
			if not dragging and event.pressed:
				dragging = true
				tile_offset = tile.global_position - event.global_position
			# Stop dragging if the button is released.
			if dragging and not event.pressed:
				dragging = false
		else:
			dragging = false

	if event is InputEventMouseMotion and dragging:
		# While dragging, move the tile with the mouse.
		tile.global_position = event.global_position + tile_offset

func _on_area_2d_mouse_entered() -> void:
	hovering = true

func _on_area_2d_mouse_exited() -> void:
	hovering = false

func get_smaller() -> void:
	scale_factor -= SCALE_INCREMENT
	if scale_factor < MIN_SCALE:
		scale_factor = MIN_SCALE
	
func get_bigger() -> void:
	scale_factor += SCALE_INCREMENT
	if scale_factor > MAX_SCALE:
		scale_factor = MAX_SCALE
