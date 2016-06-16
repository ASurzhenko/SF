public class GameWithFightLog {
    Unit fightr1;
    Unit fightr2;
    private Integer damage;
    private Integer round = 1;
    public List <String> fightLog;

    public List <String> getFightLog(){
        return fightLog;
    }

    public GameWithFightLog(Unit fightr1, Unit fightr2){
        this.fightr1 = fightr1;
        this.fightr2 = fightr2;
        fightLog = new List<String>();
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
            fightLog.add('Round ' + round);
            fightLog.add(unit1.getName() + ' HP left: ' + unit1.getHp());
            fightLog.add(unit2.getName() + ' HP left: ' + unit2.getHp());
            damage = hit(unit2);
            unit1.setHp(unit1.getHp() - damage);
            if(damage == 0){
                fightLog.add(unit2.getName() + ' missed!');
            }else{
                fightLog.add(unit2.getName() + ' kicked ' + unit1.getName() + ' on ' + damage);
            }

            damage = hit(unit1);
            unit2.setHp(unit2.getHp() - damage);
            if(damage == 0){
                fightLog.add(unit1.getName() + ' missed!');
            }
            else{
                fightLog.add(unit1.getName() + ' kicked ' + unit2.getName() + ' on ' + damage);
            }
            round++;
        }
        if(unit1.getHp() > 0 && unit2.getHp() <= 0){
            fightLog.add(unit1.getName() + ' wins!');
            return unit1;
        }else if(unit2.getHp() > 0 && unit1.getHp() <= 0){
            fightLog.add(unit2.getName() + ' wins!');
            return unit2;
        }else{
            fightLog.add('It was a great fight! Both fighters were killed!');
            return null;
        }
    }
}