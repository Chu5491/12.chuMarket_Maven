package com.model2.mvc.service.purchase.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.purchase.PurchaseService;
import com.model2.mvc.service.purchase.dao.PurchaseDAO;
import com.model2.mvc.service.user.UserDAO;
import com.model2.mvc.service.domain.Purchase;
import com.model2.mvc.service.product.ProductDAO;

@Service("purchaseServiceImpl")
public class PurchaseServiceImpl implements PurchaseService
{
	///필드
	@Autowired
	@Qualifier("purDAO")
	private PurchaseDAO purDAO;
	
	@Autowired
	@Qualifier("prodDAO")
	private ProductDAO prodDAO;
		
	@Autowired
	@Qualifier("userDAO")
	private UserDAO userDAO;
	
	///생성자
	public PurchaseServiceImpl()
	{
		purDAO = new PurchaseDAO();
	}
	
	///메소드
	public Purchase addPurchase(Purchase pur) throws Exception
	{
		purDAO.addPurchase(pur);
		
		return pur;
	}
	
	public Purchase getPurchase(int tranNo) throws Exception
	{
		
		return purDAO.getPurchase(tranNo);
	}
	
	public Map<String,Object> getPurchaseList(Search search, String userId) throws Exception
	{
		List<Purchase> list = purDAO.getPurchaseList(search,userId);
		List<Purchase> result = new ArrayList<Purchase>();
		int totalCount = purDAO.getPurchaseTotal(userId);
		
		for(Purchase value : list)
		{
			value.setBuyer(userDAO.getUser(value.getBuyer().getUserId()));
			value.setPurchaseProd(prodDAO.getProduct(value.getPurchaseProd().getProdNo()));
			value.setTranCode(value.getTranCode().trim());
			result.add(value);
		}
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("list", result );
		map.put("totalCount", new Integer(totalCount));
		
		return map;
	}
	
	public int getPurchaseTotal(String userId) throws Exception
	{
		int totalCount = purDAO.getPurchaseTotal(userId);
		return totalCount;
	}
	
	public Map<String,Object> getSaleList(int prodNo) throws Exception
	{
		List<Purchase> list = purDAO.getSaleList(prodNo);
		List<Purchase> result = new ArrayList<Purchase>();
		
		for(Purchase value : list)
		{
			value.setBuyer(userDAO.getUser(value.getBuyer().getUserId()));
			value.setPurchaseProd(prodDAO.getProduct(value.getPurchaseProd().getProdNo()));
			value.setTranCode(value.getTranCode().trim());
			result.add(value);
		}
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("list", result );
		
		return map;
	}
	
	public void updatePurchase(Purchase pur) throws Exception
	{
		purDAO.updatePurchase(pur);
	}
	
	public void updateTranCode(Purchase pur) throws Exception
	{
		purDAO.updateTranCode(pur);
	}
	
	@Override
	public void decreaseStock(Purchase pur, int buyCount) throws Exception 
	{
		purDAO.decreaseStock(pur,buyCount);
	}

	public void increaseStock(Purchase pur, int buyCount) throws Exception 
	{
		purDAO.increaseStock(pur,buyCount);
	}
}
