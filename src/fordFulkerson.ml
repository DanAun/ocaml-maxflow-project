open Graph

type path = int arc list

let min_label path =
  match path with
  | [] -> failwith "Empty path"
  | first_arc :: rest ->
    let rec find_min_label acc = function
      | [] -> acc
      | arc :: arcs ->
        let current_label = arc.lbl in
        let min_label_so_far = min acc current_label in
        find_min_label min_label_so_far arcs
    in
    find_min_label first_arc.lbl rest