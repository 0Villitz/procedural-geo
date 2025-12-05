Procedural Geometry Learning Roadmap (Godot)

This document outlines a step-by-step, professor-style learning roadmap for developing procedural geometry systems in Godot. Each phase includes goals, methodology, assignments, success criteria, and reflection prompts. Suggested reading topics are included for further study and reference.

# Phase 0 - Foundation: MeshData & Builder

**Goal**

Establish a data-driven procedural geometry foundation by separating raw mesh data from engine-specific mesh objects.

**Pre-flight Knowledge**

Before starting this phase, review:  
\- Godot's Mesh system: ArrayMesh, SurfaceTool, and MeshInstance3D  
\- GDScript syntax for arrays and dictionaries  
\- The @tool keyword and how scripts run inside the Godot editor

**Methodology**

Follow a data-oriented design approach similar to professional game engines. Separate geometry data structures from rendering objects. Build a minimal, reusable MeshData type containing attributes like positions, normals, tangents, uvs, colors, and indices. Implement a MeshBuilder to convert MeshData to an ArrayMesh using add_surface_from_arrays().

**Assignments**

• Define a MeshData struct/class containing PackedVector arrays for positions, normals, tangents, uvs, colors, and indices.

• Implement a MeshBuilder.build(mesh_data) function that creates an ArrayMesh surface via add_surface_from_arrays().

• Refactor your existing procedural plane script to populate MeshData and pass it through MeshBuilder.build().

• Create a small test scene to validate MeshData → ArrayMesh → MeshInstance3D rendering in both runtime and editor.

**Success Criteria**

• The plane renders successfully in both editor and game modes.

• Swapping between different geometry datasets (e.g., triangle vs plane) requires no builder modification.

• All MeshData attributes correctly populate ArrayMesh surfaces (visible in the debugger).

**Failsafe Readiness Checklist**

• Can you describe what each MeshData attribute represents and when it's required?

• Can you rebuild the plane mesh from scratch without referencing the tutorial?

• Have you verified correct mesh behavior with and without normals?

• Can you explain the relationship between MeshData and ArrayMesh?

• Have you tested rebuilds in both runtime and editor mode?

**Reflection**

• Why is separating mesh data from the builder beneficial?

• How does this pattern appear in professional engines like Unity or Unreal?

**Suggested Reading & Research Topics**

• Godot Docs - Procedural Geometry tutorial

• Game Engine Architecture (Jason Gregory) - Geometry and Rendering chapter

• Data-Oriented Design principles in geometry processing

• Godot Engine source: ArrayMesh.add_surface_from_arrays() implementation

# Phase 1 - Topology, Indices, and Hard Edges**

**Goal**

Develop a working understanding of indexed geometry, triangle winding order, and the treatment of hard edges through vertex duplication.

**Pre-flight Knowledge**

Before beginning:  
\- Review vector cross products and how to compute surface normals.  
\- Understand counter-clockwise (CCW) winding and backface culling in 3D rendering.  
\- Review how to visualize mesh normals using ImmediateMesh or debug lines.  
\- Refresh vector and matrix math fundamentals if needed.

**Methodology**

Indexed geometry allows vertex reuse between triangles, reducing memory and improving performance. However, for flat-shaded meshes, each face must have unique vertices with identical normals. The winding order of triangles determines whether they face toward or away from the camera. Following standard CCW winding ensures consistent normal direction and predictable backface culling.

**Assignments**

• Implement a cube generator with 24 unique vertices (4 per face) using indices for 12 triangles.

• Compute per-face normals using the cross product: (B - A) × (C - A). Assign these normals to all four vertices of each face.

• Add a toggle for backface culling and wireframe rendering for debugging purposes.

• Visualize face normals in-scene using ImmediateMesh or line gizmos to verify outward direction.

• Test an intentionally flipped winding order on one cube face to see how backface culling behaves.

• Log vertex and triangle counts to confirm 24 vertices and 12 triangles.

• Save this cube generator for reuse in future phases (UV mapping and shading).

**Success Criteria**

• Cube renders with six distinct flat-shaded faces.

• All normals point outward and are visually verifiable using debug lines.

• Flipped winding order hides the inverted face when culling is enabled.

• Vertex and triangle counts match theoretical expectations (24 verts, 12 tris).

**Failsafe Readiness Checklist**

• Have you confirmed all normals point outward and face culling behaves correctly?

• Can you describe triangle winding direction and identify CCW vs CW visually?

