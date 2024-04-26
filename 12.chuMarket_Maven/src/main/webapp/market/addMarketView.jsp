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
			var detailForm = $("form[name=detailForm]");
			
			/* ########################## Style ########################## */	
			$(".ct_btn01").css('cursor', 'pointer');
			/* ########################## Style ########################## */	
			
			
			/* ########################## Market ########################## */
			$( ".ct_btn01:contains('입점신청')" ).on("click" , function() 
		 	{
				////////// 입점신청 클릭 시 //////////
				//Form 유효성 검증
			 	var name  = $("#marketName");
				var intro = $("#marketIntro");
				var addr  = $("#marketAddr");
	
				if(name.val() == null || name.val().length<1)
				{
					alert("상호명은 반드시 입력하여야 합니다.");
					name.focus();
					return;
				}
				if(intro.val() == null || intro.val().length<1)
				{
					alert("소개는 반드시 입력하여야 합니다.");
					intro.focus();
					return;
				}
				if(addr.val() == null || addr.val().length<1)
				{
					alert("사업장 주소는 반드시 입력하셔야 합니다.");
					addr.focus();
					return;
				}
				
				detailForm.attr('action','/market/addMarket').submit();
			}); 
			
			$( ".ct_btn01:contains('취소')" ).on("click" , function() 
			{
				if($(this).text().trim() == '취소')
				{
					detailForm.each(function()
					{
						this.reset();
					});
				}else
				{
					 if (!confirm("취소 진행 시 정보는 초기화되며, 재신청 시 다시 작성하셔야 합니다. \n취소하시겠습니까?")) 
					 {
						 
					 } else 
					 {
						detailForm.attr('action','/market/deleteMarket?marketNo=${market.marketNo}').submit();
					 }
				}
			});
			
			$( ".ct_btn01:contains('이전')" ).on("click" , function() 
			{
				history.go(-1);
			});
			/* ########################## Market ########################## */
		});
	</script>
	<!-- Script -->

	<body bgcolor="#ffffff" text="#000000">
		
		<!-- Article -->
		<form name="detailForm" method="post">
		<input type="hidden" name="userId" value="${userInfo.userId}"/>
			<div class="table-container">
				<table class="table" width="100%" height="37" border="0" cellpadding="0" cellspacing="0">
					<tr>
						<td background="/images/ct_ttl_img02.gif" width="100%">
							<b>입점신청</b>
						</td>
					</tr>
				</table>
				<div class="container is-max-desktop" style="align:center;" >
					<table class="table" width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top: 13px;">
						<c:if test="${!empty market}">
							<tr>
								<td height="1" colspan="3" bgcolor="D6D6D6"></td>
							</tr>
							<tr>
								<td width="130" class="ct_write">
									신청번호
									<imgsrc="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle">
								</td>
								<td class="ct_write01">
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td width="105">
												${market.marketNo}
											</td>
										</tr>
									</table>
								</td>
							</tr>
						</c:if>
						<tr>
							<td width="130" class="ct_write">
								신청자 아이디 
								<imgsrc="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle">
							</td>
							<td class="ct_write01">
								<table width="100%" border="0" cellspacing="0" cellpadding="0">
									<tr>
										<td width="105">
											${userInfo.userId}
										</td>
									</tr>
								</table>
							</td>
						</tr>
						<tr>
							<td width="130" class="ct_write">
								상호명 
								<imgsrc="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle">
							</td>
							<td class="ct_write01">
								<table width="100%" border="0" cellspacing="0" cellpadding="0">
									<tr>
										<c:if test="${!empty market}">
											<td width="105">
												${market.marketName}
											</td>
										</c:if>
										<c:if test="${empty market}">
											<td width="105">
												<input type="text" name="marketName" id="marketName" class="ct_input_g input" style="width: 130px; height: 30px" maxLength="20">
											</td>
										</c:if>
									</tr>
								</table>
							</td>
						</tr>
						<tr>
							<td width="130" class="ct_write">
								소개 
								<img src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle"/>
							</td>
							<td class="ct_write01">
								<table width="100%" border="0" cellspacing="0" cellpadding="0">
									<tr>
										<c:if test="${!empty market}">
											<td width="105">
												${market.marketIntro}
											</td>
										</c:if>
										<c:if test="${empty market}">
											<td width="105">
												<textarea class="ct_input_g textarea" id="marketIntro" name="marketIntro" ></textarea>
											</td>
										</c:if>
									</tr>
								</table>
							</td>
						</tr>
						<tr>
							<td width="130" class="ct_write">
								사업장 주소 
								<img src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle"/>
							</td>
							<td class="ct_write01">
								<table width="100%" border="0" cellspacing="0" cellpadding="0">
									<tr>
										<c:if test="${!empty market}">
											<td width="105">
												${market.marketAddr}
											</td>
										</c:if>
										<c:if test="${empty market}">
											<td width="105">
												<input type="text" id="marketAddr" name="marketAddr" class="ct_input_g input" style="width: 300px; height: 30px" maxLength="10" minLength="6"/>
											</td>
										</c:if>
									</tr>
								</table>
							</td>
						</tr>
						<c:if test="${!empty market }">
							<tr>
								<td width="130" class="ct_write">
									신청 현황
									<img src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle"/>
								</td>
								<td class="ct_write01">
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<c:if test="${market.manaFlag == 'W'}">
												<td width="105">
													승인 대기중
												</td>
											</c:if>
											<c:if test="${market.manaFlag == 'Y'}">
												<td width="105">
													승인완료 [영업가능]
												</td>
											</c:if>
											<c:if test="${market.manaFlag == 'F'}">
												<td width="105">
													영업중지 [영업 불가능]
												</td>
											</c:if>
										</tr>
									</table>
								</td>
							</tr>
							<tr>
								<td height="1" colspan="3" bgcolor="D6D6D6"></td>
							</tr>
						</c:if>
					</table>
					<table class="table" width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top: 10px;">
						<tr>
							<td width="53%"></td>
							<td align="right">
							<table border="0" cellspacing="0" cellpadding="0">
								<c:if test="${!empty market }">
									<tr>
										<td style="float:right;"><a class="button ct_btn01" style="height:40px;">입점취소</a></td>	
										<td style="float:right;"><a class="button ct_btn01" style="height:40px;">이전</a></td>	
									</tr>
								</c:if>
								<c:if test="${empty market }">
									<tr>
										<td style="float:right;"><a class="button ct_btn01" style="height:40px;">입점신청</a></td>	
										<td style="float:right;"><a class="button ct_btn01" style="height:40px;">취소</a></td>	
									</tr>
								</c:if>
							</table>
							</td>
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