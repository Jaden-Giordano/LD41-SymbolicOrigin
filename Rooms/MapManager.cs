using Godot;
using System;

public class MapManager : TileMap {

    [Signal]
    delegate void DoorTrigger(int direction);

    public override void _Ready() {
        Connect(nameof(DoorTrigger), GetParent(), "_DoorEntered");
    }

    public void _DoorEntered(Godot.Object body, int direction) {
        if ((body as Node).GetName() == "Player") {
            EmitSignal(nameof(DoorTrigger), direction);
        }
    }
}
