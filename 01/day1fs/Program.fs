open System
open System.IO

[<EntryPoint>]
let main argv =
    let path = argv.[0]
    let inputs = File.ReadLines(path) |> Seq.map (int)

    let folder acc [| a; b |] = if a < b then acc + 1 else acc

    let part1 =
        inputs |> Seq.windowed 2 |> Seq.fold folder 0

    printfn "%A" part1

    let part2 =
        inputs
        |> Seq.windowed 3
        |> Seq.map Array.sum
        |> Seq.windowed 2
        |> Seq.fold folder 0

    printfn "%A" part2

    0 // return an integer exit code
