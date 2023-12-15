open Graph
open Tools
type path = int arc list

let min_label path =
  match path with
  | [] -> failwith "Empty path"
  | first_arc :: rest ->
    let rec find_min_label acc = function
      | [] -> acc
      | arc :: rest_arcs ->
        let current_label = arc.lbl in
        let min_label_so_far = min acc current_label in
        find_min_label min_label_so_far rest_arcs
    in
    find_min_label first_arc.lbl rest

let arc_label graph arc i =
  let new_graph = add_arc graph arc.tgt arc.src i in
    add_arc new_graph arc.src arc.tgt (-i)

let path_iteration graph path =
  let remove_capacity = min_label path in
  match path with
  | [] -> graph
  | _ ->
    let rec handle_all_arcs acc = function
      | [] -> acc
      | arc :: rest_arcs ->
        let graph_so_far = arc_label acc arc remove_capacity in
        handle_all_arcs graph_so_far rest_arcs
    in
    handle_all_arcs graph path
(*Den funker for siste arc, men ikke de andre*)