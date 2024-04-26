package com.model2.mvc.service.domain;

import java.sql.Date;

public class Market 
{
	private int      marketNo;
	private String 	 userId;
	private String 	 marketName;
	private String	 marketIntro;
	private String 	 marketAddr;
	private String 	 openDate;
	private String   manaFlag;

	public Market()
	{
		
	}

	public int getMarketNo()
	{
		return marketNo;
	}

	public void setMarketNo(int marketNo)
	{
		this.marketNo = marketNo;
	}

	public String getUserId()
	{
		return userId;
	}

	public void setUserId(String userId) 
	{
		this.userId = userId;
	}

	public String getMarketName()
	{
		return marketName;
	}

	public void setMarketName(String marketName) 
	{
		this.marketName = marketName;
	}

	public String getMarketIntro()
	{
		return marketIntro;
	}

	public void setMarketIntro(String marketIntro) 
	{
		this.marketIntro = marketIntro;
	}

	public String getMarketAddr() 
	{
		return marketAddr;
	}

	public void setMarketAddr(String marketAddr) 
	{
		this.marketAddr = marketAddr;
	}

	public String getOpenDate() 
	{
		return openDate;
	}

	public void setOpenDate(String openDate) 
	{
		this.openDate = openDate;
	}

	public String getManaFlag() 
	{
		return manaFlag;
	}

	public void setManaFlag(String manaFlag) 
	{
		this.manaFlag = manaFlag;
	}

	@Override
	public String toString() 
	{
		return "Market [marketNo=" + marketNo + ", userId=" + userId + ", marketName=" + marketName + ", marketIntro="
				+ marketIntro + ", marketAddr=" + marketAddr + ", openDate=" + openDate + ", manaFlag=" + manaFlag
				+ "]";
	}
	
}