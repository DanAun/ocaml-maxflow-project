open Graph

val clone_nodes: 'a graph -> 'b graph
val gmap: 'a graph -> ('a -> 'b) -> 'b graph

(* Adds int to the value of the arc between the first id and the second id. If the arc does not exist, it is created. *)
val add_arc: int graph -> id -> id -> int -> int graph
            