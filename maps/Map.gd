extends Node2D


func _ready() -> void:
	set_camera_limits()
	Input.set_custom_mouse_cursor(load("res://assets/UI/crossair_white.png"), Input.CURSOR_ARROW, Vector2(16, 16))
	$Player.map = $Ground


func set_camera_limits():
	var map_limits = $Ground.get_used_rect()
	var map_cellsize = $Ground.cell_size
	$Player/Camera2D.limit_left = map_limits.position.x * map_cellsize.x
	$Player/Camera2D.limit_right = map_limits.end.x * map_cellsize.x
	$Player/Camera2D.limit_top = map_limits.position.y * map_cellsize.y
	$Player/Camera2D.limit_bottom = map_limits.end.y * map_cellsize.y


func _on_Tank_shoot(bullet, position, direction, target = null):
	var b = bullet.instance()
	add_child(b)
	b.start(position, direction, target)


func _on_Player_dead() -> void:
	GLOBALS.restart()