• Have you verified vertex and triangle counts numerically?

• Can you modify this cube generator to create a prism or pyramid using the same indexing logic?

• Did you save your cube generator for reuse in future UV and shading phases?

**Reflection**

• Why is vertex duplication required for flat-shaded meshes?

• What are the practical implications of incorrect winding order in rendering engines?

• How does proper indexing improve GPU performance and memory efficiency?

**Suggested Reading & Research Topics**

• OpenGL or DirectX documentation - Winding and backface culling fundamentals.

• GameDev StackExchange: Why do hard edges require vertex duplication?

• Blender Manual: Normal splitting and shading modes.

• Real-Time Rendering (Akenine-Möller) - Triangle rasterization and surface orientation.

# Phase 2 - UVs and Seams

**Goal**

Understand how UV mapping works, why seams require vertex duplication, and how to verify UV correctness visually and numerically.

**Pre-flight Knowledge**

Before starting this phase:  
\- Review 2D texture coordinate space (U,V ∈ \[0,1\]) and how it maps to pixels.  
\- Know how Godot's StandardMaterial3D uses UVs to sample textures.  
\- Understand axis-aligned planar projection and how to compute:  
• U = x / width (for XZ projection)  
• V = z / height (for XZ projection)  
\- Recall that each face's UV range should fill \[0,1\]×\[0,1\].

**Methodology**

Procedural UV generation treats geometry as a projection target. Planar projection derives UVs from vertex positions; seams appear where projection direction changes (e.g., cube faces). Every seam means duplicated vertices because each copy carries a different UV pair. This principle also applies to hard edges and tangent seams.

**Assignments**

• Implement planar UV mapping for your plane and cube. Allow selecting projection axis (X, Y, Z).

• Color mesh by UV (e.g., Color(uv.x, uv.y, 0)) to visualize mapping.

• Log vertex count before and after UV assignment to detect duplicates.

• Add an option for rotated planar projection (90° rotations).

• Test UVs on a non-uniformly scaled cube to observe distortion.

• Document how vertex duplication fixes texture misalignment.

• Save UV-mapped cube for later smooth/tangent tests.

**Success Criteria**

• UVs align per face (no stretching or overlap).

• Duplicated vertices appear only at seams (vertex count increase).

• Rotated projections behave predictably.

• You can explain seams → duplication both conceptually and mathematically.

**Failsafe Readiness Checklist**

• Can you derive planar UVs mathematically for any axis?

• Did you verify vertex duplication numerically?

• Have you tested UVs under both color-by-UV and textured material?

• Can you reuse this logic for cylinders/spheres later?

• Do you understand how UV seams affect tangent calculation (Phase 5)?

**Reflection**

• How are UV seams similar to hard-edge normals?

• Why can't one vertex have two UV coordinates?

• How will different primitives require different projection logic?

**Suggested Reading & Research Topics**

• Texturing and Modeling: A Procedural Approach - UV Mapping chapters.

• LearnOpenGL - Texture Coordinates & Mapping.

• SIGGRAPH Course: Real-Time Rendering of Surfaces.

• Godot Docs - StandardMaterial3D UV usage.

# Phase 3 - Smooth vs Flat Shading

**Goal**

Learn to compute smooth normals by averaging per-face normals, understand vertex sharing's impact on shading, and establish a basis for later tangent-space calculations.

**Pre-flight Knowledge**

Before beginning:  
\- Review vector normalization and why unit length is necessary for lighting accuracy.  
\- Refresh the Lambert lighting model (N·L) and its relation to vertex normals.  
\- Learn how to visualize normals using ImmediateMesh or debug lines.  
\- Review how vertex sharing works in indexed geometry and its effects on smoothing.

**Methodology**

In flat shading, one normal is used per face, resulting in sharp edges. In smooth shading, normals are averaged from all faces sharing a vertex to create a soft lighting transition. Proper normalization of averaged normals ensures correct lighting response. This technique underpins both real-time shading and tangent-space normal mapping.

**Assignments**

• Reuse your UV-mapped cube from Phase 2 and implement smooth shading by averaging normals for shared vertices.

• Create a parametric sphere (latitude/longitude grid) and compute vertex normals by averaging adjacent face normals.

• Write a function: generate_normals(mesh_data, mode='flat'/'smooth'), ensuring normalized output.

• Add debug visualization: draw normal lines to confirm direction and normalization.

• Compare flat vs smooth shading in a scene with directional lighting and a neutral material (Lambert or StandardMaterial3D).

