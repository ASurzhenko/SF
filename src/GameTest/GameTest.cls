@isTest
public class GameTest {
    @isTest private static void createUnitsTest()
    {
        GameController game = new GameController();
        Unit unit = new Unit('test unit', 600, 10, 30);
                
        Unit__c fighter1 = new Unit__c(Name = 'test unit1', HP__c = 600, Min_Damage__c = 10, Max_Damage__c = 30);
        Unit__c fighter2 = new Unit__c(Name = 'test unit2', HP__c = 700, Min_Damage__c = 20, Max_Damage__c = 40);
    	
    	game.createUnits(fighter1, fighter2); 
        System.assertEquals('test unit', unit.getName());
        System.assertEquals(600, unit.getHp());
        System.assertEquals(10, unit.getDmgMin());
        System.assertEquals(30, unit.getDmgMax());
    }
    
    @isTest private static void createSelectOptionListForRadiobuttonsTest()
    {
    	GameController game = new GameController();
        List<SelectOption> optionsList = game.getPlace();
        System.assertNotEquals(0, optionsList.size());
    }
    
    @isTest private static void addFighterTest()
    {
        Unit__c fighter1 = new Unit__c(Name = 'test unit1', HP__c = 600, Min_Damage__c = 10, Max_Damage__c = 30);
        insert fighter1;
        GameController game = new GameController();
        game.addFighter();
        System.assertEquals(1, game.unitsList.size());
        System.assertEquals(false, game.choseFighters);
        //System.assertEquals(true, game.isVisible);
        System.assertEquals(true, game.addNewFighter);
    }
    
	@isTest private static void CorrectNumbersOfFightersTest()    
    {
        GameController game = new GameController();
        Unit__c fighter1 = new Unit__c(Name = 'test unit1', HP__c = 600, Min_Damage__c = 10, Max_Damage__c = 30);
        Unit__c fighter2 = new Unit__c(Name = 'test unit2', HP__c = 700, Min_Damage__c = 20, Max_Damage__c = 40);
        insert fighter1;
        insert fighter2;
        Gamecontroller.Wrapper gameWrap = new GameController.Wrapper(fighter1, true);
        Gamecontroller.Wrapper gameWrap1 = new GameController.Wrapper(fighter2, true);
        game.unitsList.add(gameWrap);
        game.unitsList.add(gameWrap1);
        game.goFight();
    }

	@isTest private static void notCorrectNumbersOfFightersTest()    
    {
        GameController game = new GameController();
        Unit__c fighter1 = new Unit__c(Name = 'test unit1', HP__c = 600, Min_Damage__c = 10, Max_Damage__c = 30);
        Unit__c fighter2 = new Unit__c(Name = 'test unit2', HP__c = 700, Min_Damage__c = 20, Max_Damage__c = 40);
        insert fighter1;
        insert fighter2;
        Gamecontroller.Wrapper gameWrap = new GameController.Wrapper(fighter1, false);
        Gamecontroller.Wrapper gameWrap1 = new GameController.Wrapper(fighter2, true);
        game.unitsList.add(gameWrap);
        game.unitsList.add(gameWrap1);
        game.goFight();
    }
    
    @isTest private static void makeHitErrorTest()
    {
        GameController game = new GameController();
        game.makeHit();
        
        System.assertEquals(NULL, game.getLog());
    }
    
    @isTest private static void bothFightersMakeHitTest()
    {
        GameController game = new GameController();
        Unit__c fighter1 = new Unit__c(Name = 'test unit1', HP__c = 600, Min_Damage__c = 10, Max_Damage__c = 30);
        Unit__c fighter2 = new Unit__c(Name = 'test unit2', HP__c = 700, Min_Damage__c = 20, Max_Damage__c = 40);
      	game.createUnits(fighter1, fighter2); 
        game.setHit('Head');
        game.setBlock('Head');
        
        while(game.forRandomHitTest != 1)
        {
        	game.makeHit();
        }
        
        System.assertEquals('Head', game.getBlock());
        System.assertEquals('Head', game.getHit());
    }
    
    @isTest private static void onlySomeFighterMakesHitTest()
    {
        GameController game = new GameController();
        Unit__c fighter1 = new Unit__c(Name = 'test unit1', HP__c = 600, Min_Damage__c = 10, Max_Damage__c = 30);
        Unit__c fighter2 = new Unit__c(Name = 'test unit2', HP__c = 700, Min_Damage__c = 20, Max_Damage__c = 40);
        insert fighter1;
        insert fighter2;
        game.winner1 = fighter1;
        game.winner2 = fighter2;
      	game.createUnits(fighter1, fighter2); 
        game.setHit('Head');
        game.setBlock('Head');
        
        while(game.forRandomHitTest != 2)
        {
        	game.makeHit();
        }
    }
    
