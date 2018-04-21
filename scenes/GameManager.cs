using Godot;
using System;

public class GameManager : Node2D {

    [Export]
    public String basePath = "res://Rooms/Room_";
    [Export]
    public int sceneCount = 0;

    private PackedScene[] loadScenes;

    private Node[,] roomsGrid;

    private bool first = false;

    public override void _Ready() {
        roomsGrid = new Node[100, 100];

        loadScenes = new PackedScene[sceneCount];
        for (int i = 0; i < sceneCount; i += 1) {
            loadScenes[i] = (PackedScene) ResourceLoader.Load(basePath + i + ".tscn");
        }
    }

    public Node LoadRoom(Vector2 position, int roomPath = 0) {
        if (first) {
            LoadRoom(new Vector2(50, 50), 0);
            first = false;
        }

        Node room = roomsGrid[(int) position.x, (int) position.y];

        if (room == null) {
            room = loadScenes[roomPath].Instance();
            GetParent().AddChild(room);
        }

        return room;
    }

    public void _DoorEntered(Godot.Object body, int direction) {
        if ((body as Node).GetName() == "Player") {
            GD.Print(direction);
        }
    }
}