• Duplicate one edge of your cube to create an intentional hard edge and observe shading differences.

• Save both mesh versions for use in Phase 5 (tangent computation).

**Success Criteria**

• Flat-shaded and smooth-shaded versions display visibly distinct results under identical lighting.

• All normals are correctly normalized (|n| ≈ 1).

• Debug lines show uniform, outward-facing normals.

• You can explain how vertex sharing affects shading smoothness and memory cost.

**Failsafe Readiness Checklist**

• Have you verified numerically that all normals are normalized?

• Can you compute averaged normals mathematically from face normals?

• Have you confirmed visual correctness on both cube and sphere meshes?

• Can you intentionally produce or remove hard edges by controlling vertex duplication?

• Do you understand how this links to tangent-space generation in Phase 5?

**Reflection**

• How does smooth shading improve visual continuity while increasing vertex data size?

• What trade-offs exist between visual fidelity and computational cost?

• Why does tangent-space normal mapping rely on accurate per-vertex normals?

**Suggested Reading & Research Topics**

• Blender Manual - Flat vs Smooth shading.

• GPU Gems - Normal Averaging and Interpolation.

• Mathematics for 3D Game Programming and Computer Graphics - Vector Operations.

• Real-Time Rendering (Akenine-Möller) - Surface Shading Equations.

# Phase 4 - Parametric Primitives

**Goal**

Generate procedural geometry using parametric equations and iterative loops (u/v, angle, height). Ensure correct topology, UVs, and normals for each primitive and prepare for later tangent-space generation.

**Pre-flight Knowledge**

Before beginning:  
\- Review trigonometric functions (sin, cos) and how they describe circular geometry.  
\- Understand how parameters (segments, radius, height) map to vertex loops.  
\- Review index buffer assembly for grids (planes) and radial meshes (cylinders, spheres).  
\- Familiarize yourself with parametric coordinates (u, v) in mathematical surfaces.  
\- Learn to verify geometry in wireframe mode and visualize winding order using backface culling.

**Methodology**

Parametric geometry defines vertices through equations or loop iteration. A plane, cylinder, and sphere can all be created with nested loops over parameters (u/v). Each primitive introduces unique topological challenges: grids require quad splitting, cylinders require seam duplication and caps, and spheres require pole management. The key is consistent winding, UV continuity, and matching vertex attributes (normals, tangents).

**Assignments**

• Implement a Plane generator using nested u/v loops (width, height, seg_x, seg_y). Build triangles from quads (two per cell).

• Build a Cylinder generator using parameters: radius, height, radial_segments, height_segments, include top/bottom caps.

• Create a Sphere generator using latitude (θ) and longitude (φ) loops. Handle poles by duplicating vertices to prevent UV pinching.

• Ensure proper winding order (CCW) and consistent normal direction across all primitives.

• Apply UV generation logic from Phase 2 for each primitive (planar, cylindrical, spherical projections).

• Add debug options: wireframe mode, vertex count overlay, and normal visualization.

• Compare your procedural results with Godot's built-in primitives to confirm correctness.

• Document vertex/triangle formulas for each primitive and validate through printed debug output.

**Success Criteria**

• Each primitive generates correctly with consistent topology and expected vertex/triangle counts.

• Normals and UVs appear continuous except at designed seams or poles.

• Adjusting segment counts updates mesh resolution predictably.

• Generated meshes match the visual output of equivalent built-in Godot primitives.

**Failsafe Readiness Checklist**

• Can you derive vertex positions mathematically for each shape (plane, cylinder, sphere)?

• Have you verified index ordering visually in wireframe?

• Did you implement seam duplication for UV continuity?

• Can you explain why spheres need duplicated poles for UV stability?

• Do you understand how this step prepares for future tangent and modifier computations?

**Reflection**

• How do parametric definitions generalize to any procedural primitive (torus, cone, etc.)?

• Why does incorrect winding cause inverted lighting?

• What challenges arise in maintaining UV and normal consistency across seams and poles?

**Suggested Reading & Research Topics**

• Procedural Modeling in Computer Graphics (SIGGRAPH).

• Game Programming Gems - Mesh Generation Algorithms.

• Blender Source: mesh_primitives.c - reference implementation for primitive shapes.

• Mathematics for 3D Game Programming - Parametric Surfaces and Subdivision.

• Godot Docs: ProceduralMesh generation tutorials.

# Phase 5 - Normals and Tangents Pipeline

**Goal**

