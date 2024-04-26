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
			
			
			/* ########################## Product ########################## */
			$( ".ct_btn01:contains('수정')" ).on("click" , function() 
		 	{
				////////// 등록버튼 클릭 시 //////////
		 		//Form 유효성 검증
			 	var name   	 = $("#prodName");
				var detail	 = $("#prodDetail");
				var manuDate = $("#manuDate");
				var price 	 = $("#price");
				var stock	 = $("#prodStock");
				
				if(name.val() == null || name.val().length<1)
				{
					alert("상품명은 반드시 입력하여야 합니다.");
					name.focus();
					return;
				}
				if(detail.val() == null || detail.val().length<1)
				{
					alert("상품상세정보는 반드시 입력하여야 합니다.");
					detail.focus();
					return;
				}
				if(manuDate.val() == null || manuDate.val().length<1)
				{
					alert("제조일자는 반드시 입력하셔야 합니다.");
					manuDate.focus();
					return;
				}
				if(price.val() == null || price.val().length<1)
				{
					alert("가격은 반드시 입력하셔야 합니다.");
					price.focus();
					return;
				}
				if(stock.val() == null || stock.val() < 1)
				{
					alert("수량은 반드시 1개 이상 입력하셔야 합니다.");
					stock.focus();
					return;
				}
				detailForm.attr('action','/product/updateProduct').submit();
			}); 
			
			$( ".ct_btn01:contains('취소')" ).on("click" , function() 
			{
				////////// 취소버튼 클릭 시 //////////
				history.go(-1);
			});
			
			$( "#prodStock" ).keyup(function() 
			{
				////////// 수량 입력 시 //////////
				var value = $(this).val();
				if(value > 100)
				{
					alert('최대 100개 까지 등록할 수 있습니다!!');	
					$("#prodStock").val(100);
				}
			});
			/* ########################## Product ########################## */
			
			/* ########################## Market ########################## */
			$( ".ct_btn01:contains('구매자 정보')" ).on("click" , function() 
			{
				window.open("/purchase/listSale?prodNo="+$(this).attr('id'),"popWin", "left=300,top=200,width=900,height=500,marginwidth=0,marginheight=0,scrollbars=no,scrolling=no,menubar=no,resizable=no");	
			});
			/* ########################## Market ########################## */
		});
		
	</script>
	<!-- Script -->
	
	<body bgcolor="#ffffff" text="#000000">
	
		<!-- Article -->
		<form name="detailForm" method="post" enctype="multipart/form-data">
		<input type="hidden" name="prodNo" value="${prod.prodNo}"/>
		<input type="hidden" name="regDate" value="${prod.regDate}"/>
			<div class="table-container">
				<table class="table" width="100%" height="37" border="0" cellpadding="0" cellspacing="0">
					<tr>
						<td background="/images/ct_ttl_img02.gif" width="100%">
							<b>상품수정</b>
						</td>
					</tr>
				</table>
			
				<div class="container is-max-desktop" style="align:center;" >
					<table class="table" width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top: 13px;">
						<tr>
							<td width="130" class="ct_write">
								상품명 
								<img src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle"/>
							</td>
							<td class="ct_write01">
								<input type="text" id="prodName" name="prodName" class="ct_input_g input" style="width: 130px; height: 30px" maxLength="20" value="${prod.prodName}">
							</td>
						</tr>
						<tr>
							<td width="130" class="ct_write">
								상품상세정보 
								<img	src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle"/>
							</td>
							<td class="ct_write01">
								<textarea class="ct_input_g textarea" id="prodDetail" name="prodDetail" >${prod.prodDetail}</textarea>
							</td>
						</tr>
						<tr>
							<td width="130" class="ct_write">
								제조일자 
								<img src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle"/>
							</td>
							<td class="ct_write01">
								<input type="text" readonly="readonly" id="manuDate" name="manuDate" value="${prod.manuDate}" 	
									class="ct_input_g input" style="width: 130px; height: 30px" maxLength="10" minLength="6">
											&nbsp;
								<img src="/images/ct_icon_date.gif" width="15" height="15" 
									onclick="show_calendar('document.detailForm.manuDate', document.detailForm.manuDate.value)" />
							</td>
						</tr>
						<tr>
							<td width="130" class="ct_write">
								가격 
								<img src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle"/>
							</td>
							<td class="ct_write01">
								<input type="text" id="price" name="price" value="${prod.price}"
									class="ct_input_g input" style="width: 130px; height: 30px" maxLength="50"/>&nbsp;원
							</td>
						</tr>
						<tr>
							<td width="130" class="ct_write">상품이미지</td>
							<td class="ct_write01">
								<img id="preview" style="width:350px; height:350px;" src ="/images/uploadFiles/${upload.logiName}"/>
								<div class="file is-small">
									<label class="file-label">
										<input type="file" name="file" id="file" class="ct_input_g file-input" onchange="javascript:previewImg(this);"/>
										<span class="file-cta">
											<span class="file-icon">
												<i class="fas fa-upload"></i>
											</span>
											<span class="file-label"> 파일첨부 </span>
										</span>
									</label>
								</div>
							</td>
						</tr>
						<tr>
							<td width="130" class="ct_write">수량</td>
							<td class="ct_write01">
								<input type="text" id="prodStock" name="prodStock" class="ct_input_g input" style="width: 50px; height: 30px" maxLength="13"
										value="${prod.prodStock}" onkeyup="javascript:checkStock(this.value);"/> 
									개
							</td>
						</tr>
						<tr>
							<td height="1" colspan="3" bgcolor="D6D6D6"></td>
						</tr>
					</table>
			
					<table class="table" width="100%" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td width="53%"></td>
							<td align="right">
								<table border="0" cellspacing="0" cellpadding="0">
									<tr>
										<td><a class="button ct_btn01" style="height:40px" id="${prod.prodNo}">구매자 정보</a></td>
										<td><a class="button ct_btn01" style="height:40px">수정</a></td>		
										<td><a class="button ct_btn01" style="height:40px">취소</a></td>	
									</tr>
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