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
			$( ".ct_btn01:contains('���')" ).on("click" , function() 
		 	{
				////////// ��Ϲ�ư Ŭ�� �� //////////
				//Debug..
				//alert(  $( ".ct_btn01:contains('���')" ) );
		 		//Form ��ȿ�� ����
			 	var name = $("#prodName");
				var detail = $("#prodDetail");
				var manuDate = $("#manuDate");
				var price = $("#price");
				var stock = $("#prodStock");
				
				if(name.val() == null || name.val().length<1)
				{
					alert("��ǰ���� �ݵ�� �Է��Ͽ��� �մϴ�.");
					name.focus();
					return;
				}
				if(detail.val() == null || detail.val().length<1)
				{
					alert("��ǰ�������� �ݵ�� �Է��Ͽ��� �մϴ�.");
					detail.focus();
					return;
				}
				if(manuDate.val() == null || manuDate.val().length<1)
				{
					alert("�������ڴ� �ݵ�� �Է��ϼž� �մϴ�.");
					manuDate.focus();
					return;
				}
				if(price.val() == null || price.val().length<1)
				{
					alert("������ �ݵ�� �Է��ϼž� �մϴ�.");
					price.focus();
					return;
				}
				if(stock.val() == null || stock.val() < 1)
				{
					alert("������ �ݵ�� 1�� �̻� �Է��ϼž� �մϴ�.");
					stock.focus();
					return;
				}
				detailForm.attr('action','/product/addProduct').submit();
			}); 
			
			$( ".ct_btn01:contains('���')" ).on("click" , function() 
			{
				////////// ��ҹ�ư Ŭ�� �� //////////
				detailForm.each(function()
				{
					this.reset();
				});
			});
			
			$( "#prodStock" ).keyup(function() 
			{
				////////// ���� �Է� �� //////////
				var value = $(this).val();
				if(value > 100)
				{
					alert('�ִ� 100�� ���� ����� �� �ֽ��ϴ�!!');	
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
							<b>��ǰ���</b>
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
								��ǰ�� 
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
								��ǰ������ 
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
								�������� 
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
							<td width="130" class="ct_write">���� 
								<img src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle"/>
							</td>
							<td class="ct_write01">
								<c:if test="${empty prod }">
									<input type="text" name="price" id="price" class="ct_input_g input" style="width: 130px; height: 30px" maxLength="10">&nbsp;��
								</c:if>
								<c:if test="${! empty prod }">
									${prod.price }
								</c:if>
							</td>
						</tr>
						<tr>
							<td width="130" class="ct_write">��ǰ�̹���</td>
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
											<span class="file-label"> ����÷�� </span>
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
							<td width="130" class="ct_write">����</td>
							<td class="ct_write01">
								<c:if test="${empty prod }">
									<input type="text" name="prodStock" id="prodStock" class="ct_input_g input" style="width: 50px; height: 30px" maxLength="13"
										/> 
									��
								</c:if>
								<c:if test="${! empty prod }">
									${prod.prodStock } ��
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
									<td><a class="button ct_btn01" style="height:40px">���</a></td>		
									<td><a class="button ct_btn01" style="height:40px">���</a></td>	
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