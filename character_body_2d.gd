extends CharacterBody2D

const SPEED = 100
const JUMP_HEIGHT = 40  
const JUMP_DURATION = 0.3  
const GRAVITY = 400 

var is_jumping = false

func _physics_process(delta: float) -> void:
    handle_movement()
    handle_jump()

    # apply gravity if char not jumping
    if not is_jumping:
        velocity.y += GRAVITY * delta
    move_and_slide()
    
func handle_movement() -> void:
    var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
    if direction != Vector2.ZERO:
        velocity.x = direction.x * SPEED
    else:
        velocity.x = 0

func handle_jump() -> void:
    if Input.is_action_just_pressed("ui_accept") and not is_jumping:
        jump()

func jump() -> void:
    is_jumping = true
    velocity.y = -JUMP_HEIGHT / JUMP_DURATION  #upward velocity

    var tween = create_tween()

    tween.tween_property(self, "position", self.position + Vector2(0, -JUMP_HEIGHT), JUMP_DURATION)
    tween.finished.connect(_on_jump_completed)

func _on_jump_completed() -> void:
    is_jumping = false

