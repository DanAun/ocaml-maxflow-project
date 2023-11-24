(* Yes, we have to repeat open Graph. *)
open Graph

(* assert false is of type ∀α.α, so the type-checker is happy. *)
let clone_nodes (gr:'a graph) = 
  let newGraph = empty_graph in
    n_iter gr (new_node newGraph) (*Bruke n_fold*)

let gmap gr f = assert false