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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
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
@Controller
@RequestMapping("/market/*")
public class MarketController 
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

	public MarketController()
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
	
	@RequestMapping(value="addMarket",method = RequestMethod.GET)
	public ModelAndView addMarket(@SessionAttribute("userInfo") User user) throws Exception 
	{
		System.out.println("/market/addMarket :: GET");
		
		Market market = marketService.getMarket(user.getUserId());
		System.out.println(market);
		// Model 과 View 연결
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("market", market);
		modelAndView.setViewName("forward:/market/addMarketView.jsp");

		return modelAndView;
	}

	@RequestMapping(value="addMarket",method = RequestMethod.POST)
	public ModelAndView addMarket(@ModelAttribute("market")Market market) throws Exception 
	{
		System.out.println("/market/addMarket :: POST");
		
		marketService.addMarket(market);
		market.setManaFlag("W");
		// Model 과 View 연결
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("forward:/market/addMarketView.jsp");
		
		return modelAndView;
	}

	@RequestMapping("deleteMarket")
	public ModelAndView deleteMarket(@RequestParam("marketNo") int marketNo) throws Exception 
	{
		System.out.println("/market/deleteMarket");
		
		marketService.deleteMarket(marketNo);
		
		// Model 과 View 연결
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("redirect:/market/addMarket");
		
		return modelAndView;
	}
	
	@RequestMapping("getMarket")
	public ModelAndView getMarket(@ModelAttribute("search") Search search,
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
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("market", market);
		modelAndView.addObject("list", map.get("list"));
		modelAndView.addObject("resultPage", resultPage);
		modelAndView.addObject("search", search);
		modelAndView.addObject("menu", menu);
		modelAndView.setViewName("forward:/market/getMarketView.jsp");
		
		return modelAndView;
	}
	
	@RequestMapping("listMarket")
	public ModelAndView listMarket(@ModelAttribute("search") Search search) throws Exception 
	{
		if(search.getCurrentPage() == 0 )
		{
			search.setCurrentPage(1);
		}
		System.out.println("검색어 : " + search.getSearchCondition() );
		
		search.setPageSize(pageSize);
		
		System.out.println("/market/listMarket");
		
		// Business logic 수행
		Map<String , Object> map = marketService.listMarket(search);
		
		System.out.println("getmarketlist : " + map);
		
		Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		
		System.out.println(resultPage);
		
		// Model 과 View 연결
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("list", map.get("list"));
		modelAndView.addObject("resultPage", resultPage);
		modelAndView.addObject("search", search);
		modelAndView.setViewName("forward:/market/listMarketView.jsp");
		
		return modelAndView;
	}
	
	@RequestMapping("updateMarket")
	public ModelAndView updateMarket(@RequestParam("marketNo") int marketNo,@RequestParam("manaFlag") String manaFlag, @RequestParam("userId")  String userId) throws Exception 
	{
		System.out.println("/market/updateMarketFlag");
		String flag = "";
		String role = "";
		
		if(manaFlag.equals("W"))
		{
			flag = "Y";
			role = "bsns";
		}else 
		if(manaFlag.equals("Y"))
		{
			flag = "F";
			role = "user";
		}
		
		Market market = marketService.getMarket(marketNo);
		User user = userService.getUser(userId);
		market.setManaFlag(flag);
		user.setRole(role);
		
		userService.updateUser(user);
		marketService.updateMarket(market);
		
		// Model 과 View 연결
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("redirect:/market/listMarket");
		
		return modelAndView;
	}
}