Automate attribute generation for procedural meshes by computing normals and tangents. Establish a reliable tangent-space pipeline for normal mapping and shading fidelity consistent with modern rendering standards.

**Pre-flight Knowledge**

Before starting:  
\- Review the relationship between surface normals, tangents, and bitangents (TBN matrix).  
\- Understand UV mapping continuity and why tangents require valid UVs.  
\- Study the MikkTSpace standard and its consistency guarantees across tools.  
\- Review Godot's internal tangent computation (SurfaceTool.generate_tangents).

**Methodology**

Tangents and normals form an orthogonal basis used for tangent-space normal mapping. Each vertex tangent aligns with the U direction of the UV map, the bitangent aligns with V, and the normal defines surface orientation. For accuracy, tangents must be derived from vertex positions and UV gradients. Consistency with MikkTSpace ensures compatibility with normal maps from DCC tools.

**Assignments**

• Implement automatic normal generation supporting flat, smooth, and angle-threshold modes.

• Compute tangents manually using the UV-derivative method, verifying orthogonality with normals.

• Compare your tangents to Godot's built-in SurfaceTool-generated tangents to validate correctness.

• Visualize tangents and bitangents using debug lines (e.g., red = tangent, green = bitangent, blue = normal).

• Test with a normal-mapped material to confirm proper lighting behavior.

• Document and compare results between your custom generator and Godot's implementation.

• Research how tangent-space errors manifest visually (e.g., flipped shading, seams).

**Success Criteria**

• Tangents align with UV direction and appear orthogonal to normals.

• Normal-mapped materials render correctly under dynamic lighting without visible artifacts.

• Custom tangent generation closely matches Godot's built-in method.

• Angle-threshold normal generation correctly transitions between smooth and hard shading.

**Failsafe Readiness Checklist**

• Can you compute tangents from UV and position data mathematically?

• Did you confirm orthogonality (dot products near zero) between tangent, bitangent, and normal?

• Can you identify visual errors caused by incorrect tangent basis?

• Did you validate your tangent generation against Godot's SurfaceTool output?

• Do you understand why consistent tangent-space conventions are vital across pipelines?

**Reflection**

• Why must tangents be consistent across modeling tools and engines?

• What causes visual artifacts when tangent bases are mismatched?

• How does automating normal and tangent computation simplify procedural workflows?

**Suggested Reading & Research Topics**

• MikkTSpace specification (industry standard for tangent-space consistency).

• Real-Time Rendering (Akenine-Möller) - Tangent-space shading.

• GPU Gems - Tangent Basis Computation.

• Godot Docs: SurfaceTool.generate_tangents() and normal/tangent visualization.

• Unity Manual: Normal and Tangent calculation reference (for comparison).

# Phase 6 - Modifiers (Mesh → Mesh)

**Goal**

Learn to modify existing procedural meshes non-destructively using data-oriented design principles. Transform and combine MeshData structures without rebuilding primitives from scratch.

**Pre-flight Knowledge**

Before starting:  
\- Review matrix transforms (Transform3D, basis, and origin) and their effects on positions and normals.  
\- Understand vector transformation (normals should use basis rotation only, not translation).  
\- Review the concept of modifier stacks in DCC tools like Blender or Houdini.  
\- Study data-oriented workflows that separate geometry operations from scene nodes.

**Methodology**

Modifiers operate directly on MeshData-pure data in, pure data out-mirroring modifier stacks used in tools such as Blender or Houdini. Each modifier performs a predictable transformation on the arrays (positions, normals, uvs, etc.), which makes the system composable and reusable.

**Assignments**

• Implement a TransformModifier: apply Transform3D to positions and rotate normals via transform.basis.

• Implement a RecomputeNormalsModifier: regenerate normals using flat or smooth modes.

• Implement a UVProjectModifier: create planar and cubic UV projections based on Phase 2 logic.

• Implement a MergeModifier: concatenate two MeshData objects, offsetting indices appropriately.

• Order Test: Apply Transform → RecomputeNormals and then RecomputeNormals → Transform. Compare results visually and numerically.

• Build a small test harness scene chaining multiple modifiers on a cube and visualize each output step.

**Success Criteria**

• Each modifier takes MeshData as input and outputs valid MeshData with all attributes preserved.

• Normals rotate correctly during transformations and remain consistent after recomputation.

• MergeModifier successfully combines multiple meshes with correct index offsets.

• RecomputeNormals output varies logically with the chosen mode (flat/smooth).

