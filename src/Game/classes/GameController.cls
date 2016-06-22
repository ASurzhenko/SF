public class GameController {

    /*
    *This is a custom controller of the VF Page Game
    */

    public Unit__c unit {get;set;}
    public List<Wrapper> unitsList{get;set;} 
    public List<Unit__c> fightersList {get;set;}
    public List<String> fightLog {get;set;}
    public boolean isVisible {get;set;}
    public boolean addNewFighter {get;set;}
    public boolean choseFighters {get;set;}
    public boolean isFightLog {get;set;}
    

    public GameController()
    {
        unitsList = getUnits();
        unit = new Unit__c();
        choseFighters = true;
    }


    /*
    *This method takes information from DB and creates Wrapper class objects
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
            }
           
            this.unit = unit;
            this.isSelected = isSelected;
        } 
    }


    /*
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

    /*
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
    
    /*
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
            GameWithFightLog game = new GameWithFightLog(fightersList.get(0), fightersList.get(1));
            choseFighters = true;
            addNewFighter = false;
            isFightLog = true;
            update fightersList;
            fightersList = new List<Unit__c>();
            unitsList = getUnits();
            fightLog = game.getFightLog();
        }
        else 
        {
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.FATAL,
                                                        'You have to chose 2 fighters!'));
            choseFighters = true;
            addNewFighter = false;
            isFightLog = false;
        }
        return null;
    }
    
    
}