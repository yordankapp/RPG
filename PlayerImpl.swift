
class PlayerMoveImpl : PlayerMove{
  var direction: MapMoveDirection 
  var friendlyCommandName: String 
  init(direction: MapMoveDirection, friendlyCommandName: String){
    self.direction = direction
    self.friendlyCommandName = friendlyCommandName
  }
}

class PlayerImpl : Player {
  var name: String = "Default Player"
  var hero: Hero = DefaultHero()
  var isAlive: Bool = true
  var position: (Int, Int) = (0,0)

  func setPosition(position: (Int, Int)){
    self.position.0 = position.0
    self.position.1 = position.1
  }
}