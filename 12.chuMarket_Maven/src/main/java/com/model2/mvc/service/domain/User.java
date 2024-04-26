package com.model2.mvc.service.domain;

import java.sql.Date;


public class User 
{
	
	///Field
	private String userId;
	private String userName;
	private String password;
	private String role;
	private String ssn;
	private String phone;
	private String addr;
	private String email;
	private Date regDate;
	private String phone1;
	private String phone2;
	private String phone3;
	private Market market;
	///Constructor
	public User()
	{
		
	}
	
	///Method 
	public String getUserId() 
	{
		return userId;
	}
	
	public void setUserId(String userId) 
	{
		this.userId = userId;
	}
	
	public String getUserName() 
	{
		return userName;
	}
	
	public void setUserName(String userName) 
	{
		this.userName = userName;
	}
	
	public String getPassword() 
	{
		return password;
	}
	
	public void setPassword(String password) 
	{
		this.password = password;
	}
	
	public String getRole() 
	{
		return role;
	}
	
	public void setRole(String role) 
	{
		this.role = role;
	}
	
	public String getSsn() 
	{
		return ssn;
	}
	
	public void setSsn(String ssn) 
	{
		this.ssn = ssn;
	}
	
	public String getPhone() 
	{
		return phone;
	}
	
	public void setPhone(String phone) 
	{
		System.out.println(phone);
		if(phone != null)
		{
			this.phone = phone;
			
			this.phone1 = phone.split("-")[0];
			this.phone2 = phone.split("-")[1];
			this.phone3 = phone.split("-")[2];
			System.out.println("phoneNumb :: " + phone1 + " - " + phone2 + " - " + phone3);
		}
		
	}
	
	public String getAddr() 
	{
		return addr;
	}
	
	public void setAddr(String addr) 
	{
		this.addr = addr;
	}
	
	public String getEmail() 
	{
		return email;
	}
	
	public String getPhone1() 
	{
		return phone1;
	}
	
	public String getPhone2() 
	{
		return phone2;
	}
	
	public String getPhone3() 
	{
		return phone3;
	}
	
	public void setEmail(String email) 
	{
		this.email = email;
	}
	
	public Date getRegDate() 
	{
		return regDate;
	}
	
	public void setRegDate(Date regDate) 
	{
		this.regDate = regDate;
	}
	
	public Market getMarket() 
	{
		return market;
	}

	public void setMarket(Market market) 
	{
		this.market = market;
	}

	@Override
	public String toString() 
	{
		return "UserVO : [userId] "+userId+" [userName] "+userName+" [password] "+password+" [role] "+ role
			+" [ssn] "+ssn+" [phone] "+phone+" [email] "+email+" [regDate] "+regDate;
	}
}