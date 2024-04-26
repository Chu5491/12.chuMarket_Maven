<%
	/***************************************************
	*	�ۼ��� : �߰��
	*	�ۼ��� : 2024-04-07
	*	��  �� : ������ FrameSet ������ 
	*			 header / article / footer 
	*			 jspInclude ������� ���� 
	*			 ���� ��ũ�� ��� �߰��۾� ���� ��
	****************************************************/
%>
<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<html>
	<head>
	<title>Model2 MVC Shop</title>
	</head>
	
	<body>
		<!-- Header -->
		<header>
			<jsp:include page="/layout/header.jsp"></jsp:include>
		</header>
		<!-- Header -->
		
		<!-- Script -->
		<script>
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
				
				
				/* ########################## Product ########################## */
				
				$(".articleList").on("click", ".card", function(event) 
				{
				    // Ŭ���� ��Ұ� ������ .ct_list_pop ������� Ȯ���մϴ�.
				    if($(event.target).hasClass("ct_list_pop")) 
				  	{
				        let flag = $(event.target).attr("name");
				        let no = $(event.target).attr("id");
				        
				        if (flag == "prod") 
				        {
				            $(window.location).attr("href", "/product/getProduct?prodNo=" + no + "&menu=search");
				        }else 
				        {
				            $(window.location).attr("href", "/market/getMarket?marketNo=" + no + "&menu=search");
				        }
				    }else 
				    {
				        // Ŭ���� ��Ұ� .card ����� ��쿡 ������ �ڵ带 ���⿡ �ۼ��մϴ�.
				        let no = $(this).children('div').children('div').children('div').children('p[name="prod"]').attr("id");
				        $(window.location).attr("href", "/product/getProduct?prodNo=" + no + "&menu=search");
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
			            url: "/product/json/listProduct?menu=search",
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
	   								html += "				<div class='media-content'>";
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
		
		<!-- Article -->
		<div style="width:98%; margin-left:10px;">
			<form name="detailForm" action="index.jsp" method="post">
			<div class="table-container">
				<table class="table" width="100%" height="37" border="0" cellpadding="0" cellspacing="0">
					<tr>
						<td background="/images/ct_ttl_img02.gif" width="100%">
						</td>
					</tr>
				</table>
				<div class="container is-max-desktop" >
					<table width="100%" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td align="right">
								<div class="select">
									<select name="searchCondition" class="ct_input_g" style="height:40px">
										<option value="no" ${! empty param.searchCondition && param.searchCondition == 'no' ? 'selected' : ""}>��ǰ��ȣ</option>
										<option value="name" ${! empty param.searchCondition && param.searchCondition == 'name' ? 'selected' : ""}>��ǰ��</option>
										<option value="price" ${! empty param.searchCondition && param.searchCondition == 'price' ? 'selected' : ""}>��ǰ����</option>
									</select>
								</div>
								<input type="text" name="searchKeyword"  value="${param.searchKeyword }" 
									class="ct_input_g input" style="width:200px; height:40px" >
							</td>
							<td align="right" width="70">
								<table border="0" cellspacing="0" cellpadding="0">
									<tr>
										<td width="17" height="23">
											<img src="/images/ct_btnbg01.gif" width="17" height="23">
										</td>
										<td align="right" width="70">
											<button class="button ct_btn01" style="height:40px">�˻�</button>
										</td>
										<td width="14" height="23">
											<img src="/images/ct_btnbg03.gif" width="14" height="23">
										</td>
									</tr>
								</table>
							</td>
						</tr>
					</table>
					<br><br>
					<table class="table" width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
						<input type="hidden" id="currentPage" name="currentPage" value="1"/>
						<div class="articleList" style="align:center;">
			
						</div>
					</table>
				</div>	
			</div>
			</form>
		</div>
		<!-- Article -->
		
		<!-- Footer -->
		<footer>
			<jsp:include page="/layout/footer.jsp"></jsp:include>
		</footer>
		<!-- Footer -->
	</body>
</html>