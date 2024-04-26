package com.model2.mvc.service.market;

import java.util.Map;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Market;
import com.model2.mvc.service.domain.Product;

public interface MarketService 
{
	public Market getMarket(int marketNo) throws Exception;
	
	public Market getMarket(String userId) throws Exception;
	
	public int addMarket(Market market) throws Exception;
	
	public void deleteMarket(int marketNo) throws Exception;
	
	public Map listMarket(Search search) throws Exception;
	
	public int listMarketTotal(Search search) throws Exception;
	
	public void updateMarket(Market market) throws Exception;
}

