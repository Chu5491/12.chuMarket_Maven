package com.model2.mvc.service.market.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.*;
import com.model2.mvc.service.purchase.PurchaseService;
import com.model2.mvc.service.purchase.impl.PurchaseServiceImpl;

@Repository("marketDAO")
public class MarketDAO implements com.model2.mvc.service.market.MarketDAO
{
	///필드
	@Autowired
	@Qualifier("sqlSessionTemplate")
	private SqlSession sqlSession;

	///생성자
	public MarketDAO()
	{
		System.out.println(this.getClass());
	}
	
	///메소드
	public Market getMarket(int marketNo) throws Exception 
	{
		return sqlSession.selectOne("MarketMapper.getMarketNo", marketNo);
	}
	
	public Market getMarket(String userId) throws Exception 
	{
		return sqlSession.selectOne("MarketMapper.getMarketId", userId);
	}
	
	public int addMarket(Market market) throws Exception
	{
		return sqlSession.insert("MarketMapper.addMarket", market);
	}
	
	public List listMarket(Search search) throws Exception
	{
		return sqlSession.selectList("MarketMapper.listMarket", search);
	}
	
	public int listMarketTotal(Search search) throws Exception
	{
		return sqlSession.selectOne("MarketMapper.listMarketTotal", search);
	}
	
	public void deleteMarket(int marketNo) throws Exception
	{
		sqlSession.selectOne("MarketMapper.deleteMarket", marketNo);
	}
	
	public void updateMarket(Market market) throws Exception
	{
		sqlSession.update("MarketMapper.updateMarket", market);
	}
	
}