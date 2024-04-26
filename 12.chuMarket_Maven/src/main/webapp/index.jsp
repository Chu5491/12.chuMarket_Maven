<%
	/***************************************************
	*	작성자 : 추경운
	*	작성일 : 2024-04-07
	*	내  용 : 기존의 FrameSet 형식을 
	*			 header / article / footer 
	*			 jspInclude 방식으로 수정 
	*			 무한 스크롤 기능 추가작업 진행 중
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
				
				// articleList 요소에 호버 이벤트를 바인딩합니다.
			    $(".articleList").on
			    ({
	    	        mouseenter: function() 
	    	        {
	    	            // 호버 상태일 때 배경색을 빨간색으로 변경합니다.
	    	            $(this).css("background-color", "#B4FAB4");
	    	        },
	    	        mouseleave: function() 
	    	        {
	    	            // 호버가 해제될 때 배경색을 원래대로 되돌립니다.
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
				    // 클릭된 요소가 실제로 .ct_list_pop 요소인지 확인합니다.
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
				        // 클릭된 요소가 .card 요소인 경우에 실행할 코드를 여기에 작성합니다.
				        let no = $(this).children('div').children('div').children('div').children('p[name="prod"]').attr("id");
				        $(window.location).attr("href", "/product/getProduct?prodNo=" + no + "&menu=search");
				    }
				});
				
				/* ########################## Product ########################## */
			});
			
			$(document).ready(function() 
			{
				
				//현재 페이지 value
			    let currentPage = $("input[name='currentPage']").val();	
			    let searchCondition = $("select[name='searchCondition']").val();	
			    let searchKeyword = $("input[name='searchKeyword']").val();
				//ajax 통신 여부 ( 전체 데이터를 이미 호출 마무리한 경우 더 이상의 request를 막기 위해 선언 )
				let doAjax = true;
				
				//비동기 작업이 진행중이면 추가로 요청하지 않기 위한 flag
			    let isLoading = false; 
				
				//첫 페이지 진입 시 데이터 호출
			    listAjax();
			    
			    // 스크롤 이벤트 핸들러 등록
			    $(window).scroll(function() 
			    {
			        // 페이지가 로딩 중이거나 이미 Ajax 요청을 보낸 경우에는 추가 요청을 보내지 않음
			        if (isLoading) return;
	
			        let scrollPosition = $(window).scrollTop();
			        let windowHeight = $(window).height();
			        let documentHeight = $(document).height();
	
			        // 스크롤이 페이지 하단에 도달했을 때 Ajax 요청을 보냄
			        if (scrollPosition >= documentHeight - windowHeight * 2) 
			        {
			            isLoading = true; // Ajax 요청 중인 상태로 설정
			            
			            //리스트를 호출
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
									html += "					재고없음";		
															}else
															{
																if(list[i].prodStock <= 5)
																{
									html += "						<b style='color:red;'>품절임박</b>";						
																}else
																{
									html += "						<b style='color:green;'>판매중</b>";							
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
			                	//더 이상 조회할 데이터가 없으면 false를 통해 더 이상의 통신을 하지 않도록 flag 설정
			                	doAjax = false;
			                }
			            },
			            complete: function() 
			            {
			                isLoading = false; // Ajax 요청 완료 후 상태 업데이트
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
										<option value="no" ${! empty param.searchCondition && param.searchCondition == 'no' ? 'selected' : ""}>상품번호</option>
										<option value="name" ${! empty param.searchCondition && param.searchCondition == 'name' ? 'selected' : ""}>상품명</option>
										<option value="price" ${! empty param.searchCondition && param.searchCondition == 'price' ? 'selected' : ""}>상품가격</option>
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
											<button class="button ct_btn01" style="height:40px">검색</button>
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