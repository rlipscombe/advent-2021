open System
open System.IO

[<EntryPoint>]
let main argv =
    let path = argv.[0]
    let inputs = File.ReadLines(path) |> Seq.map (int)

    let part1 =
        inputs
        |> Seq.windowed 2
        |> Seq.fold (fun acc [| a; b |] -> if a < b then acc + 1 else acc) 0

    printfn "%A" part1

    let part2 =
        inputs
        |> Seq.windowed 4
        |> Seq.fold (fun acc [| a; _; _; b |] -> if a < b then acc + 1 else acc) 0

    printfn "%A" part2

    0 // return an integer exit code
