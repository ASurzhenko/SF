public class WorkPeriod 
{
	private String id;
    private String name;
    private Order order;
    private Rate rate;
    private Date startDate;
    private Date endDate;
    
    public WorkPeriod(String id, String name, Order order, Rate rate, Date startDate, Date endDate)
    {
        this.id = id;
        this.name = name;
        this.order = order;
        this.rate = rate;
        this.startDate = startDate;
        this.endDate = endDate;
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
    
    public Order getOrder()
    {
    	return order;
    }

    public void setOrder(Order order)
    {
    	this.order = order;
    }

    public Rate getRate()
    {
    	return rate;
    }

    public void setRate(Rate rate)
    {
    	this.rate = rate;
    }

    public Date getStartDate()
    {
    	return startDate;
    }

    public void setStartDate(Date startDate)
    {
    	this.startDate = startDate;
    }

    public Date getEndDate()
    {
    	return endDate;
    }

    public void setEndDate(Date endDate)
    {
    	this.endDate = endDate;
    }
}