• Changing modifier order produces observable differences in the resulting geometry.

**Failsafe Readiness Checklist**

• Can you explain why normals must rotate but not translate?

• Did you test each modifier independently and in chained combinations?

• Are vertex counts and index offsets consistent after merges?

• Have you verified that UV projection maintains expected orientation and scale?

• Can you describe how your modifier system resembles Blender's or Houdini's modifier stacks?

**Reflection**

• Why is a data-centric approach preferred in procedural pipelines?

• How does modifier order affect the resulting geometry?

• Which vertex attributes are most sensitive to modification errors (normals, tangents, UVs)?

**Suggested Reading & Research Topics**

• Blender Developer Docs - Modifier Stack Evaluation.

• SideFX Houdini SOP documentation - procedural geometry operators.

• Data-Oriented Design Book - Transform Pipelines chapter.

• Game Engine Architecture (Gregory) - Geometry Processing section.

# Phase 7 - Terrain Basics (Grids, Height, LOD Thinking)

**Goal**

Build a heightfield terrain generator to explore large-scale mesh generation, chunking, and LOD (Level of Detail) strategies.

**Pre-flight Knowledge**

Before beginning:  
\- Review 2D noise algorithms (Perlin, Simplex, OpenSimplexNoise in Godot).  
\- Understand heightmaps and how finite differences approximate surface normals.  
\- Learn about Level of Detail (LOD) systems and why they are essential for large terrains.  
\- Review grid mesh generation from Phase 4 for topology fundamentals.

**Methodology**

Terrain meshes are built as heightfields: Z = f(x, y). Each vertex's height is determined by a procedural function such as noise. Normals are derived using finite differences of neighboring heights. Terrain generation also introduces scalability considerations-meshes must be chunked, rebuilt selectively, and maintain continuity across borders.

**Assignments**

• Implement a Heightfield Generator: inputs include width, height, seg_x, seg_y, and height function (noise).

• Compute vertex normals using finite differences based on adjacent heights.

• Add parameters for tile_size, segment_count, and preview_density for faster previews in the editor.

• Generate multiple terrain chunks arranged in a grid; only rebuild chunks when parameters change.

• Create two adjacent chunks with different segment densities; visualize border mismatches.

• Implement two seam-fix strategies: Matched LOD borders (vertex duplication) and Skirts (extra downward faces).

• Add color-by-height or triplanar shader material to visualize elevation.

• Log vertex count, chunk build time, and total AABB size for performance validation.

**Success Criteria**

• Terrain tiles generate correctly with continuous normals and height continuity.

• LOD parameter adjustments modify triangle density predictably.

• Seam-fix strategies effectively eliminate visible cracks between chunks.

• Performance scales linearly with segment and preview density.

• Debug overlay reports correct statistics (verts, tris, ms per build).

**Failsafe Readiness Checklist**

• Did you confirm your noise input range and scaling factor?

• Can you verify normal continuity between neighboring tiles?

• Have you profiled rebuild performance for multiple preview densities?

• Did you demonstrate both seam-fix methods (matched LOD and skirts)?

• Can you explain the importance of chunking for large-scale terrains?

**Reflection**

• How does terrain chunking relate to streaming systems in open-world games?

• What trade-offs exist between terrain detail and performance?

• How might this system evolve to support runtime terrain editing?

**Suggested Reading & Research Topics**

• GPU Gems 2 - Chapter 2: Terrain Rendering Using GPU-Based Geomorphing.

• Real-Time Rendering - Terrain LOD and chunking strategies.

• Godot Docs - OpenSimplexNoise and HeightMapShape3D tutorials.

• Unity Terrain System Manual - Chunking and LOD implementation details.

# Phase 8 - API Stabilization & Tests

**Goal**

Stabilize your procedural geometry system into a reusable API. Create a test harness to validate functionality, performance, and data integrity across all implemented generators and modifiers before building editor tools.

**Pre-flight Knowledge**

Before starting:  
\- Review API design principles (function signatures, modularity, naming consistency).  
\- Understand ArrayMesh and MeshData interoperability in Godot.  
\- Know how to collect and display runtime statistics (vertex counts, triangles, build time).  
\- Review unit testing concepts or simple assertion-based testing in GDScript.

**Methodology**

This phase is about formalizing your procedural geometry into a small, stable API. Treat each generator and modifier as a reusable function with well-defined inputs and outputs. Create a test scene that automatically builds, displays, and benchmarks multiple procedural meshes. These tests help catch regressions when you later integrate with the editor.

