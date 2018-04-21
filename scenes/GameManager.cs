using Godot;
using System;

public class GameManager : Node2D {

    [Export]
    public String basePath = "res://Rooms/Room_";
    [Export]
    public int sceneCount = 0;

    private const int MAP_INDEX_OFFSET = 50;
    private const float MAP_POSITION_OFFSET = 1000;

    private PackedScene[] loadScenes;

    private Node2D[,] roomsGrid;
    private Vector2 currentRoom = Vector2.Zero;

    public override void _Ready() {
        roomsGrid = new Node2D[101, 101];

        loadScenes = new PackedScene[sceneCount];
        for (int i = 0; i < sceneCount; i += 1) {
            loadScenes[i] = (PackedScene) ResourceLoader.Load(basePath + i + ".tscn");
        }

        LoadRoom(new Vector2(0, 0), 0);
    }

    public bool CheckRoom(Vector2 position) {
        if (position.x + MAP_INDEX_OFFSET > 100 || position.x + MAP_INDEX_OFFSET < 0) {
            throw new IndexOutOfRangeException();
        } else if (position.y + MAP_INDEX_OFFSET > 100 || position.y + MAP_INDEX_OFFSET < 0) {
            return false;
        }

        Node room = roomsGrid[(int) position.x + MAP_INDEX_OFFSET, (int) position.y + MAP_INDEX_OFFSET];

        return room != null;
    }

    public Node LoadRoom(Vector2 position, int roomPath = 0) {
        Node2D room = roomsGrid[(int) position.x + MAP_INDEX_OFFSET, (int) position.y + MAP_INDEX_OFFSET];

        if (room == null) {
            room = loadScenes[roomPath].Instance() as Node2D;
            room.Position = position * MAP_POSITION_OFFSET;
            AddChild(room);
        }

        return room;
    }

    public void _DoorEntered(int direction) {
        switch (direction) {
            case 0:
                try {
                    if (CheckRoom(currentRoom - new Vector2(1, 0))) {
                        currentRoom = currentRoom - new Vector2();
                        Node2D camera = (GetNode("Camera2D") as Node2D);
                        camera.Position = camera.Position - new Vector2(MAP_POSITION_OFFSET, 0);
                    } else {
                        
                    }
                } catch (IndexOutOfRangeException e) {}
                break;
            case 1:

                break;
            case 2:

                break;
            case 4:

                break;
        }
    }
}
