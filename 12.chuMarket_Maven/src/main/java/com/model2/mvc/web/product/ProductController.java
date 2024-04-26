package com.model2.mvc.web.product;

import java.io.File;
import java.util.Map;
import java.util.UUID;

import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Upload;
import com.model2.mvc.service.domain.Market;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.market.MarketService;
import com.model2.mvc.service.product.ProductService;
import com.model2.mvc.service.upload.UploadService;
import com.model2.mvc.service.user.UserService;

//==> 회원관리 Controller
@Controller
@RequestMapping("/product/*")
public class ProductController 
{
	///Field
	@Value("${fileDir}")
    private String fileDir;
	
	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productService;
	
	@Autowired
	@Qualifier("userServiceImpl")
	private UserService userService;
	
	@Autowired
	@Qualifier("marketServiceImpl")
	private MarketService marketService;
	
	@Autowired
	@Qualifier("uploadServiceImpl")
	private UploadService uploadService;
	//setter Method 구현 않음
		
	public ProductController()
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
	
	@RequestMapping("getProduct")
	public ModelAndView getProduct(@RequestParam("prodNo") int prodNo,
								   @RequestParam("menu") String menu, 
								   HttpServletResponse response,
								   HttpServletRequest request) throws Exception 
	{
		System.out.println("/product/getProduct");
		
		Product prod  = productService.getProduct(prodNo);
		Upload upload = uploadService.getUpload(prodNo);
		
		prod.setMarket(marketService.getMarket(prod.getMarket().getMarketNo()));
		
		// Model 과 View 연결
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("prod", prod);
		modelAndView.addObject("upload", upload);
		modelAndView.addObject("menu", menu);
		if(menu.equals("manage") || menu.equals("bsns"))
		{
			modelAndView.setViewName("forward:/product/updateProductView.jsp");
		}else
		{
			Cookie[] cookies 	= request.getCookies();
			String history 		= "";
			if(cookies != null)
			{
				for(Cookie cookie : cookies)
				{
					if(cookie.getName().equals("history"))
					{
						// 쿠키 있으면 추가
						history 	= cookie.getValue();
						history += ":" + prodNo;
						cookie 	= new Cookie("history", history);
						cookie.setPath("/");
						response.addCookie(cookie);
						break;
					}else
					{
						// 쿠키가 없으면 새로 생성
						cookie = new Cookie("history", Integer.toString(prodNo));
						cookie.setPath("/");
						response.addCookie(cookie);
					}
				}
			}else
			{
				// 쿠키가 없으면 새로 생성
				
				Cookie cookie = new Cookie("history", Integer.toString(prodNo));
				cookie.setPath("/");
				response.addCookie(cookie);
			}
			
			modelAndView.setViewName("forward:/product/getProductView.jsp");
		}
		
		return modelAndView;
	}
	
	@RequestMapping("addProduct")
	public ModelAndView addProduct(@ModelAttribute("prod") Product prod ,@SessionAttribute("userInfo") User user, @RequestParam("file") MultipartFile upload,HttpServletRequest request) throws Exception 
	{
		System.out.println("/product/addProduct");
		System.out.println(prod);
		System.out.println("fileGetName : " + upload.getName());
		System.out.println("fileOriginName : " + upload.getOriginalFilename());
		
		prod.setManuDate(prod.getManuDate().replace("-",""));
		prod.setFileName(upload.getOriginalFilename());
		Market market = marketService.getMarket(user.getUserId());
		System.out.println(market);
		prod.setMarket(market);
		System.out.println(prod);
		prod = productService.addProduct(prod);
		
		if(!upload.isEmpty())
		{
			//파일 저장을 위한 도메인 생성
			Upload file = new Upload();
			
			//파일 도메인 set 작업
			file.setProdNo(prod.getProdNo());
			file.setFile(upload);                                                                                                                                                                                                               
			file.setPhysName(upload.getOriginalFilename());
			file.setFileDir(fileDir);
			
			//파일 확장자명 추출
			String extension = StringUtils.getFilenameExtension(file.getPhysName());
			
			//파일 논리명 및 확장자 추가작업
			file.setLogiName(UUID.randomUUID().toString() + "." + extension);
			
			//물리 파일명 product 도메인 저장
			prod.setFileName(file.getPhysName());
			
			System.out.println("file Domain :: " + file);
            
			//파일 저장을 위한 path 설정
			String fullPath = request.getServletContext().getRealPath("/") + file.getFileDir() + file.getLogiName();
           
            System.out.println("파일 저장 fullPath :: "+ fullPath);; 
            
            //파일 경로에 저장
            file.getFile().transferTo(new File(fullPath));
            
            //파일정보 db에 저장
            uploadService.addUpload(file);
		}
		
		// Model 과 View 연결
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("menu", "search");
		
		modelAndView.setViewName("forward:/product/getProductView.jsp");
		
		return modelAndView;
	}
	
