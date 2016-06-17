public class Rate 
{
	private String id;
    private String name;
    private Integer revenue;
    private Integer margin;
    
    public Rate(String id, String name, Integer revenue, Integer margin)
    {
        this.id = id;
        this.name = name;
        this.revenue = revenue;
        this.margin = margin;
    }
    
    public String getId()
    {
    	return id;
    }

    public void setId(String id)
    {
    	this.id = id;
    }
    
     public String getName()
    {
    	return name;
    }

    public void setName(String name)
    {
    	this.name = name;
    }
    
    public Integer getRevenue()
    {
    	return revenue;
    }

    public void setRevenue(Integer revenue)
    {
    	this.revenue = revenue;
    }

    public Integer getMargin()
    {
    	return margin;
    }

    public void setMargin(Integer margin)
    {
    	this.margin = margin;
    }
}