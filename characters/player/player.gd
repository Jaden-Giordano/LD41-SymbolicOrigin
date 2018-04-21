extends KinematicBody2D

export(int) var speed

func _ready():
    set_physics_process(true);
    pass

func _physics_process(delta):
    var movement = Vector2(0, 0)

    if Input.is_action_pressed("move_left"):
        movement.x -= 1
        pass
    if Input.is_action_pressed("move_right"):
        movement.x += 1
        pass
    if Input.is_action_pressed("move_up"):
        movement.y -= 1
        pass
    if Input.is_action_pressed("move_down"):
        movement.y += 1
        pass

    move_and_slide(movement.normalized() * speed)

    pass
