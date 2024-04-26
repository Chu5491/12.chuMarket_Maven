<%
	/***************************************************
	*	작성자 : 추경운
	*	작성일 : 2024-03-31
	*	내  용 : 기존의 FrameSet 형식을 
	*			 header / article / footer 
	*			 jspInclude 방식으로 수정 
	*			 Bulma Css FrameWork 적용에 따른
	*			 페이지 UI 수정
	****************************************************/
%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
		        
			    // 클릭된 요소가 실제로 .ct_list_pop 요소인지 확인합니다.
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
								alert("품절된 상품입니다.");
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
			        // 클릭된 요소가 .card 요소인 경우에 실행할 코드를 여기에 작성합니다.
			        let no = $(this).children('div').children('div').children('div').children('p[name="prod"]').attr("id");
			        $(window.location).attr("href", "/product/getProduct?prodNo=" + no + "&menu=" + menu);
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
								소개
							</td>
							<td class="ct_write01">${market.marketIntro}</td>
						</tr>
						<tr>
							<td width="104" class="ct_write">
								운영정보 <img src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle"/>
							</td>
							<td class="ct_write01">
								<c:if test="${market.manaFlag == 'Y' }">
									현재 운영중인 쇼핑몰입니다.
								</c:if>
								<c:if test="${market.manaFlag == 'W' }">
									현재 승인 대기중인 쇼핑몰입니다.
								</c:if>
								<c:if test="${market.manaFlag == 'F' }">
									현재 운영이 중단된 쇼핑몰입니다.
								</c:if>
							</td>
						</tr>
						<tr>
							<td colspan="13"z bgcolor="D6D7D6" height="1"></td>
						</tr>
					</table>
					<h3 class="title">판매중인 상품</h3>
					<div class="articleList" style="align:center;">
						<div class="columns">
							<c:if test="${fn:length(list) == 0}">
								<h3 class="subtitle" style="text-align:center; width:100%; color:red;">등록된 상품이 없습니다!</h3>
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
														재고없음
													</c:if>
													<c:if test="${prod.prodStock > 0}">
														<c:if test="${menu != 'manage' || menu != 'bsns'}">
															<c:if test="${prod.prodStock <= 5}">
																<b style="color:red;">품절임박</b>
															</c:if>
															<c:if test="${prod.prodStock > 5}">
																<b style="color:green;">판매중</b>
															</c:if>
														</c:if>
														<c:if test="${menu == 'manage' || menu == 'bsns'}">
															<br>
															재고 : ${prod.prodStock} 개 남음
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
							<td style="float:right;"><a class="button ct_btn01" >이전</a></td>	
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