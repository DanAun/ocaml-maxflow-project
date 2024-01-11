(* Yes, we have to repeat open Graph. *)
open Graph

(* Assert false is of type ∀α.α, so the type-checker is happy. *)
let clone_nodes (gr:'a graph) = n_fold gr new_node empty_graph

(* Maps lables of arcs in graph with function *)
let gmap (gr : 'a graph) (f: 'a -> 'b) = e_fold gr (fun acu arc ->
  new_arc acu {src = arc.src; tgt = arc.tgt; lbl = f arc.lbl}) (clone_nodes gr)

(* Adds n to the value of the arc between id1 and id2. If the arc does not exist, it is created.*)
let add_arc g id1 id2 n = match (find_arc g id1 id2) with
  | None -> new_arc g {src = id1; tgt = id2; lbl = n}
  | Some a -> new_arc g {src = id1; tgt = id2; lbl = a.lbl + n};;

let rec max_node_aux g aux = match (node_exists g (aux + 1)) with
  | true -> max_node_aux g (aux + 1)
  | false -> aux

(* Takes a graph in parameter and returns the largest int representing a node in this graph, by using the max_node_aux function declared above*)
let max_node g = max_node_aux g 0