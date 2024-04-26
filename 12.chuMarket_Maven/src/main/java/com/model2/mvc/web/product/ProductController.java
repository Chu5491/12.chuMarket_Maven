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

//==> ȸ������ Controller
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
	//setter Method ���� ����
		
	public ProductController()
	{
		System.out.println(this.getClass());
	}
	
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
		
		// Model �� View ����
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
						// ��Ű ������ �߰�
						history 	= cookie.getValue();
						history += ":" + prodNo;
						cookie 	= new Cookie("history", history);
						cookie.setPath("/");
						response.addCookie(cookie);
						break;
					}else
					{
						// ��Ű�� ������ ���� ����
						cookie = new Cookie("history", Integer.toString(prodNo));
						cookie.setPath("/");
						response.addCookie(cookie);
					}
				}
			}else
			{
				// ��Ű�� ������ ���� ����
				
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
			//���� ������ ���� ������ ����
			Upload file = new Upload();
			
			//���� ������ set �۾�
			file.setProdNo(prod.getProdNo());
			file.setFile(upload);                                                                                                                                                                                                               
			file.setPhysName(upload.getOriginalFilename());
			file.setFileDir(fileDir);
			
			//���� Ȯ���ڸ� ����
			String extension = StringUtils.getFilenameExtension(file.getPhysName());
			
			//���� ���� �� Ȯ���� �߰��۾�
			file.setLogiName(UUID.randomUUID().toString() + "." + extension);
			
			//���� ���ϸ� product ������ ����
			prod.setFileName(file.getPhysName());
			
			System.out.println("file Domain :: " + file);
            
			//���� ������ ���� path ����
			String fullPath = request.getServletContext().getRealPath("/") + file.getFileDir() + file.getLogiName();
           
            System.out.println("���� ���� fullPath :: "+ fullPath);; 
            
            //���� ��ο� ����
            file.getFile().transferTo(new File(fullPath));
            
            //�������� db�� ����
            uploadService.addUpload(file);
		}
		
		// Model �� View ����
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
		System.out.println("���� ���� ���� :: " + pastFile);
		Upload file = new Upload();
		
		if(!upload.isEmpty())
		{
			//���� ������ set �۾�
			file.setProdNo(prod.getProdNo());
			file.setFile(upload);                                                                                                                                                                                                               
			file.setPhysName(upload.getOriginalFilename());
			file.setFileDir(fileDir);
			
			//���� Ȯ���ڸ� ����
			String extension = StringUtils.getFilenameExtension(file.getPhysName());
			
			//���� ���� �� Ȯ���� �߰��۾�
			file.setLogiName(UUID.randomUUID().toString() + "." + extension);
			
			//���� ���ϸ� product ������ ����
			prod.setFileName(file.getPhysName());
			
			System.out.println("file Domain :: " + file);
            
			//���� ������ ���� path ����
			String fullPath = request.getServletContext().getRealPath("/") + file.getFileDir() + file.getLogiName();
           
            System.out.println("���� ���� fullPath :: "+ fullPath);; 
            
            //���� ��ο� ����
            file.getFile().transferTo(new File(fullPath));
            
            //�������� db�� ����
            if(pastFile == null)
            {
            	//������ ÷�������� ���ٸ� ���� ���
            	uploadService.addUpload(file);
            }else
            {
            	//������ ÷�������� �ִٸ� ������Ʈ
            	file.setFileNo(pastFile.getFileNo());
            	uploadService.updateUpload(file);
            }
		}
		
		System.out.println("fileName :: " + prod.getFileName());
		productService.updateProduct(prod);
		
		prod = productService.getProduct(prod.getProdNo());
		prod.setMarket(marketService.getMarket(prod.getMarket().getMarketNo()));
		
		file = uploadService.getUpload(prod.getProdNo());
		
		// Model �� View ����
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
		System.out.println("�˻��� : " + search.getSearchCondition() );
		
		search.setPageSize(pageSize);
		Map<String , Object> map;
		// Business logic ����
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
		
		// Model �� View ����
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("list", map.get("list"));
		modelAndView.addObject("resultPage", resultPage);
		modelAndView.addObject("search", search);
		modelAndView.addObject("menu", menu);
		
		modelAndView.setViewName("forward:/product/listProductView.jsp");
		
		return modelAndView;
	}
	
}