package com.model2.mvc.web.market;

import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
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
import com.model2.mvc.service.domain.Purchase;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.market.MarketService;
import com.model2.mvc.service.product.ProductService;
import com.model2.mvc.service.user.UserService;

//==> 회원관리 Controller
@RestController
@RequestMapping("/market/*")
public class MarketRestController 
{
	///Field
	@Autowired
	@Qualifier("marketServiceImpl")
	private MarketService marketService;
	
	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productService;
	
	@Autowired
	@Qualifier("userServiceImpl")
	private UserService userService;
	//setter Method 구현 않음

	public MarketRestController()
	{
		System.out.println(this.getClass());
	}
	
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
	
	@RequestMapping("json/getMarket")
	public Map getMarket(@RequestBody Search search,
								  @RequestParam("marketNo") int marketNo,
								  @RequestParam("menu") String menu) throws Exception 
	{
		if(search.getCurrentPage() == 0 )
		{
			search.setCurrentPage(1);
		}
		System.out.println("검색어 : " + search.getSearchCondition() );
		
		search.setPageSize(pageSize);
		
		System.out.println("/market/getMarket");
		
		
		// Business logic 수행
		Market market = marketService.getMarket(marketNo);
		Map<String , Object> map = productService.getMarketProductList(search,marketNo);
		
		System.out.println("getmarketlist : " + map);
		
		Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		
		System.out.println(resultPage);
		
		int totalCount  = productService.getProductTotal(search);

		System.out.println("Market Info : " + market);
		// Model 과 View 연결
		map.put("market", market);
		map.put("list", map.get("list"));
		map.put("resultPage", resultPage);
		map.put("search", search);
		map.put("menu", menu);
		
		return map;
	}
	
}