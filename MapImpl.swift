class MapImpl : Map {
    required init(players: [Player]){
      self.players = players
    }
    var players: [Player] 
    var maze: [[MapTile]] = []

    func isValidPosition(position: (Int,Int), rows: Int, cols: Int) -> Bool {
      if 0 <= position.0 && position.0 < rows &&
         0 <= position.1 && position.1 < cols {
           return true
      }
      return false
    }

    func availableMoves(player: Player) -> [PlayerMove]{
      var availableMoves : [PlayerMoveImpl] = []
      var move : PlayerMoveImpl
      
      if isValidPosition(position: (player.position.0 - 1,player.position.1),rows: self.maze.count , cols: self.maze[0].count) &&
       (self.maze[player.position.0 - 1][player.position.1].type == .empty ||
       self.maze[player.position.0 - 1][player.position.1].type == .chest || 
       self.maze[player.position.0 - 1][player.position.1].type == .teleport){
        move = PlayerMoveImpl(direction: MapMoveDirection.up, friendlyCommandName: "up")
        availableMoves.append(move)
      }
      if isValidPosition(position: (player.position.0 + 1,player.position.1),rows: self.maze.count , cols: self.maze[0].count) &&
       (self.maze[player.position.0 + 1][player.position.1].type == .empty ||
       self.maze[player.position.0 + 1][player.position.1].type == .chest ||
       self.maze[player.position.0 + 1][player.position.1].type == .teleport){
        move = PlayerMoveImpl(direction: MapMoveDirection.down, friendlyCommandName: "down")
        availableMoves.append(move)
      }
      if isValidPosition(position: (player.position.0,player.position.1 - 1),rows: self.maze.count , cols: self.maze[0].count) &&
       (self.maze[player.position.0][player.position.1 - 1].type == .empty ||
       self.maze[player.position.0][player.position.1 - 1].type == .chest || 
       self.maze[player.position.0][player.position.1 - 1].type == .teleport){
        move = PlayerMoveImpl(direction: MapMoveDirection.left, friendlyCommandName: "left")
        availableMoves.append(move)
      }
      if isValidPosition(position: (player.position.0,player.position.1 + 1) ,rows: self.maze.count , cols: self.maze[0].count) &&
       (self.maze[player.position.0][player.position.1 + 1].type == .empty ||
       self.maze[player.position.0][player.position.1 + 1].type == .chest || 
       self.maze[player.position.0][player.position.1 + 1].type == .teleport){
        move = PlayerMoveImpl(direction: MapMoveDirection.right, friendlyCommandName: "right")
        availableMoves.append(move)
      }
      return availableMoves
    }

    func move(player: Player, move: PlayerMove) {
      let currPosition = player.position
      let directionName = move.friendlyCommandName 
      var newPosition: (Int,Int) = (0,0)
      if directionName == "up" {
        newPosition = (currPosition.0 - 1,currPosition.1)
      }
      else if directionName == "down" {
        newPosition = (currPosition.0 + 1,currPosition.1)
      }
      else if directionName == "left" {
        newPosition = (currPosition.0, currPosition.1 - 1)
      }
      else if directionName == "right" {
        newPosition = (currPosition.0, currPosition.1 + 1)
      }

      if self.maze[newPosition.0][newPosition.1].type == .teleport {
        for i in 0..<self.maze.count {
          for j in 0..<self.maze[i].count {
            if self.maze[i][j].type == .teleport && !(i == newPosition.0 && j == newPosition.1){
              newPosition.0 = i
              newPosition.1 = j
            }
          }
        }
      }

      player.setPosition(position: newPosition)
    }

    func setMaze(maze: [[MapTile]]){   
      self.maze = maze
    }

}