**Assignments**

• Define a consistent generator API: functions such as generate_cube(params), generate_plane(params), etc.

• Create modifier APIs: transform_mesh(mesh_data, transform), recompute_normals(mesh_data), merge_meshes(mesh_a, mesh_b).

• Build a test harness scene that instantiates your key primitives (cube, cylinder, terrain) and runs through each modifier chain.

• Display visual stats overlaying each mesh: vertex count, triangle count, bounding box size, and build time (in ms).

• Add a preview LOD flag to each generator that reduces complexity during editor previews.

• Write simple validation checks to confirm array lengths match (positions, normals, uvs).

• Log or print build results in a readable table format.

**Success Criteria**

• API functions are clearly named, predictable, and reusable across projects.

• All MeshData arrays (positions, normals, uvs, indices) align correctly in length and indexing.

• Performance statistics are visible in your test harness for each build.

• Preview LOD flag successfully reduces geometry complexity while preserving shape.

• The system remains stable and produces identical results across multiple test runs.

**Failsafe Readiness Checklist**

• Have you validated array integrity for every generator?

• Can you run your test harness without manual intervention?

• Do your debug overlays update correctly when parameters change?

• Have you logged build times and identified performance bottlenecks?

• Can you swap primitives in the harness (e.g., replace cube with grid→extrude chain) without refactoring code?

**Reflection**

• Why is API consistency essential for tool scalability?

• How does preview LOD improve usability during development?

• What testing patterns will be most useful once your editor integration begins?

**Suggested Reading & Research Topics**

• Clean Code (Robert C. Martin) - API and modular design principles.

• Godot Docs - ArrayMesh and MeshData interoperability.

• Game Engine Architecture - Testing procedural systems.

• Blender API Documentation - Structure of generator and modifier APIs.

# Phase 9 - Editor Integration (Single Node, Not a Graph Yet)

**Goal**

Integrate your procedural geometry system into the Godot editor with a single @tool node. Implement parameter exposure, live rebuilding, and resource baking so procedural meshes can act as reusable scene assets.

**Pre-flight Knowledge**

Before beginning:  
\- Review Godot's @tool keyword and how to run scripts in the editor.  
\- Understand EditorInspector and EditorPlugin basics for custom UI integration.  
\- Know how to create and manage Resources in Godot (.tres, .res, .mesh files).  
\- Understand undo/redo and property change notification systems.

**Methodology**

In this phase, you'll embed your procedural system inside a custom node (ProceduralMeshInstance3D). This node exposes generation parameters as editable fields and automatically rebuilds the mesh when they change. A Bake to Mesh feature will let you export static versions of your geometry for runtime use, mimicking workflows used in professional 3D tools.

**Assignments**

• Create a new @tool node class: ProceduralMeshInstance3D extending MeshInstance3D.

• Add exported parameters for at least two generators (e.g., Cube, Plane) and two modifiers (e.g., Transform, Merge).

• Create a Resource type (ProcRecipe) to store generator parameters and modifier stack data.

• Implement automatic rebuild logic: when parameters change, rebuild mesh with a short debounce delay.

• Add Bake to Mesh button: writes ArrayMesh to .mesh or .res file and swaps to a static version.

• Add Make Unique button for ProcRecipe so instances can diverge (copy-on-write pattern).

• Include debug overlay (verts/tris/build time) inside the editor viewport using EditorPlugin or script signals.

• Document how the node interacts with your API (Phase 8) for maintainability.

**Success Criteria**

• ProceduralMeshInstance3D appears in the editor and rebuilds meshes live when parameters change.

• Bake to Mesh successfully exports and swaps runtime geometry.

• Multiple instances of the node can exist in the same scene without data conflict.

• Make Unique produces independent parameter sets per instance.

• Performance remains responsive in the editor even with large meshes.

**Failsafe Readiness Checklist**

• Can you confirm rebuilds trigger only when parameters actually change (debounced)?

• Have you tested multiple instances to ensure independence?

• Did you validate baked meshes persist correctly between sessions?

• Do you understand how undo/redo integrates with your procedural updates?

• Have you documented the editor behaviors clearly for future graph integration?

**Reflection**

• What usability improvements make procedural editing feel natural inside the editor?

• How does separating recipes as Resources enhance reusability?

• What are the trade-offs between live generation and baked meshes for production?

**Suggested Reading & Research Topics**

• Godot Docs - Creating custom editor nodes and plugins.

