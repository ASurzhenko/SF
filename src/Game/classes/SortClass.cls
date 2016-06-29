public with sharing class SortClass implements Comparable {

    private Unit__c unit;
    
    public Unit__c getUnit()
    {
        return unit;
    }    
        
    public SortClass (Unit__c unit)
    {
        this.unit = unit;
    }
       
    public Integer compareTo (Object o)
    {
        SortClass unitToSort = (SortClass) o;
        
        if(unit.Victory_Quantity__c > unitToSort.unit.Victory_Quantity__c)
        {
            return -1;
        }
        else if(unit.Victory_Quantity__c < unitToSort.unit.Victory_Quantity__c)
        {
            return 1;
        }
        
        return 0;
    }
}