    @isTest private static void onlySomeAnotherFighterMakesHitTest()
    {
        GameController game = new GameController();
        Unit__c fighter1 = new Unit__c(Name = 'test unit1', HP__c = 600, Min_Damage__c = 10, Max_Damage__c = 30);
        Unit__c fighter2 = new Unit__c(Name = 'test unit2', HP__c = 700, Min_Damage__c = 20, Max_Damage__c = 40);
        insert fighter1;
        insert fighter2;
        game.winner1 = fighter1;
        game.winner2 = fighter2;
       	game.createUnits(fighter1, fighter2); 
        game.setHit('Head');
        game.setBlock('Head');
        
        while(game.forRandomHitTest != 3)
        {
        	game.makeHit();
        }
    }   
    
    @isTest private static void bothFightersBlockTheHitTest()
    {
        GameController game = new GameController();
        Unit__c fighter1 = new Unit__c(Name = 'test unit1', HP__c = 600, Min_Damage__c = 10, Max_Damage__c = 30);
        Unit__c fighter2 = new Unit__c(Name = 'test unit2', HP__c = 700, Min_Damage__c = 20, Max_Damage__c = 40);
        insert fighter1;
        insert fighter2;
        game.winner1 = fighter1;
        game.winner2 = fighter2;
      	game.createUnits(fighter1, fighter2); 
        game.setHit('Head');
        game.setBlock('Head');
        
        while(game.forRandomHitTest != 4)
        {
        	game.makeHit();
        }
    }
    
    @isTest private static void winner1Test()
    {
    	GameController game = new GameController();
        Unit__c fighter1 = new Unit__c(Name = 'test unit1', HP__c = 600, Min_Damage__c = 10, Max_Damage__c = 30,
                                      Victory_Quantity__c = 3, Stamina__c = 80, Games_Quantity__c = 10);
        Unit__c fighter2 = new Unit__c(Name = 'test unit2', HP__c = -20, Min_Damage__c = 20, Max_Damage__c = 40,
                                      Victory_Quantity__c = 1, Stamina__c = 50, Games_Quantity__c = 13);
        insert fighter1;
        insert fighter2;
        game.winner1 = fighter1;
        game.winner2 = fighter2;
        game.createUnits(fighter1, fighter2);
       	game.setHit('Head');
        game.setBlock('Head');
        
        game.makeHit();
    }
    
    @isTest private static void winner2Test()
    {
    	GameController game = new GameController();
        Unit__c fighter1 = new Unit__c(Name = 'test unit1', HP__c = 0, Min_Damage__c = 10, Max_Damage__c = 30,
                                      Victory_Quantity__c = 3, Stamina__c = 80, Games_Quantity__c = 10);
        Unit__c fighter2 = new Unit__c(Name = 'test unit2', HP__c = 600, Min_Damage__c = 20, Max_Damage__c = 40,
                                      Victory_Quantity__c = 1, Stamina__c = 50, Games_Quantity__c = 13);
        insert fighter1;
        insert fighter2;
        game.winner1 = fighter1;
        game.winner2 = fighter2;
      	game.createUnits(fighter1, fighter2);
       	game.setHit('Head');
        game.setBlock('Head');
    
        game.makeHit();
    }
    
    @isTest private static void nobodyWinsTest()
    {
    	GameController game = new GameController();
        Unit__c fighter1 = new Unit__c(Name = 'test unit1', HP__c = -10, Min_Damage__c = 10, Max_Damage__c = 30,
                                      Games_Quantity__c = 3);
        Unit__c fighter2 = new Unit__c(Name = 'test unit2', HP__c = -20, Min_Damage__c = 20, Max_Damage__c = 40,
                                      Games_Quantity__c = 1);
        insert fighter1;
        insert fighter2;
        game.winner1 = fighter1;
        game.winner2 = fighter2;
      	game.createUnits(fighter1, fighter2);
       	game.setHit('Head');
        game.setBlock('Head');
    
        game.makeHit();
    }
    
    @isTest private static void addNewRecordTest()
    {
    	GameController game = new GameController();
        game.unit = new Unit__c(Name = 'test unit1', HP__c = 1000, Min_Damage__c = 10, Max_Damage__c = 30);
        game.newFighter();
    }
}