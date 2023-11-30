(* Yes, we have to repeat open Graph. *)
open Graph

(* assert false is of type ∀α.α, so the type-checker is happy. *)
let clone_nodes (gr:'a graph) = n_fold gr (new_node) empty_graph

(*let gmap gr f = assert false*)

(*adds n to the value of the arc between id1 and id2. If the arc does not exist, it is created.*)
let add_arc g id1 id2 n = match (find_arc g id1 id2) with
  | None -> new_arc g {src = id1; tgt = id2; lbl = n}
  | Some a -> new_arc g {src = id1; tgt = id2; lbl = a.lbl + n};;