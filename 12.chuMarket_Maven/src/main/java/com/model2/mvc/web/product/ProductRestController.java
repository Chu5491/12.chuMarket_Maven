package com.model2.mvc.web.product;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.servlet.ModelAndView;

import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Market;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.market.MarketService;
import com.model2.mvc.service.product.ProductService;
import com.model2.mvc.service.user.UserService;


//==> 회원관리 RestController
@RestController
@RequestMapping("/product/*")
public class ProductRestController 
{
	///Field
	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productService;
	
	@Autowired
	@Qualifier("userServiceImpl")
	private UserService userService;
	
	@Autowired
	@Qualifier("marketServiceImpl")
	private MarketService marketService;
	
	//setter Method 구현 않음
		
	//==> classpath:config/common.properties  ,  classpath:config/commonservice.xml 참조 할것
	//==> 아래의 두개를 주석을 풀어 의미를 확인 할것
	//@Value("#{commonProperties['pageUnit']}")
	//@Value("#{commonProperties['pageUnit'] ?: 3}")
	//@Value("${pageUnit ? : 3}")
	int pageUnit = 5;
	
	//@Value("#{commonProperties['pageSize']}")
	//@Value("#{commonProperties['pageSize'] ?: 2}")
	//@Value("${pageSize ? : 2}")
	int pageSize = 3;
		
	public ProductRestController(){
		System.out.println(this.getClass());
	}
	
	//테스트 완료
	@RequestMapping(value="json/getProduct", method=RequestMethod.GET)
	public Map getProduct(@RequestParam("prodNo") int prodNo, @RequestParam("menu") String menu ) throws Exception 
	{
		System.out.println("/product/json/getProduct");
		
		Product prod = productService.getProduct(prodNo);
		
		Map<String,Object> map = new HashMap<String,Object>();
		
		// Model 과 View 연결
		map.put("prod", prod);
		map.put("menu", menu);
		
		return map;
	}
	
	@RequestMapping(value="json/listProduct",method=RequestMethod.GET)
	public Map listProduct(@RequestParam("menu") String menu) throws Exception 
	{
		System.out.println("/product/json/listProduct :: GET");
		
		Search search = new Search();
		
		if(search.getCurrentPage() == 0 )
		{
			search.setCurrentPage(1);
		}
		
		search.setPageSize(pageSize);
		Map<String , Object> map;
		
		// Business logic 수행
		map = productService.getProductList(search);
		
		Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		System.out.println(resultPage);
		
		int totalCount  = productService.getProductTotal(search);
		
		// Model 과 View 연결
		map.put("menu", menu);
		map.put("resultPage", resultPage);
		map.put("search", search);
		System.out.println(search);
		return map;
	}
	
	@RequestMapping(value="json/listProduct",method=RequestMethod.POST,produces="text/plain;charset=UTF-8")
	public Map listProduct(@RequestBody Search search, @RequestParam("menu") String menu) throws Exception 
	{
		System.out.println(search);
		
		System.out.println("/product/json/listProduct :: POST");
		
		if(search.getCurrentPage() == 0 )
		{
			search.setCurrentPage(1);
		}
		
		search.setPageSize(pageSize);
		Map<String , Object> map;
		// Business logic 수행
		map = productService.getProductList(search);
		
		Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		System.out.println(resultPage);
		
		map.put("menu", menu);
		map.put("resultPage", resultPage);
		map.put("search", search);
		
		return map;
	}
}