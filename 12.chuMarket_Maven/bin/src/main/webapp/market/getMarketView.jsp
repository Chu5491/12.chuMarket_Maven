<%
	/***************************************************
	*	�ۼ��� : �߰��
	*	�ۼ��� : 2024-03-31
	*	��  �� : ������ FrameSet ������ 
	*			 header / article / footer 
	*			 jspInclude ������� ���� 
	*			 Bulma Css FrameWork ���뿡 ����
	*			 ������ UI ����
	****************************************************/
%>
<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
	<!-- Header -->
	<header>
		<jsp:include page="/layout/header.jsp"></jsp:include>
	</header>
	<!-- Header -->
	
	<!-- Script -->
	<script type="text/javascript">
		
		$(function() 
		{
					
			/* ########################## Style ########################## */	
			$('.articleList').on('mouseenter', '.ct_list_pop', function() 
			{
		        $(this).css('cursor', 'pointer');
		    });
			
			// articleList ��ҿ� ȣ�� �̺�Ʈ�� ���ε��մϴ�.
		    $(".articleList").on
		    ({
    	        mouseenter: function() 
    	        {
    	            // ȣ�� ������ �� ������ ���������� �����մϴ�.
    	            $(this).css("background-color", "#B4FAB4");
    	        },
    	        mouseleave: function() 
    	        {
    	            // ȣ���� ������ �� ������ ������� �ǵ����ϴ�.
    	            $(this).css("background-color", "");
    	        }
		    }, ".card");
			
			$('.articleList').on('mouseenter', '.card', function() 
			{
		        $(this).css('cursor', 'pointer');
		    });
			
			$(".title").css('cursor', 'pointer');
			
			/* ########################## Style ########################## */
			
			/* ########################## History ########################## */
			
			$(".ct_btn01").on("click", function(event) 
			{
				history.go(-1);
			});
			/* ########################## History ########################## */
			
			/* ########################## Product ########################## */
			
			$(".articleList").on("click", ".card", function(event) 
			{
				let menu = "${menu}";
		    	let stock = $(this).parent().attr('id'); 
		        let flag = $(event.target).attr("name");
		        let no = $(event.target).attr("id");
		        
			    // Ŭ���� ��Ұ� ������ .ct_list_pop ������� Ȯ���մϴ�.
			    if($(event.target).hasClass("ct_list_pop")) 
			  	{
			        if (flag == "prod") 
			        {
			        	if(menu == "manage" || menu == "bsns")
						{
							$(window.location).attr("href","/product/getProduct?prodNo=" + no + "&menu=" + menu);
						}else
						{
							if(stock == 0)
							{
								alert("ǰ���� ��ǰ�Դϴ�.");
							}else
							{
								$(window.location).attr("href","/product/getProduct?prodNo=" + no + "&menu=" + menu);
							}
						}
			        	
			        }else 
			        {
			            $(window.location).attr("href", "/market/getMarket?marketNo=" + no + "&menu="+menu);
			        }
			    }else 
			    {
			        // Ŭ���� ��Ұ� .card ����� ��쿡 ������ �ڵ带 ���⿡ �ۼ��մϴ�.
			        let no = $(this).children('div').children('div').children('div').children('p[name="prod"]').attr("id");
			        $(window.location).attr("href", "/product/getProduct?prodNo=" + no + "&menu=" + menu);
			    }
			});
			
			/* ########################## Product ########################## */
		});
	
		$(document).ready(function() 
		{
			
			//���� ������ value
		    let currentPage = $("input[name='currentPage']").val();	
		    let searchCondition = $("select[name='searchCondition']").val();	
		    let searchKeyword = $("input[name='searchKeyword']").val();
			//ajax ��� ���� ( ��ü �����͸� �̹� ȣ�� �������� ��� �� �̻��� request�� ���� ���� ���� )
			let doAjax = true;
			
			//�񵿱� �۾��� �������̸� �߰��� ��û���� �ʱ� ���� flag
		    let isLoading = false; 
			
			//ù ������ ���� �� ������ ȣ��
		    listAjax();
		    
		    // ��ũ�� �̺�Ʈ �ڵ鷯 ���
		    $(window).scroll(function() 
		    {
		        // �������� �ε� ���̰ų� �̹� Ajax ��û�� ���� ��쿡�� �߰� ��û�� ������ ����
		        if (isLoading) return;

		        let scrollPosition = $(window).scrollTop();
		        let windowHeight = $(window).height();
		        let documentHeight = $(document).height();

		        // ��ũ���� ������ �ϴܿ� �������� �� Ajax ��û�� ����
		        if (scrollPosition >= documentHeight - windowHeight * 2) 
		        {
		            isLoading = true; // Ajax ��û ���� ���·� ����
		            
		            //����Ʈ�� ȣ��
		            if(doAjax)
		            {
		            	listAjax();
		            }
		        }
		    });
		    
		    function listAjax()
		    {
		    	$.ajax
		        ({
		            url: "/market/json/getMarket?marketNo=${market.marketNo}&menu=${menu}",
		            method: "POST",
		            dataType: "json",
		            contentType: "application/json",
		            headers: 
		            {
		                "Accept": "application/json"
		            },
		            data: JSON.stringify
		            ({
		                currentPage: currentPage,
		                searchCondition:searchCondition,
		                searchKeyword:searchKeyword
		            }),
		            success: function(JSONData, status) 
		            {
		                if (JSONData.list.length > 0) 
		                {
		                    let search = JSONData.search;
		                    let list = JSONData.list;

		                    let html = "";
		                    html += "<div class='columns'>";
		                    for (let i = 0; i < list.length; i++) 
		                    {
		                    	html += "<div class='column is-4'>";
		                    	html += "	<div class='card'>";
		                    	html += "		<div class='card-image'>";
		                    	html += "			<figure class='image is-4by3'>";
	                    		html += "				<img src='/images/uploadFiles/"+list[i].upload.logiName+"' alt='Placeholder image'>";
                    			html += "			</figure>";
                   				html += "		</div>";
               					html += "		<div class='card-content' style='height:200px'>";
           						html += "			<div class='media'>";
   								html += "				<div class='media-content' id='" + list[i].prodStock + "'>";
								html += "					<p class='title is-4 ct_list_pop' name='prod' id='"+list[i].prodNo+"'>"+list[i].prodName+"</p>";
								html += "					<p class='subtitle is-9 ct_list_pop' style='z-index:1;' name='market' id='"+list[i].market.marketNo+"'>@"+list[i].market.marketName+"</p>";
								html += "				</div>";
								html += "			</div>";
								html += "			<div class='content'>";
								html += 				list[i].prodDetail;
								html += "				<br/>";
														if(list[i].prodStock <= 0)
														{
								html += "					������";		
														}else
														{
															if(list[i].prodStock <= 5)
															{
								html += "						<b style='color:red;'>ǰ���ӹ�</b>";						
															}else
															{
								html += "						<b style='color:green;'>�Ǹ���</b>";							
															}
														}
								html += "				<br>";
								html += "				<time datetime='"+list[i].regDate+"'>"+list[i].regDate+"</time>";
								html += "			</div>";
								html += "		</div>";
								html += "	</div>";
								html += "</div>";
								
		                    }
		                    html += "</div>";
		                    
		                    $(".articleList").append(html);
		                    currentPage++;
		                    $("#currentPage").val(currentPage);
		                    
		                }else
		                {
		                	//�� �̻� ��ȸ�� �����Ͱ� ������ false�� ���� �� �̻��� ����� ���� �ʵ��� flag ����
		                	doAjax = false;
		                }
		            },
		            complete: function() 
		            {
		                isLoading = false; // Ajax ��û �Ϸ� �� ���� ������Ʈ
		            }
		        });
		    }
		});
	</script>
	<!-- Script -->
	
	<body bgcolor="#ffffff" text="#000000">
		
		<!-- Article -->
		<form name="detailForm" method="post" action="/market/getMarket?marketNo=${market.marketNo}&menu=${menu}">
			<div class="table-container">
				<table class="table" width="100%" height="37" border="0" cellpadding="0" cellspacing="0">
					<tr>
						<td background="/images/ct_ttl_img02.gif" width="100%">
							<b>${market.marketName}</b>
						</td>
					</tr>
				</table>
				<div class="container is-max-desktop" style="align:center;" >
					<table class="table" width="100%" border="0" cellspacing="0" cellpadding="0"	style="margin-top: 13px;">
						<tr>
							<td height="1" colspan="3" bgcolor="D6D6D6"></td>
						</tr>
						<tr>
							<td width="104" class="ct_write">
								�Ұ�
							</td>
							<td class="ct_write01">${market.marketIntro}</td>
						</tr>
						<tr>
							<td width="104" class="ct_write">
								����� <img src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle"/>
							</td>
							<td class="ct_write01">
								<c:if test="${market.manaFlag == 'Y' }">
									���� ����� ���θ��Դϴ�.
								</c:if>
								<c:if test="${market.manaFlag == 'W' }">
									���� ���� ������� ���θ��Դϴ�.
								</c:if>
								<c:if test="${market.manaFlag == 'F' }">
									���� ��� �ߴܵ� ���θ��Դϴ�.
								</c:if>
							</td>
						</tr>
						<tr>
							<td colspan="13"z bgcolor="D6D7D6" height="1"></td>
						</tr>
					</table>
					<h3 class="title">�Ǹ����� ��ǰ</h3>
					<div class="articleList" style="align:center;">
						<div class="columns">
							<c:if test="${fn:length(list) == 0}">
								<h3 class="subtitle" style="text-align:center; width:100%; color:red;">��ϵ� ��ǰ�� �����ϴ�!</h3>
							</c:if>
							<c:if test="${fn:length(list) != 0}">
								<c:forEach var="prod" items="${list}" >
									<div class="column is-4">	
										<div class="card" style="cursor: pointer;">		
											<div class="card-image">			
												<figure class="image is-4by3">				
													<img src="/images/uploadFiles/${prod.upload.logiName}" alt="Placeholder image">			
												</figure>		
											</div>		
											<div class="card-content" style="height:200px">			
												<div class="media">				
													<div class="media-content" id="${prod.prodStock}">					
														<p class="title is-4 ct_list_pop" name="prod" id="${prod.prodNo}">${prod.prodName}</p>					
														<p class="subtitle is-9 ct_list_pop" style="z-index:1;" name="market" id="${prod.market.marketNo}">@${prod.market.marketName}</p>				
													</div>			
												</div>			
												<div class="content">
													${prod.prodDetail }				
													<br>		
													<c:if test="${prod.prodStock <= 0}">
														������
													</c:if>
													<c:if test="${prod.prodStock > 0}">
														<c:if test="${menu != 'manage' || menu != 'bsns'}">
															<c:if test="${prod.prodStock <= 5}">
																<b style="color:red;">ǰ���ӹ�</b>
															</c:if>
															<c:if test="${prod.prodStock > 5}">
																<b style="color:green;">�Ǹ���</b>
															</c:if>
														</c:if>
														<c:if test="${menu == 'manage' || menu == 'bsns'}">
															<br>
															��� : ${prod.prodStock} �� ����
														</c:if>
													</c:if>				
													<br>				
													<time datetime="${prod.regDate}">${prod.regDate}</time>			
												</div>		
											</div>	
										</div>
									</div>
								</c:forEach>
							</c:if>
						</div>
					</div>
					
					<table width="100%" border="0" cellspacing="0" cellpadding="0" class="pageNavi table" >
						<tr>
							<td align="center">
								<input type="hidden" id="currentPage" name="currentPage" value="2"/>
					    	</td>
					</table>
					<table width="100%" border="0" cellspacing="0" cellpadding="0" >
						<tr>
							<td style="float:right;"><a class="button ct_btn01" >����</a></td>	
						</tr>
					</table>
				</div>
			</div>
		</form>
		<!-- Article -->
		
		<!-- Footer -->
		<footer>
			<jsp:include page="/layout/footer.jsp"></jsp:include>
		</footer>
		<!-- Footer -->
		
	</body>
</html>