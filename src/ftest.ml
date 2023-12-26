open Gfile
(*open Graph*)
open Tools
open FordFulkerson

let () =

  (* Check the number of command-line arguments *)
  if Array.length Sys.argv <> 5 then
    begin
      Printf.printf
        "\n ✻  Usage: %s infile source sink outfile\n\n%s%!" Sys.argv.(0)
        ("    🟄  infile  : input file containing a graph\n" ^
         "    🟄  source  : identifier of the source vertex (used by the ford-fulkerson algorithm)\n" ^
         "    🟄  sink    : identifier of the sink vertex (ditto)\n" ^
         "    🟄  outfile : output file in which the result should be written.\n\n") ;
      exit 0
    end ;


  (* Arguments are : infile(1) source-id(2) sink-id(3) outfile(4) *)
  
  let infile = Sys.argv.(1)
  and outfile = Sys.argv.(4)
  
  (* These command-line arguments are not used for the moment. *)
  and _source = int_of_string Sys.argv.(2)
  and _sink = int_of_string Sys.argv.(3)
  in

  (* Open file *)
  
  (* Test arc_label
  let graph1 = new_node empty_graph 1 in
  let graph2 = new_node graph1 2 in
  let graph3 = new_arc graph2 {src = 1 ; tgt = 2 ; lbl = 8} in
  let graph4 = arc_label graph3 {src = 1 ; tgt = 2 ; lbl = 3} 2 in*)

  (* Test min_label
  let graph = from_file infile in
  let int_graph = gmap graph int_of_string in
  let arc1 = {src=0;tgt=3;lbl=10} in
  let arc2 = {src=3;tgt=4;lbl=5} in
  let arc3 = {src=4;tgt=5;lbl=14} in
  let path = [arc1; arc2; arc3] in
  let result = min_label path in
  let result_arc = {src=1;tgt=5;lbl=result} in
  let res_graph = new_arc int_graph result_arc in*)

  (* Test path iteration
  let graph = from_file infile in
  let int_graph = gmap graph int_of_string in
  let arc1 = {src=0;tgt=3;lbl=10} in
  let arc2 = {src=3;tgt=4;lbl=5} in
  let arc3 = {src=4;tgt=5;lbl=14} in
  let path = [arc1; arc2; arc3] in
  let res_graph = path_iteration int_graph path in*)

  (* Test find path from source to sink
  let rec add_all_arcs_to_graph g = (function
  | [] -> g
  | x :: rest -> add_all_arcs_to_graph (add_arc g x.src x.tgt x.lbl) rest) in

  let graph = from_file infile in
  let int_graph = gmap graph int_of_string in
  let path = find_path_source_sink int_graph 0 5 in
  let node_graph = clone_nodes int_graph in
  let new_graph = add_all_arcs_to_graph node_graph path in*)

  (* Test max_flow*)
  let graph = from_file infile in
  let int_graph = gmap graph int_of_string in
  let res_graph, res_flow = max_flow int_graph _source _sink in
  Printf.printf "The value of res_flow is: %d\n" res_flow;

  (* Rewrite the graph that has been read. *)
  let () = export outfile (gmap res_graph string_of_int) in
  (*let () = export outfile (gmap int_graph string_of_int) in*)
()
