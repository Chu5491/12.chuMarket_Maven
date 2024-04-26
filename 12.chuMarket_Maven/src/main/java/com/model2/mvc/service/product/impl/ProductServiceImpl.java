package com.model2.mvc.service.product.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.product.ProductService;
import com.model2.mvc.service.product.dao.ProductDAO;
import com.model2.mvc.service.upload.UploadDAO;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.Purchase;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.market.dao.MarketDAO;

@Service("productServiceImpl")
public class ProductServiceImpl implements ProductService
{
	@Autowired
	@Qualifier("prodDAO")
	private ProductDAO prodDAO;
	
	@Autowired
	@Qualifier("marketDAO")
	private MarketDAO marketDAO;
	
	@Autowired
	@Qualifier("uploadDAO")
	private UploadDAO uploadDAO;
	public ProductServiceImpl() 
	{
		prodDAO = new ProductDAO();
	}
	
	public Product addProduct(Product product) throws Exception
	{
		prodDAO.addProduct(product);
		
		return product;
	}
	
	public Product getProduct(int prodNo) throws Exception
	{
		Product prod = prodDAO.getProduct(prodNo);
		return prod;
	}
	
	public Map<String,Object> getProductList(Search search) throws Exception
	{
		List<Product> list= prodDAO.getProductList(search);
		List<Product> result = new ArrayList<Product>();
		int totalCount = prodDAO.getProductTotal(search);
		
		for(Product value : list)
		{
			value.setMarket(marketDAO.getMarket(value.getMarket().getMarketNo()));
			value.setUpload(uploadDAO.getUpload(value.getProdNo()));

			result.add(value);
		}
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("list", result );
		map.put("totalCount", new Integer(totalCount));
		
		return map;
	}
	
	public Map<String,Object> getMarketProductList(Search search, int marketNo) throws Exception
	{
		Map<String, Object> args = new HashMap<String, Object>();
		args.put("marketNo", marketNo );
		args.put("search", search);
		System.out.println("arguments : " + args);
		List<Product> list= prodDAO.getMarketProductList(args);
		List<Product> result = new ArrayList<Product>();
		int totalCount = prodDAO.getMarketProductTotal(marketNo);
		
		for(Product value : list)
		{
			value.setMarket(marketDAO.getMarket(value.getMarket().getMarketNo()));
			value.setUpload(uploadDAO.getUpload(value.getProdNo()));
			System.out.println(value.getMarket().getMarketNo());

			result.add(value);
		}
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("list", result );
		map.put("totalCount", new Integer(totalCount));
		
		return map;
	}
	
	public int getProductTotal(Search search) throws Exception
	{
		int totalCount = prodDAO.getProductTotal(search);
		
		return totalCount;
	}
	
	public Product updateProduct(Product product) throws Exception
	{
		prodDAO.updateProduct(product);
		
		return product;
	}
	
	public int getMarketProductTotal(int marketNo) throws Exception 
	{
		return prodDAO.getMarketProductTotal(marketNo);
	}
}

