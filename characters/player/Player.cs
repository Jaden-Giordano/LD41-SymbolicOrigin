using Godot;
using System;

public class Player : KinematicBody2D {

    [Export]
    public float speed = 100f;

    public override void _PhysicsProcess(float delta) {
        Vector2 movement = Vector2.Zero;

        if (Input.IsActionPressed("move_up")) {
            movement.y -= 1;
        }
        if (Input.IsActionPressed("move_down")) {
            movement.y += 1;
        }
        if (Input.IsActionPressed("move_left")) {
            movement.x -= 1;
        }
        if (Input.IsActionPressed("move_right")) {
            movement.x += 1;
        }

        MoveAndSlide(movement.Normalized() * speed);
    }
}
