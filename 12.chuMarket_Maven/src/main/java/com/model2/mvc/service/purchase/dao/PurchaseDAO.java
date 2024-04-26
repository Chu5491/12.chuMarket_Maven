package com.model2.mvc.service.purchase.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.*;

@Repository("purDAO")
public class PurchaseDAO implements com.model2.mvc.service.purchase.PurchaseDAO
{
	///필드
	@Autowired
	@Qualifier("sqlSessionTemplate")
	private SqlSession sqlSession;
	
	///생성자
	public PurchaseDAO()
	{
		System.out.println(this.getClass());
	}
	
	///메소드
	public Purchase getPurchase(int tran_no) throws Exception 
	{
		Purchase pur = sqlSession.selectOne("PurchaseMapper.getPurchase", tran_no);
		pur.setBuyer(sqlSession.selectOne("UserMapper.getUser", pur.getBuyer().getUserId()));
		pur.setPurchaseProd(sqlSession.selectOne("ProductMapper.getProduct", pur.getPurchaseProd().getProdNo()));
		return pur;
	}
	
	public void addPurchase(Purchase pur) throws Exception 
	{
		sqlSession.insert("PurchaseMapper.addPurchase", pur);
	}

	public List<Purchase> getPurchaseList(Search search,String userId) throws Exception 
	{
		Map<String, Object> args = new HashMap<String, Object>();
		args.put("search", search );
		args.put("userId", userId);
				
		return sqlSession.selectList("PurchaseMapper.getPurchaseList", args);
	}
	
	public List<Purchase> getSaleList(int prodNo) throws Exception 
	{
		
		return sqlSession.selectList("PurchaseMapper.getSaleList",prodNo);
	}

	public int getPurchaseTotal(String userId) throws Exception 
	{
		return sqlSession.selectOne("PurchaseMapper.getPurchaseTotal", userId);
	}

	public void updatePurchase(Purchase pur) throws Exception 
	{
		sqlSession.update("PurchaseMapper.updatePurchase", pur);
	}
	
	public void decreaseStock(Purchase pur, int buyCount) throws Exception 
	{
		Map<String, Object> args = new HashMap<String, Object>();
		args.put("pur", pur );
		args.put("buyCount", buyCount);
		
		sqlSession.update("PurchaseMapper.decreaseStock", args);
	}
	
	public void increaseStock(Purchase pur, int buyCount) throws Exception 
	{
		Map<String, Object> args = new HashMap<String, Object>();
		args.put("pur", pur );
		args.put("buyCount", buyCount);
		
		sqlSession.update("PurchaseMapper.increaseStock", args);
	}
	
	public void updateTranCode(Purchase pur) throws Exception 
	{
		sqlSession.update("PurchaseMapper.updateTranCode", pur);
	}
	
}
