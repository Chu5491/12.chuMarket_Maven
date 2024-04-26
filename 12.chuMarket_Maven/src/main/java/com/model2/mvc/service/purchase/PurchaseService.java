package com.model2.mvc.service.purchase;

import java.util.Map;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Purchase;

public interface PurchaseService 
{
public Purchase addPurchase(Purchase pur) throws Exception;
	
	public Purchase getPurchase(int i) throws Exception;
	
	public Map<String,Object> getPurchaseList(Search search, String str) throws Exception;
	
	public int getPurchaseTotal(String userId) throws Exception;
	
	public Map<String,Object> getSaleList(int prodNo) throws Exception;
	
	public void updatePurchase(Purchase pur) throws Exception;
	
	public void updateTranCode(Purchase pur) throws Exception;
	
	public void decreaseStock(Purchase pur, int buyCount) throws Exception;
	
	public void increaseStock(Purchase pur, int buyCount) throws Exception;

}

