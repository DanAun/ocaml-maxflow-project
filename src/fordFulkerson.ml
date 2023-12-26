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

    (* return path (int arc list)*)
let find_path_source_sink graph source sink = find_path_source_sink_acu graph sorce sink []

(*  Graph kan ikke gå i boucle infinie! fantes en lett fiks på hvordan å sjekke at pathen ikke går tilbake til en node den allerede har i sin acu*)
let rec find_path_source_sink_acu graph sorce sink acu = 
  let outs = out_arcs graph source in
  arc_options graph sink acu outs

and arc_options graph sink acu = function
  | [] -> []
  | arc :: rest -> if arc.lbl == 0 then arc_options graph sink acu rest 
    else (if arc.tgt == sink then arc :: acu 
      else (let res = find_path_source_sink_acu graph source sink (arc :: acu) in
        if res == [] then arc_options graph sink acu rest
        else res))

  (* if the for loop finishes -> there were no outs that could be followed on this source*)



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

let max_flow graph p1 p2 =
  (*TODO:
     Run path_iteration with find_path_source_sink until no more paths can be found then return the graph and
   the sum of all arc labels going into the sink
   *)