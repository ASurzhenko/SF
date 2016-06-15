public class GameMain {
	public static void main(){
		Unit fess = new Unit('Fess', 800, 50, 80);
		Unit etlau = new Unit('Etlau', 1000, 30, 70);
		Game game = new Game(fess, etlau);
		game.fight(fess, etlau);
	}
}