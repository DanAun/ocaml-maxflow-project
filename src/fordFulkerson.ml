open Graph
open Tools
type path = int arc list





let arc_label graph arc i =
  let new_graph = add_arc graph arc.tgt arc.src i in
  add_arc new_graph arc.src arc.tgt (-i)