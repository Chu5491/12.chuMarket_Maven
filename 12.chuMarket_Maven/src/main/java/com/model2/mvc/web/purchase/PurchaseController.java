package com.model2.mvc.web.purchase;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.servlet.ModelAndView;

import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.Purchase;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.product.ProductService;
import com.model2.mvc.service.purchase.PurchaseService;
import com.model2.mvc.service.user.UserService;

//==> 회원관리 Controller
@Controller
@RequestMapping("/purchase/*")
public class PurchaseController 
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
		
	public PurchaseController()
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
	
	@RequestMapping("getPurchase")
	public ModelAndView getPurchase(@RequestParam("tranNo") int tranNo) throws Exception 
	{
		System.out.println("/purchase/getPurchase");
		
		// Business logic 수행
		Purchase pur = purchaseService.getPurchase(tranNo);
		System.out.println("getPurchaseView :: " + pur);
		
		// Model 과 View 연결
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("pur", pur);
		modelAndView.setViewName("forward:/purchase/getPurchaseView.jsp");
		
		return modelAndView;
	}
	
	@RequestMapping("listPurchase")
	public ModelAndView listPurchase(@ModelAttribute("search") Search search, @SessionAttribute("userInfo") User user) throws Exception 
	{
		System.out.println("/purchase/listPurchase");
		
		if(search.getCurrentPage() == 0 )
		{
			search.setCurrentPage(1);
		}
		
		search.setPageSize(pageSize);
		
		// Business logic 수행
		Map<String , Object> map = purchaseService.getPurchaseList(search,user.getUserId());
		
		Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		System.out.println(resultPage);
		
		int totalCount  = purchaseService.getPurchaseTotal(user.getUserId());
		System.out.println("PurchaseList :: " + map.get("list"));
		
		// Model 과 View 연결
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("list", map.get("list"));
		modelAndView.addObject("resultPage", resultPage);
		modelAndView.setViewName("forward:/purchase/listPurchaseView.jsp");
		
		return modelAndView;
	}
	
	@RequestMapping(value="addPurchase",method = RequestMethod.GET)
	public ModelAndView addPurchase(@RequestParam("prodNo") int prodNo) throws Exception 
	{
		System.out.println("/purchase/addPurchase :: GET");
		
		// Business logic 수행
		Product prod = productService.getProduct(prodNo);
		System.out.println("addPurchaseView :: " + prod);
		
		// Model 과 View 연결
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("prod", prod);
		modelAndView.setViewName("forward:/purchase/addPurchaseView.jsp");
		
		return modelAndView;
	}
	
	@RequestMapping(value="addPurchase",method = RequestMethod.POST)
	public ModelAndView addPurchase(@ModelAttribute("pur") Purchase pur,
									@RequestParam("prodNo") int prodNo,
									@RequestParam("buyerId") String buyerId) throws Exception 
	{
		System.out.println("/purchase/addPurchase :: post");
		
		
		// Business logic 수행
		Product prod = productService.getProduct(prodNo);
		User user	 = userService.getUser(buyerId);
		pur.setBuyer(user);
		pur.setPurchaseProd(prod);
		
		System.out.println("addPurchase :: " + pur);
		
		purchaseService.addPurchase(pur);
		purchaseService.decreaseStock(pur, pur.getTranStock());
		
		// Model 과 View 연결
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("pur", pur);
		modelAndView.setViewName("forward:/purchase/addPurchase.jsp");
		
		return modelAndView;
	}
	
	@RequestMapping(value="updatePurchase",method = RequestMethod.GET)
	public ModelAndView updatePurchase(@RequestParam("tranNo") int tranNo) throws Exception 
	{
		System.out.println("/purchase/updatePurchase :: get");
		
		Purchase pur = purchaseService.getPurchase(tranNo);
		// Business logic 수행
		
		System.out.println("updatePurchaseView :: " + pur);
		
		// Model 과 View 연결
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("pur", pur);
		modelAndView.setViewName("forward:/purchase/updatePurchaseView.jsp");
		
		return modelAndView;
	}
	
	@RequestMapping(value="updatePurchase",method = RequestMethod.POST)
	public ModelAndView updatePurchase(@ModelAttribute("pur") Purchase pur) throws Exception 
	{
		System.out.println("/purchase/updatePurchase :: post");
		
		// Business logic 수행
		Purchase purchase = purchaseService.getPurchase(pur.getTranNo());
		int tranStock 	  = pur.getTranStock();
		int pastTranStock = purchase.getTranStock();
		
		purchaseService.updatePurchase(pur);
		
		int buyCount = 0;
		if(tranStock > pastTranStock)
		{
			buyCount = tranStock - pastTranStock;
			purchaseService.decreaseStock(pur, buyCount);
		}else
		if(tranStock < pastTranStock)
		{
			buyCount = pastTranStock - tranStock;
			purchaseService.increaseStock(purchase, buyCount);
		}
		
		System.out.println("updatePurchase :: " + pur);
		
		pur = purchaseService.getPurchase(pur.getTranNo());
		
		// Model 과 View 연결
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("pur", pur);
		modelAndView.setViewName("forward:/purchase/getPurchaseView.jsp");
		
		return modelAndView;
	}
	
	@RequestMapping("listSale")
	public ModelAndView listSale(@RequestParam("prodNo") int prodNo) throws Exception 
	{
		System.out.println("/purchase/listSale");
		
		Map<String , Object> map = purchaseService.getSaleList(prodNo);
		// Business logic 수행
		
		System.out.println("listSale :: " + map.get("list"));
		
		// Model 과 View 연결
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("list", map.get("list"));
		modelAndView.setViewName("forward:/purchase/listSaleView.jsp");
		
		return modelAndView;
	}
	
	@RequestMapping("updateTranCode")
	public ModelAndView updateTranCode(@RequestParam("tranNo") int tranNo,
									   @RequestParam("menu") String menu) throws Exception 
	{
		System.out.println("/purchase/updateTranCode");
	
		
		// Business logic 수행
		Purchase pur = purchaseService.getPurchase(tranNo);
		pur.setTranCode(Integer.toString(Integer.parseInt(pur.getTranCode().trim()) + 1));
		
		purchaseService.updateTranCode(pur);
		// Model 과 View 연결
		ModelAndView modelAndView = new ModelAndView();
		if(menu.equals("sale"))
		{
			modelAndView.setViewName("redirect:/purchase/listSale?prodNo="+pur.getPurchaseProd().getProdNo());
		}else
		{
			modelAndView.setViewName("redirect:/purchase/listPurchase");
		}
		
		return modelAndView;
	}
}