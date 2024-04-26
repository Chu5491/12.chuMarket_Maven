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
<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
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
			$( ".ct_btn01:contains('등록')" ).on("click" , function() 
		 	{
				////////// 등록버튼 클릭 시 //////////
				//Debug..
				//alert(  $( ".ct_btn01:contains('등록')" ) );
		 		//Form 유효성 검증
			 	var name = $("#prodName");
				var detail = $("#prodDetail");
				var manuDate = $("#manuDate");
				var price = $("#price");
				var stock = $("#prodStock");
				
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
				detailForm.attr('action','/product/addProduct').submit();
			}); 
			
			$( ".ct_btn01:contains('취소')" ).on("click" , function() 
			{
				////////// 취소버튼 클릭 시 //////////
				detailForm.each(function()
				{
					this.reset();
				});
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
		});
	</script>
	<!-- Script -->
	
	<body bgcolor="#ffffff" text="#000000">
	
		<!-- Article -->
		<form name="detailForm" method="post" enctype="multipart/form-data">
			<div class="table-container">
				<table class="table" width="100%" height="37" border="0" cellpadding="0" cellspacing="0">
					<tr>
						<td background="/images/ct_ttl_img02.gif" width="100%">
							<b>상품등록</b>
						</td>
					</tr>
				</table>
				<div class="container is-max-desktop" style="align:center;" >
					<table class="table" width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top: 13px;">
						<tr>
							<td height="1" colspan="3" bgcolor="D6D6D6"></td>
						</tr>
						<tr>
							<td width="130" class="ct_write">
								상품명 
								<imgsrc="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle">
							</td>
							<td class="ct_write01">
								<c:if test="${empty prod }">
									<input type="text" name="prodName" id="prodName" class="ct_input_g input" style="width: 130px; height: 30px" maxLength="20">
								</c:if>
								<c:if test="${! empty prod }">
									${prod.prodName }
								</c:if>
							</td>
						</tr>
						<tr>
							<td width="130" class="ct_write">
								상품상세정보 
								<img	src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle"/>
							</td>
							<td class="ct_write01">
								<c:if test="${empty prod }">
									<textarea class="ct_input_g textarea" id="prodDetail" name="prodDetail" ></textarea>
								</c:if>
								<c:if test="${! empty prod }">
									${prod.prodDetail }
								</c:if>
							</td>
						</tr>
						<tr>
							<td width="130" class="ct_write">
								제조일자 
								<img src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle"/>
							</td>
							<td class="ct_write01">
								<c:if test="${empty prod }">
									<input type="text" name="manuDate" id="manuDate" readonly="readonly" class="ct_input_g input" style="width: 130px; height: 30px"	maxLength="10" minLength="6"/>
									&nbsp;
									<img src="/images/ct_icon_date.gif" width="15" height="15" onclick="show_calendar('document.detailForm.manuDate', document.detailForm.manuDate.value)"/>
								</c:if>
								<c:if test="${! empty prod }">
									${prod.manuDate }
								</c:if>
							</td>
						</tr>
						<tr>
							<td width="130" class="ct_write">가격 
								<img src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle"/>
							</td>
							<td class="ct_write01">
								<c:if test="${empty prod }">
									<input type="text" name="price" id="price" class="ct_input_g input" style="width: 130px; height: 30px" maxLength="10">&nbsp;원
								</c:if>
								<c:if test="${! empty prod }">
									${prod.price }
								</c:if>
							</td>
						</tr>
						<tr>
							<td width="130" class="ct_write">상품이미지</td>
							<td class="ct_write01">
								<c:if test="${empty prod }">
								<img id="preview" style="width:350px; height:350px;"style="display:none;"/>
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
								</c:if>
								<c:if test="${! empty prod }">
									${prod.fileName}
								</c:if>
							</td>
						</tr>
						<tr>
							<td width="130" class="ct_write">수량</td>
							<td class="ct_write01">
								<c:if test="${empty prod }">
									<input type="text" name="prodStock" id="prodStock" class="ct_input_g input" style="width: 50px; height: 30px" maxLength="13"
										/> 
									개
								</c:if>
								<c:if test="${! empty prod }">
									${prod.prodStock } 개
								</c:if>
							</td>
						</tr>
						<tr>
							<td height="1" colspan="3" bgcolor="D6D6D6"></td>
						</tr>
					</table>
					<table class="table" width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top: 10px;">
						<tr>
							<td width="53%"></td>
							<td align="right">
							<table border="0" cellspacing="0" cellpadding="0">
								<tr>
									<td><a class="button ct_btn01" style="height:40px">등록</a></td>		
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