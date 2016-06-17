public class Unit {

    private String name;
    private Integer hp;
    private Integer dmgMin;
    private Integer dmgMax;
    
    public Unit(){
        
    }
    
    public Unit(String name, Integer hp, Integer dmgMin, Integer dmgMax) {
        this.name = name;
        this.hp = hp;
        this.dmgMin = dmgMin;
        this.dmgMax = dmgMax;
    }

    public String getName{get; set;}
    public Integer getHp{get; set;}
    public Integer getDmgMin{get; set;}
    public Integer getDmgMax{get; set;}
    
    public String getName(){
        return name;
    }
    
    public void setName(String name) {
        this.name = name;
    }
    
    public Integer getHp(){
        return Hp;
    }
    
    public void setHp(Integer hp){
        this.hp = hp;
    }
    
    public Integer getDmgMin(){
        return dmgMin;
    }
    
    public void setDmgMin(Integer dmgMin) {
        this.dmgMin = dmgMin;
    }
    
    public Integer getDmgMax(){
        return dmgMax;
    }
    
     public void setDmgMax(Integer dmgMax) {
        this.dmgMax = dmgMax;
    }
    
    
}