package com.model2.mvc.web.purchase;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.SessionAttribute;

import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.Purchase;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.product.ProductService;
import com.model2.mvc.service.purchase.PurchaseService;
import com.model2.mvc.service.user.UserService;

//==> 회원관리 Controller
@RestController
@RequestMapping("/purchase/*")
public class PurchaseRestController 
{
	///Field
	@Autowired
	@Qualifier("purchaseServiceImpl")
	private PurchaseService purchaseService;
	
	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productService;
	
	@Autowired
	@Qualifier("userServiceImpl")
	private UserService userService;
	//setter Method 구현 않음
		
	public PurchaseRestController()
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
	
	@RequestMapping(value="json/getPurchase",method=RequestMethod.GET )
	public Purchase getPurchase(@RequestParam("tranNo") int tranNo) throws Exception 
	{
		System.out.println("/purchase/json/getPurchase :: GET");
		
		// Business logic 수행
		Purchase pur = purchaseService.getPurchase(tranNo);
		if(pur != null)
		{
			System.out.println("getPurchaseView :: " + pur);
		}
		return pur;
	}
	
	@RequestMapping(value="json/listPurchase",method = RequestMethod.GET)
	public Map listPurchase(@SessionAttribute("user") User user) throws Exception 
	{
		System.out.println("/purchase/json/listPurchase :: GET");
		Search search = new Search();
		
		if(search.getCurrentPage() == 0 )
		{
			search.setCurrentPage(1);
		}
		
		search.setPageSize(pageSize);
		
		// Business logic 수행
		Map<String , Object> map = purchaseService.getPurchaseList(search,user.getUserId());
		
		Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		System.out.println(resultPage);
		
		System.out.println("PurchaseList :: " + map.get("list"));
		
		map.put("list",  map.get("list"));
		map.put("resultPage", resultPage);
		
		return map;
	}
	
	@RequestMapping(value="json/listSale",method=RequestMethod.GET)
	public Map listSale(@RequestParam("prodNo") int prodNo) throws Exception 
	{
		System.out.println("/purchase/listSale :: GET");
		
		Map<String , Object> map = purchaseService.getSaleList(prodNo);
		// Business logic 수행
		
		System.out.println("listSale :: " + map.get("list"));
		
		
		return map;
	}
}