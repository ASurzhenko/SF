trigger GameTrigger on Unit__c (before update, before insert) {

    Map<Id, Unit__c> unitsMap = new Map<Id, Unit__c>();
    
    if(Trigger.isUpdate)
    {
        Boolean fireTrigger = false;
        for (Unit__c item: Trigger.new) 
        {
            if (Trigger.oldMap.get(item.Id).Victory_Quantity__c != Trigger.newMap.get(item.Id).Victory_Quantity__c) 
            {
                unitsMap.put(item.Id, item);
                fireTrigger = true;
            }
        }
        
        if (fireTrigger)
        {
            List<Unit__c> unitsList = [SELECT Id, Name, HP__c, Lose_Date__c, Max_Damage__c, Min_Damage__c,
            	                       Ressurection_Date__c, Top_Position__c, Victory_Quantity__c 
                                       FROM Unit__c WHERE Id NOT IN : unitsMap.keySet()];
            List<Unit__c> allUnits = new List<Unit__c> ();
            allUnits.addAll(unitsList);
            allUnits.addAll(unitsMap.values());

            List<SortClass> unitsToSortList = new List<SortClass>();
        
            for (Unit__c item : allUnits) 
            {
            	unitsToSortList.add(new SortClass(item));
            }
        
            unitsToSortList.sort();
        
            List<Unit__c> unitsToUpdate = new List<Unit__c>();
            Integer position = 0;
            for (SortClass item : unitsToSortList) 
            {
                position ++;
                Unit__c unit = item.getUnit();
                unit.Top_Position__c = position;
                                
                if (Trigger.newMap.containsKey(unit.Id)) 
                {
                    continue;
                } 
                else 
                {
                    unitsToUpdate.add(unit);
                }
    	    }
            
            update unitsToUpdate;
        }
    }        
}
