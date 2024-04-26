package com.model2.mvc.service.product.dao;

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

@Repository("prodDAO")
public class ProductDAO implements com.model2.mvc.service.product.ProductDAO
{
	///필드
	@Autowired
	@Qualifier("sqlSessionTemplate")
	private SqlSession sqlSession;
	
	///생성자
	public ProductDAO()
	{
		System.out.println(this.getClass());
	}

	///메소드
	public void addProduct(Product product) throws Exception
	{
		sqlSession.insert("ProductMapper.addProduct", product);
	}
	
	public Product getProduct(int prodNo) throws Exception 
	{
		return sqlSession.selectOne("ProductMapper.getProduct", prodNo);
	}

	public void updateProduct(Product product) throws Exception 
	{
		sqlSession.update("ProductMapper.updateProduct", product);
	}
	
	public List<Product> getProductList(Search search) throws Exception 
	{
		return sqlSession.selectList("ProductMapper.getProductList", search);
	}
	
	public List<Product> getMarketProductList(Map map) throws Exception 
	{
		return sqlSession.selectList("ProductMapper.getMarketProductList", map);
	}
	
	public int getProductTotal(Search search) throws Exception 
	{
		return sqlSession.selectOne("ProductMapper.getProductTotal", search);
	}
	
	public int getMarketProductTotal(int marketNo) throws Exception 
	{
		return sqlSession.selectOne("ProductMapper.getMarketProductTotal", marketNo);
	}

}