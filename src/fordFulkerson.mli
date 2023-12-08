(*  min_label takes a list of arcs and returns the minimum of the labels in the path from first arc to last arc*)
val min_label: int arc list -> int

(*  sub_label takes in a path (Source to Sink) as an arc list and substracts the given int from every label in the path*)
val sub_label: int arc list -> int -> unit



(*  Takes in a graph, source, sink and returns all paths from the source to the sink as a list of arc-lists
   NB: Must also consider going backwards (arc target to arc source)*)
val all_paths_from_source_to_sink: 'a graph -> id -> id -> 'a arc list list

(*  Returns the max_flow from a source to a sink in the graph*)
val max_flow: 'a graph -> id -> id -> int

