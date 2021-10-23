extends Node2D

const Room = preload("res://src/Stages/Room/Room.tscn")
const Player = preload("res://src/Player/Player.tscn")

var gamemap = [
	'..srr',
	'.rr..',
	'..rrr',
	'err.r'
]

var dungeon = {
}

var start_room = null
var actual_room = null
var actual_position = null

func _ready() -> void:
	var player = Player.instance()
	PlayerStats.connect('player_died', self, 'on_player_died')
	construct_cells()
	map_build()
	add_child(start_room)
	actual_room = start_room
	start_room.init()
	start_room.spawn_player(player)
	Event.connect("player_changed_room", self, "change_room")
	
func change_room(direction):
	call_deferred("remove_child", actual_room)
	self.actual_position += direction
	var new_room = dungeon[self.actual_position]
	call_deferred("add_room", new_room, direction)
	actual_room = new_room
	
func add_room(room, direction):
	add_child(room)
	room.init()
	var player = Player.instance()
	room.spawn_player(player, direction)

func construct_cells():
	for y in gamemap.size():
		for x in gamemap[y].length():
			var room_type = gamemap[y][x]
			if room_type != '.':
				var room = Room.instance()
				dungeon[Vector2(x,y)] = room
				room.room_type = room_type
				if room_type == 's':
					start_room = room
					actual_position = Vector2(x,y)

func map_build():
	for room in dungeon.keys():
		for direction in [Vector2(1,0), Vector2(0,1), Vector2(-1,0), Vector2(0,-1)]:
			var i = direction + room
			if dungeon.has(i):
				create_link(dungeon[room], dungeon[i],direction) 

func create_link(room1, room2, direction):
	room1.connected_rooms[direction] = room2
	room2.connected_rooms[-direction] = room1

func on_player_died():
	print('Il est mort le joueur')
