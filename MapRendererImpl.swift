
class MapRendererImpl : MapRenderer {
  func render(map:Map) {
    for i in 0..<map.maze.count {
      for j in 0..<map.maze[i].count {
        var occupiedByPlayer: Bool = false
        
        for player in map.players {
          if player.position.0 == i && player.position.1 == j && !occupiedByPlayer {
            occupiedByPlayer = true
            print("🚶",terminator:"")
          }
        }

        if !occupiedByPlayer {
          if map.maze[i][j].type == .chest {
            print("⛳", terminator:"")
          }
          else if map.maze[i][j].type == .rock {
            print("o", terminator:"")
          }
          else if map.maze[i][j].type == .teleport {
            print("t", terminator:"")
          }
          else if map.maze[i][j].type == .wall {
            print("x", terminator:"")
          }
          else if map.maze[i][j].type == .empty {
            print("_", terminator:"")
          }
        }      
      }
      print("")
    }  
    print("Възможно е на една позиция да има повече от един играч!")
    print("Легенда:\n ковчеже: ⛳, камък: o, телепорт: t,\n стена: x, празно поле: _, играч: 🚶")
  }
}