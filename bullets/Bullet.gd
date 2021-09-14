extends Area2D


export (int) var speed
export (int) var damage
export (float) var lifetime


var velocity = Vector2.ZERO


func start(position, direction):
	self.position = position
	rotation = direction.angle()
	$Lifetime.wait_time = lifetime
	velocity = direction * speed


func _process(delta: float) -> void:
	position += velocity * delta


func explode():
	velocity = Vector2.ZERO
	$Sprite.hide()
	$Explosion.show()
	$Explosion.play('smoke')


func _on_Bullet_body_entered(body: Node) -> void:
	explode()
	if body.has_method("take_damage"):
		body.take_damage(damage)


func _on_Lifetime_timeout() -> void:
	explode()


func _on_Explosion_animation_finished() -> void:
	queue_free()
