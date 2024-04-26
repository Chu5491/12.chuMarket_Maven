package com.model2.mvc.web.user;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Market;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.market.MarketService;
import com.model2.mvc.service.user.UserService;

//==> ȸ������ Controller
@Controller
@RequestMapping("/user/*")
public class UserController 
{
	///Field
	@Autowired
	@Qualifier("userServiceImpl")
	private UserService userService;
	
	@Autowired
	@Qualifier("marketServiceImpl")
	private MarketService marketService;
	//setter Method ���� ����
	
	//==> classpath:config/common.properties  ,  classpath:config/commonservice.xml ���� �Ұ�
	//==> �Ʒ��� �ΰ��� �ּ��� Ǯ�� �ǹ̸� Ȯ�� �Ұ�
	//@Value("#{commonProperties['pageUnit']}")
	//@Value("#{commonProperties['pageUnit'] ?: 3}")
	//@Value("${pageUnit ? : 3}")
	int pageUnit = 5;
	
	//@Value("#{commonProperties['pageSize']}")
	//@Value("#{commonProperties['pageSize'] ?: 2}")
	//@Value("${pageSize ? : 2}")
	int pageSize = 3;
	
	public UserController()
	{	
		System.out.println("pageUnit : " + pageUnit);
		System.out.println("pageSize : " + pageSize);
		System.out.println(this.getClass());
	}
	
	@RequestMapping(value="addUser",method = RequestMethod.GET)
	public String addUser() throws Exception 
	{
		System.out.println("/user/addUser : GET");
		
		return "redirect:/user/addUserView.jsp";
	}
	
	@RequestMapping(value="addUser",method = RequestMethod.POST)
	public String addUser( @ModelAttribute("user") User user ) throws Exception 
	{
		System.out.println("/user/addUser : POST");
		//Business Logic
		userService.addUser(user);
		
		return "redirect:/user/loginView.jsp";
	}
	
	@RequestMapping("getUser")
	public String getUser( @RequestParam("userId") String userId , Model model ) throws Exception 
	{
		System.out.println("pageUnit : " + pageUnit);
		System.out.println("pageSize : " + pageSize);
		System.out.println("/user/getUser");
		//Business Logic
		User user = userService.getUser(userId);
		// Model �� View ����
		model.addAttribute("user", user);
		
		return "forward:/user/getUser.jsp";
	}
	
	@RequestMapping( value="updateUser", method=RequestMethod.GET )
	public String updateUser( @RequestParam("userId") String userId , Model model ) throws Exception
	{

		System.out.println("/user/updateUser : GET");
		//Business Logic
		User user = userService.getUser(userId);
		// Model �� View ����
		model.addAttribute("user", user);
		
		return "forward:/user/updateUser.jsp";
	}
	
	@RequestMapping( value="updateUser", method=RequestMethod.POST )
	public String updateUser( @ModelAttribute("user") User user , Model model , HttpSession session) throws Exception
	{
		System.out.println("/user/updateUser : POST");
		//Business Logic
		System.out.println(user);
		userService.updateUser(user);
		
		String sessionId=((User)session.getAttribute("userInfo")).getUserId();
		
		if(sessionId.equals(user.getUserId()))
		{
			user = userService.getUser(sessionId);
			session.setAttribute("userInfo", user);
		}
		
		return "redirect:/user/getUser?userId="+user.getUserId();
	}
	
	@RequestMapping( value="login", method=RequestMethod.GET )
	public String login() throws Exception
	{
		
		System.out.println("/user/logon : GET");

		return "redirect:/user/loginView.jsp";
	}
	
	@RequestMapping( value="login", method=RequestMethod.POST )
	public String login(@ModelAttribute("user") User user , HttpSession session ) throws Exception
	{
		System.out.println("/user/login : POST");
		//Business Logic
		User dbUser=userService.getUser(user.getUserId());
		
		if( user.getPassword().equals(dbUser.getPassword())){
			if(dbUser.getRole().equals("bsns"))
			{
				Market market = marketService.getMarket(dbUser.getUserId());
				session.setAttribute("bsnsMarket", market);
			}
			session.setAttribute("userInfo", dbUser);
		}
		
		return "redirect:/index.jsp";
	}
	
	@RequestMapping("logout")
	public String logout(HttpSession session ) throws Exception
	{
		
		System.out.println("/user/logout");
		
		session.invalidate();
		
		return "redirect:/index.jsp";
	}
	
	@RequestMapping("checkDuplication")
	public String checkDuplication( @RequestParam("userId") String userId , Model model ) throws Exception
	{
		
		System.out.println("/user/checkDuplication");
		//Business Logic
		boolean result=userService.checkDuplication(userId);
		// Model �� View ����
		model.addAttribute("result", new Boolean(result));
		model.addAttribute("userId", userId);

		return "forward:/user/checkDuplication.jsp";
	}
	
	@RequestMapping("listUser")
	public String listUser( @ModelAttribute("search") Search search , Model model , HttpServletRequest request) throws Exception
	{
		
		System.out.println("/user/listUser : GET / POST");
		
		if(search.getCurrentPage() ==0 )
		{
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		
		// Business logic ����
		Map<String , Object> map=userService.getUserList(search);
		
		Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		System.out.println(resultPage);
		
		// Model �� View ����
		model.addAttribute("list", map.get("list"));
		model.addAttribute("resultPage", resultPage);
		model.addAttribute("search", search);
		
		return "forward:/user/listUser.jsp";
	}
}