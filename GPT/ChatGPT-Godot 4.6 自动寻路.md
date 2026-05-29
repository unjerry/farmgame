# Godot 4.6 自动寻路

**User:** Anonymous  
**Created:** 5/21/2026 16:49:19  
**Updated:** 5/21/2026 17:05:58  
**Exported:** 5/29/2026 15:11:46  
**Link:** [https://chatgpt.com/g/g-p-6a0726e9c8d481919ecf0cf10ca9305b-farmgame/c/6a0ec70a-4b8c-83eb-bc1d-4e92489392d4](https://chatgpt.com/g/g-p-6a0726e9c8d481919ecf0cf10ca9305b-farmgame/c/6a0ec70a-4b8c-83eb-bc1d-4e92489392d4)  

## Prompt:
5/21/2026, 4:49:12 PM

我想制作像stardewvalley手机版那种点击自动寻路避障的效果godot4.6可以吗？

## Response:
5/21/2026, 4:49:19 PM

> **Browsing official Godot 4.6 documentation for NavigationAgent2D**
>
> [Godot Engine - Free and open source 2D and 3D game engine](https://godotengine.org/)
> [NavigationRegion2D - Godot Docs](https://docs.godotengine.org/en/stable/classes/class_navigationregion2d.html)
> [Godot (game engine)](https://en.wikipedia.org/wiki/Godot_%28game_engine%29)
> [NavigationAgent2D to act similar to Path2D/PathFollow2D](https://www.reddit.com/r/godot/comments/1018k22/navigationagent2d_to_act_similar_to/)
> [2D Pathfinding in Godot in 2 mins (NavigationRegion2D ...](https://www.youtube.com/watch?v=DHk_LcimhWs)
> [Godot Engine – Multi-platform 2D and 3D game ...](https://github.com/godotengine/godot)
> [Godot 4.5 navigationregion2d and navigationagent2d - Help](https://forum.godotengine.org/t/godot-4-5-navigationregion2d-and-navigationagent2d/122465)
> [2.5D Mapping, Pathfinding and Path Following For Navigation Of A Differential Drive Robot In Uneven Terrain](https://arxiv.org/abs/2209.07252)
>
> **Searching for citations and open docs for 4.6**
>
> [Navigation — Godot Engine (4.6) documentation in English](https://docs.godotengine.org/en/4.6/tutorials/navigation/index.html)
>
> **Considering AStarGrid2D vs Navigation Mesh for Stardew Tile**
>
> I’m thinking about AStarGrid2D versus using a navigation mesh for the Stardew tile. It seems like AStarGrid2D might be an option, but I need to check the official docs to get clarity on its usage before diving into it.
>
> **Comparing AStarGrid2D and navigation meshes for Stardew**
>
> [AStarGrid2D — Godot Engine (stable) documentation in English](https://docs.godotengine.org/en/stable/classes/class_astargrid2d.html)
> [Using the AStarGrid2D class in Godot 4](https://www.youtube.com/watch?v=QRr_P_uqz8w)
> [AStarGrid2D: Unergonomic API behaviour · Issue #119095](https://github.com/godotengine/godot/issues/119095)
> [Godot4 - Using AStarGrid2D and a tilemap : r/godot](https://www.reddit.com/r/godot/comments/14ovldh/godot4_using_astargrid2d_and_a_tilemap/)
> [Bite-Sized Godot: Easier pathfinding with AStarGrid2D](https://shaggydev.com/2022/12/19/godot-astargrid2d/)
>
> **Planning Navigation Method for Stardew-Like Farm Game**
>
> I’m thinking about using AStarGrid2D for a tile-based system in a Stardew-like farm game, instead of NavigationAgent2D. The plan would involve converting global mouse/touch to tiles, computing paths, and moving characters via waypoints, with obstacles from TileMapLayer data. For dynamic NPC avoidance, RVO might work, but AStarGrid2D should suffice for static tiles. I'll need to include a GDScript sample and possibly create an experimental folder for auto-pathfinding. The approach feels solid, but I might hold off on NavigationRegion2D unless smoother movement is needed.
>
> **Designing AutoPathSandbox Scene**
>
> I'm planning out the scene for AutoPathSandbox.tscn with layers for ground and obstacles, along with a player character. I’ll script `AStarGridNavigator.gd` to build an `AStarGrid2D` using a 64x64 cell size. It'll handle obstacles and compute paths from the player to a clicked tile, adjusting for local/global positioning. I need to check TileMapLayer methods, like `local_to_map` and `get_used_rect()`, possibly in Godot 4.6, and confirm the API for these features.
>
> **Designing tile-based pathfinding with AStarGrid2D in Godot**
>
> [TileMapLayer — Godot Engine (4.6) documentation in English](https://docs.godotengine.org/en/4.6/classes/class_tilemaplayer.html)
> [Struggling with local_to_map and TileMaps : r/godot](https://www.reddit.com/r/godot/comments/1dr7v34/struggling_with_local_to_map_and_tilemaps/)
> [Godot 4.6 TileMapLayers Basics – One Tile, Endless ...](https://www.youtube.com/watch?v=ZPKz1zNRR0A)
> [godot/scene/2d/tile_map.cpp at master](https://github.com/godotengine/godot/blob/master/scene/2d/tile_map.cpp)
>
> **Outlining tile-based vs navigation approaches**
>
> For the farm game, I’m suggesting two approaches. First, AStarGrid2D would be best for a 64-tile grid, with obstacles marked as blocked cells, "Stardew-like" style. Second, NavigationAgent2D + NavigationRegion2D would work for more dynamic movement and avoiding both static and dynamic obstacles—though this approach is experimental. Also, mobile touch uses `InputEventScreenTouch` while desktop uses mouse. I'll mention this but avoid overciting, just referring to docs in general.
>
> Thought for 1m 8s

可以做，而且很适合先做成一个独立实验场景验证。 我会先确认 Godot 4.6 的 2D 导航相关 API，再给你一套适合你农场项目的实现计划和最小代码结构。

可以，**Godot 4.6 可以做**。而且你这个项目更适合先用 **AStarGrid2D + TileMapLayer**，不要一开始就上 `NavigationAgent2D`。

原因是：你的农场游戏本质是格子地图，角色虽然看起来平滑移动，但寻路目标最好还是落在格子中心。Godot 4.6 的 `AStarGrid2D` 就是专门给 2D 网格寻路用的，比自己手写 A* 简单很多。官方文档也说明它适合 partial 2D grids，不需要手动创建点和连接。([Godot Engine documentation](https://docs.godotengine.org/en/stable/classes/class_astargrid2d.html?utm_source=chatgpt.com))

## 推荐方案

做一个独立实验：

```text
res://experiments/click_pathfinding/
  scenes/ClickPathfindingSandbox.tscn
  scripts/ClickMovePlayer.gd
```

场景结构大概这样：

```text
ClickPathfindingSandbox: Node2D
  TileLayers: Node2D
    GroundLayer: TileMapLayer
    ObstacleLayer: TileMapLayer
    ObjectLayer: TileMapLayer
  Player: CharacterBody2D
    Sprite2D
    CollisionShape2D
```

逻辑是：

1. 点击屏幕或鼠标左键。
2. 把点击位置转成 TileMapLayer 的格子坐标。
3. 用 `AStarGrid2D` 找从玩家当前格子到目标格子的路径。
4. 玩家按路径点一个一个走过去。
5. 水、墙、石头、箱子、建筑、作物等格子标记为 solid，不可走。

`TileMapLayer` 本身就有 `local_to_map()`、`map_to_local()`、`get_used_rect()`、`get_cell_source_id()` 这些方法，很适合做“世界坐标 ⇄ 格子坐标”的转换。([Godot Engine documentation](https://docs.godotengine.org/en/4.6/classes/class_tilemaplayer.html?utm_source=chatgpt.com))

## 最小可跑脚本示例

挂到 `Player: CharacterBody2D` 上：

```gdscript
class_name ClickMovePlayer
extends CharacterBody2D

@export var ground_layer: TileMapLayer
@export var obstacle_layers: Array[TileMapLayer] = []

@export var speed: float = 140.0
@export var stop_distance: float = 4.0
@export var allow_diagonal: bool = false

var astar := AStarGrid2D.new()
var path: PackedVector2Array = PackedVector2Array()
var path_index: int = 0

func _ready() -> void:
	rebuild_navigation_grid()

func rebuild_navigation_grid() -> void:
	if ground_layer == null:
		push_error("ClickMovePlayer: ground_layer is not assigned.")
		return

	var used_rect := ground_layer.get_used_rect()

	astar.region = used_rect
	astar.cell_size = Vector2(64, 64)

	if allow_diagonal:
		astar.diagonal_mode = AStarGrid2D.DIAGONAL_MODE_ONLY_IF_NO_OBSTACLES
	else:
		astar.diagonal_mode = AStarGrid2D.DIAGONAL_MODE_NEVER

	astar.update()

	# 没有地面的格子不可走
	for y in range(used_rect.position.y, used_rect.end.y):
		for x in range(used_rect.position.x, used_rect.end.x):
			var cell := Vector2i(x, y)
			var has_ground := ground_layer.get_cell_source_id(cell) != -1
			astar.set_point_solid(cell, not has_ground)

	# 障碍层里有 tile 的格子不可走
	for layer in obstacle_layers:
		if layer == null:
			continue

		for cell in layer.get_used_cells():
			if used_rect.has_point(cell):
				astar.set_point_solid(cell, true)

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			request_move_to_world_position(get_global_mouse_position())

	if event is InputEventScreenTouch:
		if event.pressed:
			var world_pos := get_canvas_transform().affine_inverse() * event.position
			request_move_to_world_position(world_pos)

func request_move_to_world_position(world_pos: Vector2) -> void:
	var target_cell := ground_layer.local_to_map(ground_layer.to_local(world_pos))
	var start_cell := ground_layer.local_to_map(ground_layer.to_local(global_position))

	if not astar.region.has_point(target_cell):
		return

	if astar.is_point_solid(target_cell):
		return

	var cell_path: Array = astar.get_id_path(start_cell, target_cell)

	if cell_path.is_empty():
		path.clear()
		path_index = 0
		return

	path.clear()

	for cell in cell_path:
		var local_center := ground_layer.map_to_local(cell)
		var global_center := ground_layer.to_global(local_center)
		path.append(global_center)

	# 路径第一个点通常是玩家当前格子中心，可以跳过
	if path.size() > 1:
		path_index = 1
	else:
		path_index = 0

func _physics_process(_delta: float) -> void:
	if path_index >= path.size():
		velocity = Vector2.ZERO
		move_and_slide()
		return

	var target := path[path_index]
	var distance := global_position.distance_to(target)

	if distance <= stop_distance:
		path_index += 1

		if path_index >= path.size():
			velocity = Vector2.ZERO
			move_and_slide()
			return

		target = path[path_index]

	var direction := global_position.direction_to(target)
	velocity = direction * speed
	move_and_slide()
```

## 关键判断

你的项目里我建议这样分层：

```text
GroundLayer     可走地面：草地、土路、石砖
SoilLayer       可走或特殊处理：耕地
PathLayer       可走：道路
WaterLayer      不可走
ObjectLayer     不可走：石头、树、箱子、建筑、机器
BuildingLayer   不可走
```

初版只需要把 `ObjectLayer`、`WaterLayer`、`BuildingLayer` 放进 `obstacle_layers`。

## 什么时候用 NavigationAgent2D？

`NavigationAgent2D` 也能做寻路和避障，官方文档说它可以让 2D agent 寻路到目标位置，并避开静态和动态障碍，动态避障使用 RVO。不过它在 4.6 文档里仍标注为 experimental，而且需要每个物理帧调用 `get_next_path_position()` 更新内部路径逻辑。([Godot Engine documentation](https://docs.godotengine.org/en/stable/classes/class_navigationagent2d.html))

所以我建议：

```text
现在这个农场游戏：
优先 AStarGrid2D

以后如果做很多 NPC 人群互相避让：
再考虑 NavigationAgent2D / NavigationObstacle2D
```

## 下一步建议

先让 Codex 做一个独立实验，不要直接改主项目。目标是：

```text
点击地图任意可走格子
玩家自动走过去
遇到石头、水、墙会绕路
点击不可走格子时不移动
```

等这个实验稳定了，再接入你现在的 `Player`、`ToolManager`、`TileMapLayer` 系统。

---

**Sources:**

- [AStarGrid2D — Godot Engine (stable) documentation in English](https://docs.godotengine.org/en/stable/classes/class_astargrid2d.html?utm_source=chatgpt.com)

## Prompt:
5/21/2026, 4:51:03 PM

可是外来mob都是移动碰撞体，我们还是用最通用的好一些

## Response:
5/21/2026, 4:51:12 PM

> **Browsing Godot 4.6 documentation for navigation solutions**
>
> [NavigationAgent2D - Godot Docs](https://docs.godotengine.org/en/stable/classes/class_navigationagent2d.html)
> [Godot Engine - Free and open source 2D and 3D game engine](https://godotengine.org/)
> [Godot (game engine)](https://en.wikipedia.org/wiki/Godot_%28game_engine%29)
> [Navigation on TileMap in Godot 4](https://www.reddit.com/r/godot/comments/zxmqte/navigation_on_tilemap_in_godot_4/)
> [Godot Engine – Multi-platform 2D and 3D game engine](https://github.com/godotengine/godot)
> [Godot Engine 4 - Apps on Google Play](https://play.google.com/store/apps/details?id=org.godotengine.editor.v4)
> [2D Pathfinding with Godot 4!](https://www.youtube.com/watch?v=zr_prddvLYM)
> [How to use NavigationObstacle2D - Help - Godot Forum](https://forum.godotengine.org/t/how-to-use-navigationobstacle2d/70782)
> [V-RVO: Decentralized Multi-Agent Collision Avoidance using Voronoi Diagrams and Reciprocal Velocity Obstacles](https://arxiv.org/abs/2102.13281)
>
> **Searching for citations and official documentation sources**
>
> [NavigationAgent2D — Godot Engine (stable) documentation in English](https://docs.godotengine.org/en/stable/classes/class_navigationagent2d.html)
>
> **Reviewing game AI navigation recommendations**
>
> I’m thinking I might need to consult the official docs for the most up-to-date info—specifically the stable version 4.6. It’s looking like a hybrid approach with navmesh for players and mobs, and collision for final decisions could work. I’ll need to double-check the Godot API for NavigationAgent2D properties and set_velocity.
>
> **Revising Godot NavigationAgent2D solution and docs**
>
> [NavigationAgent2D — Godot Engine (stable) documentation in English](https://docs.godotengine.org/en/stable/classes/class_navigationagent2d.html)
>
> **Clarifying usage of NavigationObstacle2D**
>
> I’m realizing I need to clarify that not all moving collision bodies should be NavigationObstacle2D. After all, NavigationObstacle2D is more for avoidance and not pathfinding. I’ll have to double-check the docs to verify this and make sure I’m on the right track with the explanation!
>
> **Verifying NavigationObstacle2D usage in documentation**
>
> [NavigationObstacle2D - Godot Docs](https://docs.godotengine.org/en/stable/classes/class_navigationobstacle2d.html)
> [How to use navigation obstacle 2D? : r/godot](https://www.reddit.com/r/godot/comments/1c6gqtm/how_to_use_navigation_obstacle_2d/)
> [Master Tilemap PATHFINDING & Obstacle Avoidance in ...](https://www.youtube.com/watch?v=yT22SXYpoYM)
> [Obstacles in pathfinding do not work - Navigation - Godot Forum](https://forum.godotengine.org/t/obstacles-in-pathfinding-do-not-work/59417)
> [Hi Godoters! Has anyone managed to use the Navigation ...](https://www.facebook.com/groups/godotengine/posts/1746331188836801/)
> [Add RVO NavigationMesh Obstacle Planes for ...](https://github.com/godotengine/godot-proposals/issues/4522)
> [Navigation Functions for Convex Potentials in a Space with Convex Obstacles](https://arxiv.org/abs/1605.00638)
>
> **Finalizing approach for player click and navigation**
>
> I’m thinking of including a generic example for player click, but I might avoid making separate files for it. I’ll give a plan with references to official docs, as I need to be careful in citing everything browsed. Also, I’ll clarify NavigationObstacle2D's role: it influences path velocities, not physics collisions. I’ll need to check the 4.6 docs to be sure about RVO and NavigationAgent usage instead of older references.
>
> **Documenting player click behavior and navigation obstacles**
>
> [Using NavigationAgents — Godot Engine (latest) documentation in English](https://docs.godotengine.org/en/latest/tutorials/navigation/navigation_using_navigationagents.html)
>
> **Looking up stable 4.6 documentation**
>
> I need to check lines 9394 onward from the stable 4.6 version, not the latest one. The search results are only pulling up 4.0 and the most recent version. I’ll manually search for the 4.6 documentation URL to make sure I’m getting the right information.
>
> **Locating open lines from stable 4.6 version**
>
> [Using NavigationAgents — Godot Engine (4.6) documentation in English](https://docs.godotengine.org/en/4.6/tutorials/navigation/navigation_using_navigationagents.html)
>
> **Checking for dynamic obstacle info**
>
> I think I need to check lines around 9200 for details on dynamic obstacles. I’m trying to get the right information, and it seems that’s where it might be covered. I’ll open those lines to see if they contain what I need on this specific topic.
>
> **Searching for open lines for dynamic obstacles**
>
> [Using NavigationObstacles — Godot Engine (4.6) documentation in English](https://docs.godotengine.org/en/4.6/tutorials/navigation/navigation_using_navigationobstacles.html)
>
> **Creating project-level plan for navigation system**
>
> I think I need to provide a clear plan for the user, possibly stating: "你这判断是对的，但要分清三层：pathfinding, avoidance, physics". I'll lay out the project: static map with NavRegion, NavAgent on every moving entity, optional NavigationObstacle2D for moving barriers, and CharacterBody2D for final collision. I'll clarify that avoidance doesn't affect pathfinding, just safe velocity. I'll also consider minimal code based on official scripts but adapted for clicks and _unhandled_input. I’ll cite factual statements where necessary, like tilemap navigation shapes.
>
> Thought for 56s

你说得对：如果以后场景里有会移动的 mob、NPC、临时障碍，那只靠 `AStarGrid2D` 会越来越难维护。更通用的架构应该转向 Godot 的 2D Navigation 系统。

你这个判断是对的。**如果以后有外来 mob、NPC、动物、怪物、玩家互相挤路，应该用更通用的 `NavigationAgent2D + NavigationRegion2D + 避障` 方案。**

我前面说 `AStarGrid2D`，更适合“纯格子、静态障碍”的农场地图。你现在考虑的是长期架构，那应该改成下面这个方向。

## 更适合我们的方案

核心结构：

```text
地图静态可走区域：
NavigationRegion2D / TileMapLayer navigation polygon

玩家 / NPC / mob：
CharacterBody2D
  Sprite2D
  CollisionShape2D
  NavigationAgent2D

不会主动走路但会移动的障碍：
CharacterBody2D / AnimatableBody2D
  CollisionShape2D
  NavigationObstacle2D
```

`NavigationAgent2D` 本来就是 Godot 用来“寻路到目标，并避开静态/动态障碍”的 2D agent。官方文档也明确说它支持 static 和 dynamic obstacles，并且动态避障用的是 RVO。它还要求设置 `target_position` 后，每个物理帧调用 `get_next_path_position()` 更新路径逻辑。([Godot Engine documentation](https://docs.godotengine.org/en/stable/classes/class_navigationagent2d.html))

但是要注意一个关键点：**避障不是物理碰撞，也不是重新寻路。** Godot 文档说明，avoidance 有自己的空间，不知道物理碰撞和导航网格本身；它只是根据 agent / obstacle 的圆形半径算一个 `safe_velocity`。所以最终还是要保留 `CharacterBody2D + CollisionShape2D + move_and_slide()` 作为最后的物理兜底。([Godot Engine documentation](https://docs.godotengine.org/en/4.6/tutorials/navigation/navigation_using_navigationagents.html))

## 我建议我们改成这个架构

不要叫“点击寻路系统”，应该叫：

```text
NavigationActor 系统
```

玩家、NPC、mob 都统一用它。

```text
Player
  CharacterBody2D
  NavigationAgent2D
  CollisionShape2D

MobBase
  CharacterBody2D
  NavigationAgent2D
  CollisionShape2D

NPCBase
  CharacterBody2D
  NavigationAgent2D
  CollisionShape2D
```

点击移动只是玩家的一种输入方式：

```gdscript
player.move_to(clicked_world_position)
```

mob 追人也是同一个接口：

```gdscript
mob.move_to(player.global_position)
```

NPC 回家也是同一个接口：

```gdscript
npc.move_to(home_position)
```

这就比 `AStarGrid2D` 通用了很多。

## 最小脚本可以这样写

挂到 `Player`、`MobBase`、`NPCBase` 都可以：

```gdscript
class_name NavigationActor2D
extends CharacterBody2D

@export var movement_speed: float = 120.0
@export var can_click_move: bool = false

@onready var navigation_agent: NavigationAgent2D = $NavigationAgent2D

func _ready() -> void:
	navigation_agent.velocity_computed.connect(_on_velocity_computed)

	# 开启动态避障
	navigation_agent.avoidance_enabled = true
	navigation_agent.radius = 18.0
	navigation_agent.max_speed = movement_speed
	navigation_agent.path_desired_distance = 8.0
	navigation_agent.target_desired_distance = 8.0

func _unhandled_input(event: InputEvent) -> void:
	if not can_click_move:
		return

	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			move_to(get_global_mouse_position())

	if event is InputEventScreenTouch:
		if event.pressed:
			var world_pos := get_canvas_transform().affine_inverse() * event.position
			move_to(world_pos)

func move_to(world_position: Vector2) -> void:
	navigation_agent.target_position = world_position

func _physics_process(_delta: float) -> void:
	if NavigationServer2D.map_get_iteration_id(navigation_agent.get_navigation_map()) == 0:
		return

	if navigation_agent.is_navigation_finished():
		velocity = Vector2.ZERO
		move_and_slide()
		return

	var next_path_position := navigation_agent.get_next_path_position()
	var wanted_velocity := global_position.direction_to(next_path_position) * movement_speed

	if navigation_agent.avoidance_enabled:
		navigation_agent.set_velocity(wanted_velocity)
	else:
		_apply_velocity(wanted_velocity)

func _on_velocity_computed(safe_velocity: Vector2) -> void:
	_apply_velocity(safe_velocity)

func _apply_velocity(new_velocity: Vector2) -> void:
	velocity = new_velocity
	move_and_slide()
```

然后玩家节点设置：

```text
can_click_move = true
```

mob / NPC 设置：

```text
can_click_move = false
```

这样玩家点击、NPC 行走、mob 追踪，都是同一个底层。

## 关于 TileMapLayer 怎么接导航

你的地图还是可以继续用 `TileMapLayer`。Godot 的 TileMapLayer 支持给 tile 添加 collision、occlusion、navigation shapes，所以地面 tile 可以有 navigation polygon，墙、水、石头等不要给 navigation polygon。([Godot Engine documentation](https://docs.godotengine.org/en/4.6/tutorials/2d/using_tilemaps.html))

建议分层：

```text
GroundLayer      有 navigation，可走
PathLayer        有 navigation，可走
WaterLayer       没 navigation，有 collision
WallLayer        没 navigation，有 collision
ObjectLayer      没 navigation，有 collision
```

也就是说：

```text
可走区域 = navigation
物理阻挡 = collision
动态避让 = NavigationAgent2D / NavigationObstacle2D
```

这三个不要混成一个东西。

## mob 应该怎么处理？

主动走路的 mob，**不要只做 `NavigationObstacle2D`**。

它应该是：

```text
Mob: CharacterBody2D
  CollisionShape2D
  NavigationAgent2D
```

因为 mob 自己也要寻路、追人、巡逻、逃跑。只要它的 `NavigationAgent2D.avoidance_enabled = true`，其他 agent 就可以在 avoidance 层里避开它。Godot 文档里也说，只有同一个 navigation map 上并且注册了 avoidance 的 agent，才会被避障计算考虑。([Godot Engine documentation](https://docs.godotengine.org/en/4.6/tutorials/navigation/navigation_using_navigationagents.html))

`NavigationObstacle2D` 更适合这些东西：

```text
移动推车
掉下来的石块
临时堵路的机器
会移动但不是“自己寻路”的物体
```

而且动态 obstacle 应该用 `radius`，因为 Godot 文档说动态障碍可以每帧移动，不会有额外重建成本；但它也提醒动态障碍在拥挤或狭窄空间里不是可靠的硬约束。([Godot Engine documentation](https://docs.godotengine.org/en/4.6/tutorials/navigation/navigation_using_navigationobstacles.html))

## 重要限制

这里有一个坑：

**动态 mob 不会让路径重新绕一条大路。**

它只会让角色在局部速度上避让。官方文档也明确说 avoidance 不影响 pathfinding，它只是给“不能高效重新烘焙导航网格的移动物体”提供额外避障。([Godot Engine documentation](https://docs.godotengine.org/en/4.6/tutorials/navigation/navigation_using_navigationagents.html))

所以实际效果是：

```text
远距离绕墙、水、建筑：
靠 NavigationRegion2D / TileMap navigation

近距离避开 mob / NPC / 动物：
靠 NavigationAgent2D avoidance

真的撞上了：
靠 CharacterBody2D collision 兜底
```

这才是比较稳的三层结构。

## 我们现在的实验计划应该改成这样

新建独立实验：

```text
res://experiments/click_navigation_agent/
  scenes/ClickNavigationAgentSandbox.tscn
  scripts/NavigationActor2D.gd
  scripts/TestMob.gd
```

实验目标：

```text
1. TileMapLayer 提供可走导航区域
2. 玩家点击地图自动走过去
3. 玩家能绕开墙、水、建筑等静态阻挡
4. 场景里放 3 个移动 mob
5. 玩家和 mob 会互相避让
6. 如果避让失败，CharacterBody2D 碰撞兜底，不穿模
```

你的想法是对的。**我们不要先做格子 A\*，直接做 `NavigationAgent2D` 版更适合作为长期底座。**

---

**Sources:**

- [NavigationAgent2D — Godot Engine (stable) documentation in English](https://docs.godotengine.org/en/stable/classes/class_navigationagent2d.html)

## Prompt:
5/21/2026, 4:52:53 PM

这样，我要去和codex一起合作，想让她一个场景一个场景，脚本内一个函数一个函数推进教我，如何给我现在的玩家场景做避障寻路。
我如何和她说

## Response:
5/21/2026, 4:53:01 PM

> **Deciding whether to browse for updated Godot 4.6 information**
>
> User is looking for guidance on how to tell Codex something related to Godot 4.6. They haven't specifically requested updates via the web, though Godot's API might be relevant. While I could respond based on prior knowledge, I might need to browse to ensure the information is current.
>
> **Browsing official Godot 4.6 documentation for updates**
>
> [NavigationAgent2D - Godot Docs](https://docs.godotengine.org/en/stable/classes/class_navigationagent2d.html)
> [Godot (game engine)](https://en.wikipedia.org/wiki/Godot_%28game_engine%29)
> [Control Avoidance in NavigationAgent2D : r/godot](https://www.reddit.com/r/godot/comments/1c127n3/control_avoidance_in_navigationagent2d/)
> [NavigationAgent2D changes target_position · Issue #106268](https://github.com/godotengine/godot/issues/106268)
> [2D Pathfinding with Godot 4!](https://www.youtube.com/watch?v=zr_prddvLYM)
> [Entity with NagivationAgent2D and avoidance script from ...](https://forum.godotengine.org/t/entity-with-nagivationagent2d-and-avoidance-script-from-godot-docs-moves-excessively-slowly/69252)
> [[SOLVED] NavigationObstacle ignored by NavigationAgent](https://godotforums.org/d/36037-solved-navigationobstacle-ignored-by-navigationagent)
> [2D Navigation in Godot 4 - Stephan Bester - Medium](https://stephan-bester.medium.com/2d-navigation-in-godot-4-b710902e609c)
>
> **Crafting answer for Codex in Chinese with instructions**
>
> I need to create a response with a step-by-step template for the user to send to Codex. This includes guidance for handling files and scenes, avoiding breaking existing code, and integrating specific behaviors. I'll include clear instructions in Chinese while emphasizing the need for confirmation at each step, as per the user's preferences.
>
> Thought for 20s

可以，我会把它整理成一段你可以直接发给 Codex 的“合作说明”，重点是让她不要一次性大改，而是按场景、节点、函数逐步推进。

可以，你可以直接把下面这段发给 Codex。重点是：**不要让她一次性重构玩家系统，而是先做独立实验，再一点点接入现有 Player 场景。**

---

你可以这样说：

```text
我们现在在做一个 Godot 4.6 的 2D top-down 农场游戏，类似 Stardew Valley 手机版。

我想给现有玩家场景做“点击目标点后自动寻路 + 避障移动”的系统。  
请你不要一次性大改项目，也不要直接替换我现有的 Player 脚本。我们要一个场景一个场景、一个函数一个函数地推进，并且每一步都教我为什么这样做。

目标效果：

1. 玩家点击地图上的某个位置。
2. 玩家自动走到目标位置。
3. 玩家能绕开静态障碍，比如墙、水、建筑、石头。
4. 玩家能尽量避开移动中的 mob、NPC、动物。
5. 如果避障失败，仍然依靠 CharacterBody2D 的物理碰撞兜底，不能穿模。
6. 未来 NPC、mob、动物也能复用同一套 NavigationActor2D 移动逻辑。

请优先使用 Godot 4.6 的通用 2D Navigation 系统：

- CharacterBody2D
- CollisionShape2D
- NavigationAgent2D
- NavigationRegion2D 或 TileMapLayer navigation
- 必要时使用 NavigationObstacle2D

不要优先使用 AStarGrid2D，因为我们以后有移动 mob，不只是静态格子障碍。

请先做一个独立实验，不要直接改主游戏：

res://experiments/click_navigation_agent/

建议结构：

res://experiments/click_navigation_agent/
  scenes/ClickNavigationAgentSandbox.tscn
  scripts/NavigationActor2D.gd
  scripts/ClickNavigationPlayer.gd
  scripts/TestMob.gd

第一阶段只做实验场景：

1. 创建一个简单地图。
2. 添加 NavigationRegion2D 或 TileMapLayer navigation。
3. 添加一个 Player，节点结构为：

Player: CharacterBody2D
  Sprite2D
  CollisionShape2D
  NavigationAgent2D

4. 让 Player 点击地图后移动到目标点。
5. 先不接入背包、工具、交互、耕地系统。
6. 先不要改主项目 Player.gd。

第二阶段再加移动 mob：

Mob: CharacterBody2D
  Sprite2D
  CollisionShape2D
  NavigationAgent2D

让 mob 在几个点之间巡逻，测试玩家和 mob 是否能互相避让。

第三阶段才接入我现有的 Player 场景：

1. 先读取我现有的 Player.tscn 和 Player.gd。
2. 告诉我当前 Player 的移动逻辑在哪里。
3. 不要直接删除旧逻辑。
4. 先新增 move_to(world_position: Vector2) 函数。
5. 再新增 handle_click_move_input(event) 函数。
6. 再新增 update_navigation_movement(delta) 函数。
7. 最后再考虑如何和键盘移动、工具使用、交互系统共存。

请每一步都按这个格式回答：

【本步目标】
这一小步要完成什么。

【要改的文件】
列出具体文件路径。

【要改的节点】
列出场景里要添加或修改的节点。

【代码】
只给本步需要的代码，不要一次性给完整大重构。

【为什么这样做】
解释这一小步的原因。

【我如何测试】
告诉我在 Godot 编辑器里怎么运行、怎么看是否成功。

【成功标准】
比如：点击地面后玩家能移动到目标点。

【失败时检查】
列出可能的错误，比如 NavigationRegion2D 没有覆盖地图、NavigationAgent2D 没有连接 velocity_computed、collision layer/mask 设置不对等。

注意：

- 不要一次性完成所有功能。
- 不要把我的 Player 系统整体推翻。
- 每次只推进一个最小可测试步骤。
- 优先保证可运行，再慢慢变复杂。
- 每次改动之前先说明，不要直接大面积改文件。
- 代码要适配 Godot 4.6。
- 移动逻辑要保留 CharacterBody2D + move_and_slide() 作为物理兜底。
- NavigationAgent2D 只负责寻路和避障建议速度，不要让它替代物理碰撞。
```

---

另外你可以补一句更强硬的：

```text
请你像老师一样带我做，不要像自动重构工具一样一次性改完。  
我希望每一步都能运行测试，通过后我再让你继续下一步。
```

这个很重要。因为 Codex 很容易一口气改太多文件，你会不知道哪里坏了。

你的方向应该是：

```text
先实验场景验证 NavigationActor2D
再接入现有 Player
再让 mob / NPC 复用
最后才整合到正式地图
```

Godot 的 `NavigationAgent2D` 本来就是用于 2D 角色寻路到目标位置，并处理静态和动态障碍避让；开启 avoidance 后，需要通过 `velocity_computed` 拿到安全速度，再让父级 `CharacterBody2D` 移动。官方文档也提醒，`get_next_path_position()` 应该在物理帧中持续调用，用来更新 agent 的路径状态。([Godot Engine documentation](https://docs.godotengine.org/en/stable/classes/class_navigationagent2d.html?utm_source=chatgpt.com))

所以你跟 Codex 合作时，核心原则就是：

```text
NavigationAgent2D 负责“想往哪里走”
CharacterBody2D 负责“实际怎么移动”
CollisionShape2D 负责“最后不要穿模”
```

这套结构最适合你现在这个农场游戏长期扩展。

---

**Sources:**

- [NavigationAgent2D - Godot Docs](https://docs.godotengine.org/en/stable/classes/class_navigationagent2d.html?utm_source=chatgpt.com)



---
Powered by [ChatGPT Exporter](https://www.chatgptexporter.com)