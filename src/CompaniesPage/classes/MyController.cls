public class MyController 
{
	public Company company1;
	public Company company2;
	public Order company1Order; 
	public Order company2Order;
	public Rate company1Rate;
	public Rate company2Rate;
	public WorkPeriod company1WorkPeriod;
	public WorkPeriod company2WorkPeriod;
	public List<CompaniesWrapper> wrappersList {get;set;}

	public MyController() 
	{
		createData();
		wrappersList = dataList();
	}

	public class CompaniesWrapper
	{
		public String description {get;set;}
		public Object company1 {get;set;}
		public Object company2 {get;set;}

		public CompaniesWrapper(String description, Object company1, Object company2)
		{
			this.description = description;
			this.company1 = company1;
			this.company2 = company2;
		}	
	}

	private void createData()
	{
        company1 = new Company('1', 'Company 1');
		company2 = new Company('2', 'Company 2');

        company1Order = new Order('1', 'Company 1 Order', company1); 
		company2Order = new Order('2', 'Company 2 Order', company2);
       
        company1Rate = new Rate('1', 'Company 1 Rate', 300, 500);
        company2Rate = new Rate('2', 'Company 2 Rate', 800, 1500);

        company1WorkPeriod = new WorkPeriod('1', 'Company 1 Work Period', company1Order, 
        								company1Rate, Date.today(), Date.today().addDays(60)); 
		company2WorkPeriod = new WorkPeriod('2', 'Company 2 Work Period', company2Order, 
        								company2Rate, Date.today(), Date.today().addDays(30));
	}	
    
    private List<CompaniesWrapper> dataList()
	{
		List<CompaniesWrapper> wrappersList = new List<CompaniesWrapper>();

		wrappersList.add(new CompaniesWrapper('Name: ', company1.getName(), company2.getName()));
		wrappersList.add(new CompaniesWrapper('Work period Start: ', company1WorkPeriod.getStartDate(), 
													company2WorkPeriod.getStartDate()));
        wrappersList.add(new CompaniesWrapper('Work period End: ', company1WorkPeriod.getEndDate(), 
													company2WorkPeriod.getEndDate()));
        
		wrappersList.add(new CompaniesWrapper('Revenue: ', company1Rate.getRevenue(), 
													company2Rate.getRevenue()));
		wrappersList.add(new CompaniesWrapper('Margin: ', company1Rate.getMargin(), 
													company2Rate.getMargin()));
		return wrappersList;
	}
}