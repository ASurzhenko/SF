public class GameMain {
    public static void main(){
        Unit fess = new Unit('Fess', 800, 50, 80);
        Unit etlau = new Unit('Etlau', 1000, 30, 70);
        Unit winner = new Unit();
        Game game = new Game(fess, etlau);
        winner = game.fight(fess, etlau);
        if(winner == fess){
            system.debug('Fess wins!');
        }else if (winner == etlau){
            system.debug('Etlau wins!');
        }else{
            system.debug('Both were killed!');
        }
    }
}