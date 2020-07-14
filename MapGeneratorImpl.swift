class MapGeneratorImpl : MapGenerator{
  func generate(players:[Player]) -> Map{
    var rows = 0
    var cols = 0

    repeat {
      print("Въведете брой редове: ")
      if let number = readLine(as: Int.self) {
        rows = number
      } 
      else {
      print("Невалиден вход! Моля, опитай пак.")  
      }
    } while rows < 0 
    
    repeat {
      print("Въведете брой колони: ")
      if let number = readLine(as: Int.self) {
        cols = number
      } 
      else {
      print("Невалиден вход! Моля, опитай пак.")  
      }
    } while cols < 0
    
    let defaultMapTile = DefaultMapTile(type: .empty)
    var maze = [[MapTile]](repeating: [MapTile](repeating: defaultMapTile, count: cols), count: rows)

    for i in 0..<rows {
      for j in 0..<cols {
        var randomTile: MapTileType
        repeat {
          randomTile = MapTileType.allCases.randomElement()!
        } while randomTile == .teleport || randomTile == .chest
        maze[i][j] = DefaultMapTile(type: randomTile)
      }
    }

    //put 2 teleports
    for _ in 0...1 {
      let teleportRandPositionX = Int.random(in: 0..<maze.count)
      let teleportRandPositionY = Int.random(in: 0..<maze[0].count)
      maze[teleportRandPositionX][teleportRandPositionY] = DefaultMapTile(type: .teleport)
    }
    //put 1 chest
    let chestRandPositionX = Int.random(in: 0..<maze.count)
    let chestRandPositionY = Int.random(in: 0..<maze[0].count)
    maze[chestRandPositionX][chestRandPositionY] = DefaultMapTile(type: .chest)

    for player in players{
      let randomRow = Int.random(in: 0..<rows)
      let randomCol = Int.random(in: 0..<cols)
      player.setPosition(position: (randomRow,randomCol))
    }

    let m = MapImpl(players: players)
    m.setMaze(maze: maze)
    return m 
  }
}