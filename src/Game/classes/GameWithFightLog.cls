/*
*In this class fighters for the game create and methods with fight logic execute 
*/

public class GameWithFightLog {
    Unit__c un1;
    Unit__c un2;
    
    Unit unit1;
    Unit unit2;
    private Integer damage;
    public List <String> fightLog;
    
    public GameWithFightLog(Unit__c fighter1, Unit__c fighter2){
        un1 = fighter1;
        un2 = fighter2;    
    
        Unit winner;
        createUnits(fighter1, fighter2);
        fightLog = new List<String>();
        winner = fight(unit1, unit2);
        if(winner.equals(unit1))
        {
            un2.Lose_Date__c = Date.today();
        }
        else if(winner.equals(unit2))
        {
            un1.Lose_Date__c = Date.today();
        }
        else
        {
            un1.Lose_Date__c = Date.today();
            un2.Lose_Date__c = Date.today();
        }
    }
    
    
    /*
    *This method creates units
    */
    private void createUnits(Unit__c fighter1, Unit__c fighter2)
    {
        unit1 = new Unit();
        unit1.setName(fighter1.name);
        unit1.setHp((Integer)fighter1.Hp__c); 
        unit1.setDmgMin((Integer)fighter1.Min_Damage__c);
        unit1.setDmgMax((Integer)fighter1.Max_Damage__c);
        unit2 = new Unit();
        unit2.setName(fighter2.name);
        unit2.setHp((Integer)fighter2.hp__c);
        unit2.setDmgMin((Integer)fighter2.Min_Damage__c);
        unit2.setDmgMax((Integer)fighter2.Max_Damage__c);
    }

    /**
    *this method starts hit method, calculate fighter's HP and returns winner (Unit winner) 
    */
    public Unit fight(Unit unit1, Unit unit2)
    {
        Unit winner = new Unit();
        Integer round = 1;
        while(unit1.getHp() > 0 && unit2.getHp() > 0)
        {
            fightLog.add('Round ' + round + '\n' + unit1.getName() + ' HP left: ' + unit1.getHp() + '\n' +
                        unit2.getName() + ' HP left: ' + unit2.getHp());
            damage = hit(unit1, unit2);
            unit2.setHp(unit2.getHp() - damage);
                        
            damage = hit(unit2, unit1);
            unit1.setHp(unit1.getHp() - damage);
            
            round++;
        }
        
        if(unit1.getHp() > 0 && unit2.getHp() <= 0)
        {
            fightLog.add(unit1.getName() + ' wins');
            return unit1;
        }
        else if(unit2.getHp() > 0 && unit1.getHp() <= 0)
        {
            fightLog.add(unit2.getName() + ' wins');
            return unit2;
        }
        else
        {
            fightLog.add('It was a great fight! Both fighters were killed!');
            return NULL;
        }
    }

    /**
    *this method returns damage
    *unit 1 makes a hit
    *unit 2 defences
    */
    public Integer hit(Unit unit1, Unit unit2)
    {
        String whereHit;
        String head = 'Head';
        String chest = 'Chest';
        String groin = 'Groin';
        String legs = 'Legs';
        Integer hitChoise = (Integer)(Math.random() * 4);
        Integer blockChoise = (Integer)(Math.random() * 4);

        if(hitChoise == blockChoise)
        {
            fightLog.add(unit2.getName() + ' blocked the hit!');
            return 0;  
        }

        if(hitChoise == 0)
        {
            whereHit = head;
        }
        else if(hitChoise == 1)
        {
            whereHit = chest;
        }
        else if(hitChoise == 2)
        {
            whereHit = groin;
        }
        else
        {
            whereHit = legs;
        }
   
        /**
        *This method sets if fighter miss, make a crit or make a normal hit
        *fighter can miss the target in 25% cases and
        *make crit in 10% cases
        *crit = demage * 2
        */
        Integer missOrCrit = (Integer)(Math.random() * 100);

        if(missOrCrit < 25)
        {
            damage = 0;
            fightLog.add(unit1.getName() + ' missed!');
        }
        else if(missOrCrit > 90) 
        {
            damage = ((Integer)(Math.random() * (unit1.getDmgMax() - unit1.getDmgMin() + 1) + unit1.getDmgMin())) * 2;
            fightLog.add(unit1.getName() + ' made CRIT! and kicked ' + unit2.getName() + ' in ' + whereHit + ' on ' + damage);
        }   
        else
        {
            damage = (Integer)(Math.random() * (unit1.getDmgMax() - unit1.getDmgMin() + 1) + unit1.getDmgMin());
            fightLog.add(unit1.getName() + ' kicked ' + unit2.getName() + ' in ' + whereHit + ' on ' + damage);
        }
            
        return damage;
    } 
    
     public List<String> getFightLog()
    {
        return fightLog;
    }
}