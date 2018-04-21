using Godot;
using System;

public class Player : KinematicBody2D {
    [Export]
    public int doorTileIndex = 3;

    [Export]
    public float speed = 100f;

    public override void _Process(float delta) {
        TileMap tileMap = GetParent() as TileMap;
        Vector2 tileCoords = tileMap.WorldToMap(this.Position);
        if (tileMap.GetCell((int) tileCoords.x, (int) tileCoords.y) == doorTileIndex) {
            GD.Print("Door entered.");
        }
    }

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

        MoveAndSlide(movement * speed);
    }
}
