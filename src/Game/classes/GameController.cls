public class GameController {

    /*
    *This is a custom controller of the VF Page Game
    */
    
    public Unit__c winner1{get;set;}
    public Unit__c winner2{get;set;}
    public Unit__c unit {get;set;}
    
    public Unit winner{get;set;}
    public Unit unit1{get;set;}
    public Unit unit2{get;set;}
    public Integer damage{get;set;}
    public String log{get;set;}
    public String whereHit{get;set;}
    public String hit{get;set;}
    public String block{get;set;}
    public String message{get;set;}
        
    public List<Wrapper> unitsList{get;set;} 
    public List<Unit__c> fightersList {get;set;}
    public List<String> fightLog {get;set;}
    public boolean isVisible {get;set;}
    public boolean addNewFighter {get;set;}
    public boolean choseFighters {get;set;}
    public boolean isFightLog {get;set;}  //not used yet
    public boolean isFight {get;set;}
    public Integer round = 1;
    
    public String getLog() {
        return log;
    }   
    
    public String getHit() {
        return hit;
    }

    public void setHit(String hit) 
    { 
        this.hit = hit;
    }
    
    public String getBlock() {
        return block;
    }

    public void setBlock(String block) 
    { 
        this.block = block;
    }
    
    public GameController()
    {
        unitsList = getUnits();
        unit = new Unit__c();
        choseFighters = true;
        message = 'Select 2 fighters';
    }
    
    /**
    *This is list type SelectOption for radiobuttons
    */
    public List<SelectOption> getPlace() {
        List<SelectOption> options = new List<SelectOption>(); 
        options.add(new SelectOption('Head','Head')); 
        options.add(new SelectOption('Chest','Chest')); 
        options.add(new SelectOption('Groin','Groin'));
        options.add(new SelectOption('Legs','Legs'));
        return options; 
    }          

    /**
    *This method takes information from DB and creates Wrapper class objects
    *Wrapper class can also define the activity of the checkbox depending on its lose date (Lose_Date__c)
    */
    private List<wrapper> getUnits()
    {
        List<Wrapper> unitsList = new List<Wrapper>();
        for(Unit__c u : [SELECT Name, HP__c, Min_Damage__c, Max_Damage__c, 
                                Lose_Date__c, Ressurection_Date__c FROM Unit__c])
        {
            unitsList.add(new Wrapper(u, false));
        }
        return unitsList;
    }

    public class Wrapper
    {
        public Unit__c unit {get; set;}
        public boolean isSelected {get; set;}
        public boolean isNotActive {get; set;}
        
        public Wrapper(Unit__c unit, boolean isSelected) 
        {
            Date today = Date.today();
            if(unit.Lose_Date__c != null)
            {
                unit.Ressurection_Date__c = unit.Lose_Date__c.addDays(1);
                if(unit.Lose_Date__c.daysBetween(today) <= 1)
                {
                    isNotActive = true;
                }
                else
                {
                    unit.Ressurection_Date__c = NULL;    
                } 
            }
           
            this.unit = unit;
            this.isSelected = isSelected;
        } 
    }

    /**
    *This method allows users create and add new fighter in game
    */
    public PageReference addFighter()
    {
        fightersList = new List<Unit__c>();
        unitsList = getUnits();
        choseFighters = false;
        isVisible = true;
        addNewFighter = true;
        return null;
    }

    /**
    *This method adds new record
    */
    public PageReference newFighter()
    {
        insert unit; 
        unit = new Unit__c();
        fightersList = new List<Unit__c>();
        unitsList = getUnits();
        choseFighters = true;
        addNewFighter = false;
        isVisible = false;
        isFightLog = false; 
                  
        return null;
    }
    
    /**
    *This method starts the game.
    *It checks the correct number of fighters (it can be only 2) and returns an error if there are more or less
    *then 2 fighters checked 
    */
    public PageReference goFight()
    {
        fightersList = new List<Unit__c>();
        for(Wrapper wrap : unitsList)
        {
            if(wrap.isSelected)
                {  
                    fightersList.add(wrap.unit);  
                }  
        }
        if(fightersList.size() == 2)
        {
            isFight = true;
            createUnits(fightersList.get(0), fightersList.get(1));
            winner1 = fightersList.get(0);
            winner2 = fightersList.get(1);
            message = unit1.getName() + ' VS ' + unit2.getNAme();
            choseFighters = false;
            addNewFighter = false;
            isFightLog = true;  //not used yet
            update fightersList;
            fightersList = new List<Unit__c>();
            unitsList = getUnits();
        }
        else 
        {
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.FATAL, 'You have to chose 2 fighters!'));
            choseFighters = true;
            addNewFighter = false;
            isFightLog = false;
        }
        return null;
    }
    
    /**
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
    
    public PageReference makeHit() {
        log = fight(unit1, unit2);    
        
        return null;
    }
    
    /**
    *this method starts hitStrike method, calculate fighter's HP and returns log ot the current round
    *Also the method defines winner 
    */
    public String fight(Unit unit1, Unit unit2)
    {
        if (unit1.getHP() > 0 && unit2.getHP() > 0)
        {
            Integer hitPlacePC = Math.round((Math.floor(Math.random() * 3.5)));
            Integer blockPlacePC = Math.round((Math.floor(Math.random() * 3.5)));
            SelectOption PCHit = getPlace().get(hitPlacePC);
            SelectOption PCBlock = getPlace().get(blockPlacePC);
        
            if (hit != PCBlock.getValue() && block != PCHit.getValue()) // both fighters hit
            {
                log ='Round ' + round + ' ' + unit1.getName() + ' HP left: ' + unit1.getHp() + ' ' +
                      unit2.getName() + ' HP left: ' + unit2.getHp();
                whereHit = hit;            
                damage = hitStrike(unit1, unit2);
                unit2.setHp(unit2.getHp() - damage);
                
                whereHit = PCHit.getValue();            
                damage = hitStrike(unit2, unit1);
                unit1.setHp(unit1.getHp() - damage);
            }
            else if (hit != PCBlock.getValue() && block == PCHit.getValue()) // only unit 1 hits, unit2 blocks
            {
                log ='Round ' + round + ' ' + unit1.getName() + ' HP left: ' + unit1.getHp() + ' ' +
                      unit2.getName() + ' HP left: ' + unit2.getHp();
                            
                whereHit = hit;            
                damage = hitStrike(unit1, unit2);
                unit2.setHp(unit2.getHp() - damage);
                            
                log += ' ' + unit1.getName() + ' blocks the hit!' + ' ';
            }     
            else if (hit == PCBlock.getValue() && block != PCHit.getValue()) // only unit1 hits, unit1 blocks
            {
                log ='Round ' + round + ' ' + unit1.getName() + ' HP left: ' + unit1.getHp() + ' ' +
                      unit2.getName() + ' HP left: ' + unit2.getHp();
                            
                whereHit = PCHit.getValue();            
                damage = hitStrike(unit2, unit1);
                unit1.setHp(unit1.getHp() - damage);
                            
                log += ' ' + unit2.getName() + ' blocks the hit!' + ' ';
            }
            else // both units block
            {
                log ='Round ' + round + ' ' + unit1.getName() + ' HP left: ' + unit1.getHp() + ' ' +
                      unit2.getName() + ' HP left: ' + unit2.getHp() + ' ' + 
                      unit1.getName() + ' blocks the hit!' + unit2.getName() + ' blocks the hit!';
            }
        
        round++;    
        return log;     
        }
        else if (unit1.getHp() > 0 && unit2.getHp() <= 0)
        {
            winner = unit1;
            message = unit1.getName() + ' wins';
        }
        else if(unit2.getHp() > 0 && unit1.getHp() <= 0)
        {
            winner = unit2;
            message = unit2.getName() + ' wins';
        }
        else
        {
            winner = NULL;
            message = 'It was a great fight! Both fighters were killed!';
        }    
        
        if(winner.equals(unit1))
        {
            winner2.Lose_Date__c = Date.today();
        }
        else if(winner.equals(unit2))
        {
            winner1.Lose_Date__c = Date.today();
        }
        else
        {
            winner1.Lose_Date__c = Date.today();
            winner2.Lose_Date__c = Date.today();
        }
        
        update winner1;
        update winner2;
        unitsList = getUnits();
        round = 1;
        choseFighters = true;
        isFight = false;      
        return message;
    }
    
    /**
    *this method returns damage
    *unit 1 makes a hit
    *unit 2 defences
    *Also method sets if fighter miss, make a crit or make a normal hit
    *fighter can miss the target in 25% cases and
    *make crit in 10% cases
    *crit = demage * 2
    */
    public Integer hitStrike(Unit unit1, Unit unit2)
    {
        Integer missOrCrit = (Integer)(Math.random() * 100);

        if(missOrCrit < 25)
        {
            damage = 0;
            log += ' ' + unit1.getName() + ' missed!';
            //fightLog.add(log);
        }
        else if(missOrCrit > 90) 
        {
            damage = ((Integer)(Math.random() * (unit1.getDmgMax() - unit1.getDmgMin() + 1) + unit1.getDmgMin())) * 2;
            log += ' ' + unit1.getName() + ' made CRIT! and kicked ' + unit2.getName() + ' in ' + whereHit + ' on ' + damage;  
            //fightLog.add(log);
        }   
        else
        {
            damage = (Integer)(Math.random() * (unit1.getDmgMax() - unit1.getDmgMin() + 1) + unit1.getDmgMin());
            log += ' ' + unit1.getName() + ' kicked ' + unit2.getName() + ' in ' + whereHit + ' on ' + damage;
            //fightLog.add(log);
        }
            
        return damage;
    } 
}