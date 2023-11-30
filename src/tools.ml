(* Yes, we have to repeat open Graph. *)
open Graph

(* assert false is of type ∀α.α, so the type-checker is happy. *)
let clone_nodes (gr:'a graph) = n_fold gr new_node empty_graph

let gmap (gr : 'a graph) (f: 'a -> 'b) = e_fold gr (fun acu arc ->
  new_arc acu {src = arc.src; tgt = arc.tgt; lbl = f arc.lbl}) (clone_nodes gr)
(*let add_arc gr i1 i2 int1 = assert false*)