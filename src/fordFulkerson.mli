open Graph
type path = int arc list


(*  min_label takes a list of arcs and returns the minimum of the labels in the path from first arc to last arc*)
val min_label: path -> int

(*  arc_label takes in an arc and substracts the given int from the label and creates a residual arc in the opposite way*)
val arc_label: int graph -> int arc -> int -> int graph

(*  Takes in a graph, source, sink and returns a path from the source to the sink as a list of arcs.
   NB: Must also consider going backwards (arc target to arc source)*)
(*val find_path_source_sink : int graph -> id -> id -> path*)

(*Given a path does one iteration of the Ford fulkersons Algorithm
   1 - Runs arc_label on all arcs in the path
*)
val path_iteration : int graph -> path -> int graph

(*  Returns the max_flow from a source to a sink in the graph
   Run path_iteration with find_path_source_sink until no more paths can be found then return the graph and
   the sum of all arc labels going into the sink
*)
val max_flow: int graph -> id -> id -> int graph * int

