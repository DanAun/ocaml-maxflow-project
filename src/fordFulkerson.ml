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

(* Using the function add_arc from tools, creates or modifyes if already exists, the value of the residual arc label with i, while modifying the label of original arc from the parameter by substracting i *)
let arc_label graph arc i =
  let new_graph = add_arc graph arc.tgt arc.src i in
    add_arc new_graph arc.src arc.tgt (-i)

    
let rec find_path_source_sink_acu graph source sink acu = 
  let outs = out_arcs graph source in
  arc_options graph sink acu outs

and arc_options graph sink acu = function
  | [] -> [] (* If no arcs in 'outs' list, return empty list*)
  | arc :: rest -> if arc.lbl == 0 || (List.mem arc acu) then arc_options graph sink acu rest (* (List.mem arc acu) checks that the arc is not already in the list, if this is the case we have to chose a different arc to avoid infinity loops in the list*)
    else (if arc.tgt == sink then arc :: acu (* If we have arrived at the sink node, we are finished, and return the list including the last arc*)
      else (let res = find_path_source_sink_acu graph arc.tgt sink (arc :: acu) in
        if res == [] then arc_options graph sink acu rest (* If res == [], we have arrived at a case where the next arc.tgt has no out_arcs, meaning this is not an acceptable path, and we have to look for another suitable arc*)
        else res))

(* return path (int arc list)*)
let find_path_source_sink graph source sink = find_path_source_sink_acu graph source sink []


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

let max_flow graph src sink =
  let rec max_flow_acc graph src sink =
    let rec sink_flow new_acc list =
    match list with
    |[] -> new_acc
    |arc  :: rest -> if arc.lbl > 0 then sink_flow (new_acc + arc.lbl) rest
      else sink_flow (new_acc) rest
    in

    let path = find_path_source_sink graph src sink in
    match path with
    |[] -> graph, (sink_flow 0 (out_arcs graph sink))
    |a_path -> 
      let updated_graph = path_iteration graph a_path in
      max_flow_acc updated_graph src sink
  in
  max_flow_acc graph src sink