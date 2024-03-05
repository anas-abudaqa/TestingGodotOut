extends Area2D


signal entered_spikes
signal entered_lava


func _on_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	##Check which custom data field does the tile satisfy
	if body is TileMap:
		var current_tilemap = body
		var collision_coordinates = current_tilemap.get_coords_for_body_rid(body_rid)
		var tile_data = current_tilemap.get_cell_tile_data(0, collision_coordinates)
		
		if tile_data.get_custom_data_by_layer_id(0):
			print("Entered lava")
			entered_lava.emit()
		if tile_data.get_custom_data_by_layer_id(1):
			print("Entered spikes")
			entered_spikes.emit()
