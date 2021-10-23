extends Node2D

onready var title = $CenterContainer/Title
onready var enemies_node = $Ennemis
var enemies_list = []
var enemy_count = 0

var room_clear := false
var connected_rooms = {
	Vector2(1, 0) : null,
	Vector2(0, 1) : null,
	Vector2(-1, 0) : null,
	Vector2(0, -1) : null
}

onready var portals = {
	Vector2(1, 0) : $Portals/PortalLeft,
	Vector2(0, 1) : $Portals/PortalUp,
	Vector2(-1, 0) : $Portals/PortalRight,
	Vector2(0, -1) : $Portals/PortalDown
}
var room_type = ""

func init():
	if room_type == "s":
		title.text = "Start Room"
	elif room_type == "e":
		title.text = "Boss Room"
	else:
		title.text = "Usual Room"
	show_all_portals()
	enemies_list = enemies_node.get_children()
	enemy_count = enemies_list.size()
	
func player_enter():
	if room_clear:
		open_portals()
	else:
		close_portal()
		
func spawn_player(player, direction=null):
	var actual_player = get_node_or_null("Player")
	if actual_player:
		actual_player.queue_free()
		
	var new_position = Vector2.ZERO
	if direction != null:
		var dir_portal = portals[direction]
		new_position = dir_portal.get_spawn_position()
		for portal_key in portals.keys():
			open_portals([dir_portal])
	else:
		new_position = $SpawnPlayer.global_position
	
	add_child(player)
	player.global_position = new_position
		
	if !room_clear:
		activate_enemies(player)
	player_enter()
		
func open_portals(remove_portal: Array = []):
	for portal_key in portals.keys():
			if (!portals[portal_key] in remove_portal) and (connected_rooms[-portal_key] != null):
				portals[portal_key].show()
	
func close_portal():
	for portal_key in portals.keys():
			if (connected_rooms[-portal_key] != null) and (portals[portal_key].visible):
				portals[portal_key].hide()
	
func activate_enemies(player):
	for enemy in enemies_list:
		enemy.activate(player)
		enemy.connect('enemy_died', self, '_on_enemy_died')
	
func show_all_portals():
	if connected_rooms[Vector2(1,0)] == null:
		$Portals/PortalRight.visible = false
	if connected_rooms[Vector2(0,1)] == null:
		$Portals/PortalDown.visible = false
	if connected_rooms[Vector2(-1,0)] == null:
		$Portals/PortalLeft.visible = false
	if connected_rooms[Vector2(0,-1)] == null:
		$Portals/PortalUp.visible = false

func _on_enemy_died():
	enemy_count -= 1
	if enemy_count <= 0:
		open_portals()
		self.room_clear = true
