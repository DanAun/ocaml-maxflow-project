open Graph
open Tools
type path = int arc list

let min_label path =
  match path with
  | [] -> failwith "Empty path"
  | first_arc :: rest ->
    (*Recursively travers the path while storing the current min_label in the acc*)
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

    
let rec find_path_source_sink_acu graph source sink acu = 
  let outs = out_arcs graph source in
  arc_options graph sink acu outs

and arc_options graph sink acu = function
  | [] -> []
  | arc :: rest -> if arc.lbl == 0 || (List.mem arc acu) then arc_options graph sink acu rest 
    else (if arc.tgt == sink then arc :: acu 
      else (let res = find_path_source_sink_acu graph arc.tgt sink (arc :: acu) in
        if res == [] then arc_options graph sink acu rest
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
    (* Helper function to calculate the flow going into the sink from a list of arcs *)
    let rec sink_flow new_acc list =
    match list with
    |[] -> new_acc
    |arc  :: rest -> 
      (* Accumulate flow if the arc has positive label *)
      if arc.lbl > 0 then sink_flow (new_acc + arc.lbl) rest
      else sink_flow (new_acc) rest
    in

    let path = find_path_source_sink graph src sink in
    (* If no path is found, return the current graph and the flow going into the sink *)
    match path with
    |[] -> graph, (sink_flow 0 (out_arcs graph sink))
    |a_path -> 
      let updated_graph = path_iteration graph a_path in
      max_flow_acc updated_graph src sink
  in
  max_flow_acc graph src sink