public class Game {
	//to GitHub
    Unit fighter1;
    Unit fighter2;
    private Integer damage;
    private Integer round = 1;
        
    public Game(Unit fighter1, Unit fighter2){
        this.fighter1 = fighter1;
        this.fighter2 = fighter2;
    }

    public Integer hit(Unit unit){
        damage = 0;
        //fighter can miss the target in 25% cases
        Integer miss = (Integer)Math.floor(Math.random() * 100);
            if(miss < 25){
                damage = 0;
            }else{
            damage = (Integer)Math.floor(Math.random() * (unit.getDmgMax() - unit.getDmgMin() + 1) + unit.getDmgMin());
        }
        return damage;
    } 

    //fight logic
    public Unit fight(Unit unit1, Unit unit2){
        
        while(unit1.getHp() > 0 && unit2.getHp() > 0){
            system.debug('Round ' + round + '\n' + unit1.getName() + ' HP left: ' + unit1.getHp() + '\n' +
                unit2.getName() + ' HP left: ' + unit2.getHp());
            damage = hit(unit2);
            unit1.setHp(unit1.getHp() - damage);
            if(damage == 0){
                system.debug(unit2.getName() + ' missed!');
            }else{
                system.debug(unit2.getName() + ' kicked ' + unit1.getName() + ' on ' + damage);
            }

            damage = hit(unit1);
            unit2.setHp(unit2.getHp() - damage);
            if(damage == 0){
                system.debug(unit1.getName() + ' missed!');
            }
            else{
                system.debug(unit1.getName() + ' kicked ' + unit2.getName() + ' on ' + damage);
            }
            round++;
        }
        if(unit1.getHp() > 0 && unit2.getHp() <= 0){
            system.debug(unit1.getName() + ' wins!');
            return unit1;
        }else if(unit2.getHp() > 0 && unit1.getHp() <= 0){
            system.debug(unit2.getName() + ' wins!');
            return unit2;
        }else{
            system.debug('It was a great fight! Both fighters were killed!');
            return null;
        }
    }
}