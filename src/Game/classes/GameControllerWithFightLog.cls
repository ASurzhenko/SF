public class GameControllerWithFightLog {

    public Unit fighter1 { get; set; }
    public Unit fighter2 { get; set; }
    public Unit winner {get; set;}
    public GameWithFightLog game { get; set; }
        
    public GameControllerWithFightLog(){
        fighter1 = new Unit();
        fighter2 = new Unit();
        winner = new Unit();
    }

    public void setFighter1(Unit fighter){
        fighter1 = fighter;
    }
    
    public void setFighter2(Unit fighter){
        fighter2 = fighter;
    }
    
    public PageReference fight() {
        game = new GameWithFightLog(fighter1, fighter2);
        winner = game.fight(fighter1, fighter2);
        return null;
    }
}