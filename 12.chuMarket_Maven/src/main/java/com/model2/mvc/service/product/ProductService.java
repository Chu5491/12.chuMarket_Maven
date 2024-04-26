package com.model2.mvc.service.product;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;

public interface ProductService 
{
	public Product addProduct(Product product) throws Exception;
	
	public Product getProduct(int i) throws Exception;
	
	public Map<String,Object> getProductList(Search search) throws Exception;
	
	public Product updateProduct(Product product) throws Exception;
	
	public int getProductTotal(Search search) throws Exception;
	
	public Map<String,Object> getMarketProductList(Search search, int marketNo) throws Exception;
	
	public int getMarketProductTotal(int marketNo) throws Exception;
}