• Godot API - MeshInstance3D, ResourceSaver, and EditorPlugin.

• Blender Modifier Workflow - Non-destructive editing design.

• Houdini Digital Assets - Procedural object instancing patterns.

# Phase 10 - From Recipe to Tiny Graph (DAG)

**Goal**

Convert your linear recipe system into a Directed Acyclic Graph (DAG) resource. Implement graph-based evaluation with caching, dependency tracking, and topological sorting to enable future visual editing.

**Pre-flight Knowledge**

Before beginning:  
\- Review dataflow graph theory (DAGs, nodes, edges, dependency resolution).  
\- Study topological sorting algorithms (Kahn's algorithm, DFS-based methods).  
\- Understand caching concepts: hashing parameter sets and detecting dependency changes.  
\- Refresh Godot Resource usage for storing structured data.

**Methodology**

Procedural systems often shift from linear modifier stacks to graph-based workflows. Each node represents a generator, modifier, or combiner, while connections define dependencies. The evaluator traverses this graph in topological order to ensure all inputs are resolved before their dependents. Caching prevents redundant computation by reusing node outputs if upstream parameters remain unchanged.

**Assignments**

• Define a ProceduralGraph Resource containing a list of nodes and connections. Each node includes: id, type, parameters, and cached output.

• Create a ProceduralNode base Resource class with common fields (id, type, params, cache_key, output).

• Implement a GraphEvaluator class that performs topological sorting and sequential node evaluation.

• Implement parameter hashing: generate a unique hash for each node from its params + upstream cache keys.

• Store each node's computed MeshData output in cache, reusing it on future evaluations if inputs are unchanged.

• Add diagnostic logging: show order of evaluation, cache hits/misses, and build time per node.

• Test your DAG with a small recipe graph (Cube → Transform → Output) and verify that only changed branches re-evaluate.

**Success Criteria**

• Graph evaluation respects dependency order (no undefined inputs).

• Node caching prevents redundant recomputation for unchanged inputs.

• Changing one node triggers re-evaluation of only its dependent nodes.

• Evaluation times and cache statistics display correctly in logs or overlays.

**Failsafe Readiness Checklist**

• Can you explain the difference between a stack and a DAG?

• Did you test graph traversal with cycles to confirm proper error handling?

• Can you confirm that cache invalidation works when parameters change?

• Does each node produce independent MeshData output without shared references?

• Have you profiled the evaluation process to ensure linear scaling with node count?

**Reflection**

• How does moving to a DAG enable non-linear workflows?

• Why is caching vital in procedural evaluation graphs?

• What are the trade-offs between real-time updates and strict dependency evaluation?

**Suggested Reading & Research Topics**

• Blender Geometry Nodes - Evaluation Order Documentation.

• Houdini Procedural Graph Engine Overview (SideFX Docs).

• Introduction to Algorithms (Cormen et al.) - Chapter on Topological Sorting.

• Dataflow Programming Models in Game Engines - GDC Talks.

# Phase 11 - Minimal Node Editor (Proof of Concept)

**Goal**

Implement a minimal node-based editor interface using Godot's GraphEdit and GraphNode UI controls. Connect it to your ProceduralGraph resource for live visualization, parameter editing, and mesh rebuilding.

**Pre-flight Knowledge**

Before beginning:  
\- Review Godot's GraphEdit and GraphNode classes.  
\- Learn about EditorPlugin and how to register dockable panels.  
\- Understand UndoRedo operations for editor safety.  
\- Review how to bind UI inputs to Resource fields and update parameters dynamically.

**Methodology**

This phase focuses on creating a minimal but functional node graph editor within Godot. Each node in the editor represents a procedural node from your ProceduralGraph resource. The editor handles connections, parameter editing, and triggers graph evaluation on demand. The visual interface mirrors tools like Houdini, Unreal Blueprints, or Godot's VisualShader system.

**Assignments**

• Implement an EditorPlugin that adds a dock panel containing a GraphEdit instance.

• Create visual node representations (GraphNode) for at least four node types: Cube, Transform, Merge, Output.

• Add drag-to-connect functionality between ports; enforce port-type compatibility (MeshData → MeshData).

• Bind each GraphNode's controls (Sliders, SpinBoxes, CheckBoxes) to the underlying ProceduralNode's parameters.

• Implement UndoRedo for parameter edits and connection changes.

• Add a debounced Apply button that triggers graph re-evaluation and mesh rebuilding for the selected scene node.

• Display evaluation logs or statistics (verts/tris/time/cache hits) in a small overlay panel.

• Save and load graph layouts (position, node data) to/from the ProceduralGraph resource.

**Success Criteria**

• Nodes can be created, connected, and parameterized visually.

• Graph connections enforce type safety and prevent invalid links.

• Undo/Redo works correctly for parameter and connection edits.

• Graph evaluation produces accurate MeshData outputs and updates live previews.

• Saving and reloading the graph restores node layout and parameters.

**Failsafe Readiness Checklist**

• Did you confirm UI updates trigger only after user edits (debounced)?

• Can you re-evaluate the graph without restarting the editor?

• Do Undo/Redo actions restore the exact previous state (parameters and connections)?

• Have you handled invalid graph connections gracefully (error feedback, no crash)?

• Can you describe how your system parallels Houdini or Blender node editors conceptually?

**Reflection**

• How do graph-based UIs improve creative iteration compared to linear modifier stacks?

• What usability challenges did you encounter when integrating with the editor?

• How might you extend this minimal node editor into a more powerful production tool?

**Suggested Reading & Research Topics**

• Godot Docs - GraphEdit and GraphNode API reference.

• Houdini Node Interface Design (SideFX Technical Documentation).

• Unreal Engine - Blueprint Visual Scripting Overview.

• Blender Geometry Nodes Developer Notes - Node Editor architecture.

# Phase 12 - Quality-of-Life & Constraints

**Goal**

Polish and stabilize your node-based procedural system with validation, usability, and performance improvements. This phase ensures that your procedural editor behaves predictably, provides feedback, and can scale to complex use cases.

**Pre-flight Knowledge**

Before starting:  
\- Review debugging and profiling techniques in Godot (print_rich, monitors, and Profiler).  
\- Learn about graph validation strategies (type-checking, cycle detection, missing input handling).  
\- Review UX design patterns for editor tools and how to provide clear user feedback.  
\- Study caching and memory profiling in procedural systems.

**Methodology**

Professional node-based tools balance flexibility with user safeguards. This phase adds validation for graph integrity, visual feedback (stats overlays, error states), and runtime performance features such as preview LOD and caching. The system should be able to detect invalid graphs, highlight problems visually, and maintain responsiveness for complex scenes.

**Assignments**

• Implement type checking for node connections (e.g., MeshData → MeshData only).

• Add cycle detection in the graph evaluator to prevent infinite recursion; display clear user error messages.

• Implement empty input validation and default fallback values for nodes with missing connections.

• Add a Stats Overlay on the Output node showing vertex count, triangle count, build time, and cache efficiency.

• Introduce a Preview LOD slider in the dock UI that reduces geometry complexity during live editing.

• Add quick material hooks (UV debug, normal visualization) to help users inspect geometry attributes.

• Implement per-node SubViewport previews (small thumbnail renders) cached per update cycle for performance.

• Profile graph rebuild times and identify performance bottlenecks (logging average build duration per node).

• Polish UI: consistent node colors per type (generator = blue, modifier = green, output = orange).

• Add tooltips and short inline documentation for each node type within the editor.

**Success Criteria**

• The editor provides clear, contextual feedback for user errors (cycles, invalid links, missing inputs).

• Preview meshes rebuild smoothly without freezing the editor, even for large graphs.

• Stats overlay accurately displays mesh metrics and performance timing.

• Preview LOD and material debug options work consistently across all nodes.

• Node editor interface feels stable, intuitive, and production-ready.

**Failsafe Readiness Checklist**

• Have you validated that all graph validation rules (type, cycles, inputs) trigger reliably?

• Can you rebuild large graphs without stalling or crashing the editor?

• Have you verified caching efficiency metrics and confirmed accurate rebuild timing?

• Do your SubViewport previews update only when nodes change (not every frame)?

• Can a new user understand your UI without external documentation?

**Reflection**

• How do validation and feedback improve the reliability of procedural tools?

• What UX principles make node-based workflows intuitive?

• What performance techniques (caching, LOD, deferred updates) are most critical for scalability?

• What would you prioritize if expanding this into a full-featured plugin release?

**Suggested Reading & Research Topics**

• Godot Docs - GraphEdit performance and UI optimization.

• Houdini Digital Asset (HDA) design principles for validation and UX.

• Blender Developer Wiki - Geometry Nodes UX and performance considerations.

• GDC Talks - Designing Scalable Node-Based Systems for Artists.

• Real-Time Rendering (Akenine-Möller) - Profiling and Performance sections.