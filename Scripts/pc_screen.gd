class_name PCScreen;
extends Node3D;

@export var sub_viewport: SubViewport;
@export var mesh_instance: MeshInstance3D;
@export var area: Area3D;
@export var collision_shape: CollisionShape3D;

var quad_size: Vector2;
var is_mouse_held: bool = false;
var is_mouse_inside: bool = false;
var last_mouse_position_3d = null;
var last_mouse_position_2d: Vector2 = Vector2.ZERO;

func _ready() -> void:
	area.mouse_entered.connect(on_mouse_entered_area);
	setup_mesh();

func setup_mesh() -> void:
	var mesh := mesh_instance.mesh as QuadMesh;
	var material := StandardMaterial3D.new();
	material.albedo_texture = sub_viewport.get_texture();
	material.cull_mode = BaseMaterial3D.CULL_DISABLED;
	
	mesh.material = material;
	mesh.size.x = sub_viewport.size.x / 1024;
	mesh.size.y = sub_viewport.size.y / 1024;
	
	(collision_shape.shape as BoxShape3D).size = Vector3(mesh.size.x, mesh.size.y, 0.1);

func on_mouse_entered_area() -> void:
	is_mouse_inside = true;

func _unhandled_input(event: InputEvent) -> void:
	var is_mouse_event: bool = false;
	
	is_mouse_event = is_mouse_event || event is InputEventMouse;
	is_mouse_event = is_mouse_event || event is InputEventMouseButton;
	is_mouse_event = is_mouse_event || event is InputEventMouseMotion;
	
	if (is_mouse_event && (is_mouse_inside || is_mouse_held)):
		handle_mouse(event as InputEventMouse);
	elif (!is_mouse_event):
		sub_viewport.push_input(event);

func handle_mouse(event: InputEventMouse) -> void:
	var results: Dictionary = find_mouse(event.global_position);
	is_mouse_inside = results["result"];
	handle_mouse_in_position(event, results["position"]);

func handle_mouse_in_position(event: InputEventMouse, position: Vector3):
	quad_size = (mesh_instance.mesh as QuadMesh).size;
	
	if (event is InputEventMouseButton):
		is_mouse_held = event.is_pressed();
	
	var mouse_position_3d: Vector3;
	if (is_mouse_inside):
		mouse_position_3d = area.global_transform.affine_inverse() * position;
		last_mouse_position_3d = mouse_position_3d;
	else:
		if (last_mouse_position_3d != null):
			mouse_position_3d = last_mouse_position_3d as Vector3;
		else:
			mouse_position_3d = Vector3.ZERO;
	
	var mouse_position_2d: Vector2 = Vector2(mouse_position_3d.x, -mouse_position_3d.y);
	mouse_position_2d += quad_size / 2;
	mouse_position_2d /= quad_size;
	mouse_position_2d.x *= sub_viewport.size.x;
	mouse_position_2d.y *= sub_viewport.size.y;
	
	event.position = mouse_position_2d;
	event.global_position = mouse_position_2d;
	
	if (event is InputEventMouseMotion):
		(event as InputEventMouseMotion).relative = mouse_position_2d - last_mouse_position_2d;
	
	last_mouse_position_2d = mouse_position_2d;
	sub_viewport.push_input(event);

func find_mouse(global_position: Vector2):
	var camera: Camera3D = get_viewport().get_camera_3d();
	var from: Vector3 = camera.project_ray_origin(global_position);
	var dist: float = find_further_distance(camera.transform.origin);
	var to: Vector3 = from + camera.project_ray_normal(global_position) * dist;
	
	var parameters := PhysicsRayQueryParameters3D.new();
	parameters.from = from;
	parameters.to = to;
	parameters.collide_with_areas = true;
	parameters.collision_mask = area.collision_layer;
	parameters.collide_with_bodies = false;
	
	var result: Dictionary = get_world_3d().direct_space_state.intersect_ray(parameters);
	var position: Vector3 = Vector3.ZERO;
	if (result.size() > 0):
		position = result["position"] as Vector3;
		return {"result": true, "position": position};
	return {"result": false, "position": position};
	

func find_further_distance(origin: Vector3) -> float:
	var edges := [
		area.to_global(Vector3(quad_size.x / 2, quad_size.y / 2, 0)),
		area.to_global(Vector3(quad_size.x / 2, -quad_size.y / 2, 0)),
		area.to_global(Vector3(-quad_size.x / 2, quad_size.y / 2, 0)),
		area.to_global(Vector3(-quad_size.x / 2, -quad_size.y / 2, 0))
	];
	
	var far_distance: float = 0;
	
	for edge: Vector3 in edges:
		var temp_distance: float = origin.distance_to(edge);
		if (temp_distance > far_distance):
			far_distance = temp_distance;
	
	return far_distance;
