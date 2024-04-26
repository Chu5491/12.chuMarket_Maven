package com.model2.mvc.service.purchase;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Purchase;

public interface PurchaseDAO 
{
	public Purchase getPurchase(int tran_no) throws Exception;
	
	public void addPurchase(Purchase pur) throws Exception;

	public List<Purchase> getPurchaseList(Search search,String userId) throws Exception;

	public int getPurchaseTotal(String userId) throws Exception;

	public void updatePurchase(Purchase pur) throws Exception;
	
	public void decreaseStock(Purchase pur, int buyCount) throws Exception;
	
	public void increaseStock(Purchase pur, int buyCount) throws Exception;
	
	public void updateTranCode(Purchase pur) throws Exception;
	
	public List<Purchase> getSaleList(int prodNo) throws Exception;
}
