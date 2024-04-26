package com.model2.mvc.service.domain;

import java.sql.Date;

public class Product 
{
	private String fileName;
	private String manuDate;
	private int    price;
	private String prodDetail;
	private String prodName;
	private int    prodNo;
	private String regDate;
	private int    prodStock;
	private String proTranCode;
	private int    purTranNo;
	private Market market;
	private Upload	upload;
	
	public Product()
	{
	}
	
	public String getProTranCode()
	{
		return proTranCode;
	}
	public void setProTranCode(String proTranCode) 
	{
		this.proTranCode = proTranCode;
	}
	public String getFileName() 
	{
		return fileName;
	}
	public void setFileName(String fileName) 
	{
		this.fileName = fileName;
	}
	public String getManuDate() 
	{
		return manuDate;
	}
	public void setManuDate(String manuDate) 
	{
		this.manuDate = manuDate;
	}
	public int getPrice() 
	{
		return price;
	}
	public void setPrice(int price)
	{
		this.price = price;
	}
	public String getProdDetail()
	{
		return prodDetail;
	}
	public void setProdDetail(String prodDetail) 
	{
		this.prodDetail = prodDetail;
	}
	public String getProdName() 
	{
		return prodName;
	}
	public void setProdName(String prodName)
	{
		this.prodName = prodName;
	}
	public int getProdNo() 
	{
		return prodNo;
	}
	public void setProdNo(int prodNo) 
	{
		this.prodNo = prodNo;
	}
	public String getRegDate() 
	{
		return regDate;
	}
	public void setRegDate(String regDate)
	{
		this.regDate = regDate;
	}

	public int getPurTranNo() 
	{
		return purTranNo;
	}

	public void setPurTranNo(int purTranNo) 
	{
		this.purTranNo = purTranNo;
	}
	
	public int getProdStock() 
	{
		return prodStock;
	}

	public void setProdStock(int prodStock) 
	{
		this.prodStock = prodStock;
	}

	public Market getMarket() 
	{
		return market;
	}

	public void setMarket(Market market) 
	{
		this.market = market;
	}

	public Upload getUpload()
	{
		return upload;
	}

	public void setUpload(Upload upload) 
	{
		this.upload = upload;
	}

	@Override
	public String toString() 
	{
		return "Product [fileName=" + fileName + ", manuDate=" + manuDate + ", price=" + price + ", prodDetail="
				+ prodDetail + ", prodName=" + prodName + ", prodNo=" + prodNo + ", regDate=" + regDate + ", prodStock="
				+ prodStock + ", proTranCode=" + proTranCode + ", purTranNo=" + purTranNo + ", market=" + market
				+ ", upload=" + upload + "]";
	}

	



}