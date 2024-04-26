package com.model2.mvc.service.market.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.product.ProductService;
import com.model2.mvc.service.product.dao.ProductDAO;
import com.model2.mvc.service.domain.Market;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.market.MarketDAO;
import com.model2.mvc.service.market.MarketService;

@Service("marketServiceImpl")
public class MarketServiceImpl implements MarketService
{
	///필드
	@Autowired
	@Qualifier("marketDAO")
	private MarketDAO marketDAO;

	///생성자

	///메소드
	public Market getMarket(int marketNo) throws Exception
	{
		Market market = marketDAO.getMarket(marketNo);
		return market;
	}
	
	public Market getMarket(String userId) throws Exception
	{
		Market market = marketDAO.getMarket(userId);
		return market;
	}
	
	public int addMarket(Market market) throws Exception
	{
		return marketDAO.addMarket(market);
	}
	
	public void deleteMarket(int marketNo) throws Exception
	{
		marketDAO.deleteMarket(marketNo);
	}
	
	public int listMarketTotal(Search search) throws Exception
	{
		return marketDAO.listMarketTotal(search);
	}
	
	public Map<String,Object> listMarket(Search search) throws Exception
	{
		Map<String, Object> map = new HashMap<String, Object>();
		List<Market> list = marketDAO.listMarket(search);
		int totalCount = marketDAO.listMarketTotal(search);
		
		map.put("list", list );
		map.put("totalCount", new Integer(totalCount));
		return map;
	}
	
	public void updateMarket(Market market) throws Exception
	{
		marketDAO.updateMarket(market);
	}
}

