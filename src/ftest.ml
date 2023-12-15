open Gfile
open Graph
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
  
  (*let infile = Sys.argv.(1)
  and outfile = Sys.argv.(4)*)
  let outfile = Sys.argv.(4)
  
  (* These command-line arguments are not used for the moment. *)
  and _source = int_of_string Sys.argv.(2)
  and _sink = int_of_string Sys.argv.(3)
  in

  (* Open file *)
  (*let graph = from_file infile in*)
  let graph1 = new_node empty_graph 1 in
  let graph2 = new_node graph1 2 in
  let graph3 = new_arc graph2 {src = 1 ; tgt = 2 ; lbl = 8} in

  (* Rewrite the graph that has been read. *)
  let () = export outfile (gmap (arc_label graph3 {src = 1 ; tgt = 2 ; lbl = 3} 2) string_of_int) in
()
