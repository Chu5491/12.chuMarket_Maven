package com.model2.mvc.web.user;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.user.UserService;


//==> 회원관리 RestController
@RestController
@RequestMapping("/user/*")
public class UserRestController 
{
	///Field
	@Autowired
	@Qualifier("userServiceImpl")
	private UserService userService;
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
		
	public UserRestController(){
		System.out.println(this.getClass());
	}
	
	//테스트 완료
	@RequestMapping(value="/json/getUser", method=RequestMethod.GET )
	public User getUser( @RequestParam("userId") String userId) throws Exception 
	{
		System.out.println("/user/json/json/getUser :: GET");
		//Business Logic
		User user = userService.getUser(userId);
		System.out.println(user);
		return user;
	}
	
	//테스트 완료
	@RequestMapping( value="/json/login", method=RequestMethod.POST )
	public User login(@RequestBody User user, HttpSession session ) throws Exception
	{
		System.out.println("/user/json/login : POST");
		//Business Logic
		User dbUser=userService.getUser(user.getUserId());
		
		if( user.getPassword().equals(dbUser.getPassword())){
			session.setAttribute("userInfo", dbUser);
		}
		
		return dbUser;
	}
	
	//테스트 완료
	@RequestMapping(value="/json/checkDuplication", method=RequestMethod.GET)
	public String checkDuplication(@RequestParam("userId") String userId) throws Exception
	{
		System.out.println("/user/json/checkDuplication");
		//Business Logic
		boolean result=userService.checkDuplication(userId);
		// Model 과 View 연결

		return "{\"result\": \""+result+"\"}";
	}
	
	//테스트 완료
	@RequestMapping(value="/json/listUser", method=RequestMethod.POST)
	public List listUser( @RequestBody Search search ) throws Exception
	{
		
		System.out.println("/user/json/listUser : GET / POST");
		
		if(search.getCurrentPage() ==0 )
		{
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		
		// Business logic 수행
		Map<String , Object> map=userService.getUserList(search);
		
		Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		System.out.println(resultPage);
		
		// Model 과 View 연결
		
		return (ArrayList)map.get("list");
	}
	
	//테스트 완료
	@RequestMapping(value="/json/getUserDomain", method=RequestMethod.POST)
	public User getUserDomain( @RequestBody User user ) throws Exception
	{
		
		System.out.println("/user/json/getUserDomain : GET / POST");
		
		System.out.println(user);
		
		// Model 과 View 연결
		
		return user;
	}
}