	@RequestMapping("updateProduct")
	public ModelAndView updateProduct(@ModelAttribute("prod") Product prod,@RequestParam("file") MultipartFile upload,HttpServletRequest request) throws Exception 
	{
		System.out.println("/product/updateProduct");
		
		Upload pastFile = uploadService.getUpload(prod.getProdNo());
		System.out.println("기존 파일 여부 :: " + pastFile);
		Upload file = new Upload();
		
		if(!upload.isEmpty())
		{
			//파일 도메인 set 작업
			file.setProdNo(prod.getProdNo());
			file.setFile(upload);                                                                                                                                                                                                               
			file.setPhysName(upload.getOriginalFilename());
			file.setFileDir(fileDir);
			
			//파일 확장자명 추출
			String extension = StringUtils.getFilenameExtension(file.getPhysName());
			
			//파일 논리명 및 확장자 추가작업
			file.setLogiName(UUID.randomUUID().toString() + "." + extension);
			
			//물리 파일명 product 도메인 저장
			prod.setFileName(file.getPhysName());
			
			System.out.println("file Domain :: " + file);
            
			//파일 저장을 위한 path 설정
			String fullPath = request.getServletContext().getRealPath("/") + file.getFileDir() + file.getLogiName();
           
            System.out.println("파일 저장 fullPath :: "+ fullPath);; 
            
            //파일 경로에 저장
            file.getFile().transferTo(new File(fullPath));
            
            //파일정보 db에 저장
            if(pastFile == null)
            {
            	//기존에 첨부파일이 없다면 새로 등록
            	uploadService.addUpload(file);
            }else
            {
            	//기존에 첨부파일이 있다면 업데이트
            	file.setFileNo(pastFile.getFileNo());
            	uploadService.updateUpload(file);
            }
		}
		
		System.out.println("fileName :: " + prod.getFileName());
		productService.updateProduct(prod);
		
		prod = productService.getProduct(prod.getProdNo());
		prod.setMarket(marketService.getMarket(prod.getMarket().getMarketNo()));
		
		file = uploadService.getUpload(prod.getProdNo());
		
		// Model 과 View 연결
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("prod", prod);
		modelAndView.addObject("menu", "search");
		modelAndView.addObject("upload", file);
		modelAndView.setViewName("forward:/product/getProductView.jsp");
		
		return modelAndView;
	}
	
	@RequestMapping("listProduct")
	public ModelAndView listProduct(@ModelAttribute("search") Search search, @RequestParam("menu") String menu, @SessionAttribute("userInfo") User user) throws Exception 
	{
		System.out.println("/product/listProduct");
		
		if(search.getCurrentPage() == 0 )
		{
			search.setCurrentPage(1);
		}
		System.out.println("검색어 : " + search.getSearchCondition() );
		
		search.setPageSize(pageSize);
		Map<String , Object> map;
		// Business logic 수행
		Market market;
		
		if(menu.equals("bsns"))
		{
			market = marketService.getMarket(user.getUserId());
			map = productService.getMarketProductList(search,market.getMarketNo());
		}else
		{
			map = productService.getProductList(search);
		}
		
		
		Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		System.out.println(resultPage);
		
		int totalCount  = productService.getProductTotal(search);
		
		// Model 과 View 연결
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("list", map.get("list"));
		modelAndView.addObject("resultPage", resultPage);
		modelAndView.addObject("search", search);
		modelAndView.addObject("menu", menu);
		
		modelAndView.setViewName("forward:/product/listProductView.jsp");
		
		return modelAndView;
	}
	
}