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
<%@ page contentType="text/html; charset=euc-kr" %>
<html>
	<!-- Header -->
	<header>
		<jsp:include page="/layout/header.jsp"></jsp:include>
	</header>
	<!-- Header -->
	
	<!-- Script -->
	<script type="text/javascript">
		//==>"����"  Event ����
	
		var duplResult = 'F';
		
		$(function() 
		{
			/* ########################## Style ########################## */	
			$(".ct_btn01").css('cursor', 'pointer');
			/* ########################## Style ########################## */
				
			
			/* ########################## User ########################## */	
			$( ".ct_btn01:contains('����')" ).on("click" , function() 
			{
				//Debug..
				//alert(  $( "td.ct_btn01:contains('����')" ).html() );
				fncAddUser();
			});
			
			$( ".ct_btn01:contains('���')" ).on("click" , function() 
			{
				$("form")[0].reset();
				checkDupl($("#userId").val());
			});
			
			$("input[name='email']").on("change" , function() 
			{
				 var email=$("input[name='email']").val();
			    
				 if(email != "" && (email.indexOf('@') < 1 || email.indexOf('.') == -1) )
				 {
			    	alert("�̸��� ������ �ƴմϴ�.");
			     }
			});
			
			$( "#userId" ).on("keyup" , function() 
			{
				var id = $(this).val();
				$(this).val(id.replace(/[^a-z0-9]/gi,''));
				
				checkDupl($(this).val());
			});
			/* ########################## User ########################## */	
		});	
		
		/* ########################## function ########################## */	
		function checkDupl(checkId)
		{
			var id = checkId;
			
			$.ajax
			({
				url : "/user/json/checkDuplication",
				method : "get" ,
				dataType : "json",
				headers : 
				{
					"Accept" : "application/json",
					"Content-Type" : "application/json"
				},
				data : 
				{
					userId : id,
				},
				success : function(JSONData , status) 
				{					
					if( JSONData.result == 'true')
					{
						if(id == '')
						{
							$("#duplResult").text("");
						}else
						{
							$("#duplResult").text("��밡���մϴ�!");
							$("#duplResult").css('color','green');
							duplResult = 'Y';
						}
						
					}else
					{
						$("#duplResult").text("����� �� �����ϴ�!");
						$("#duplResult").css('color','red');
						duplResult = 'F';
					}
				}
			}); 
		}
		
		function fncAddUser() 
		{
			var id=$("input[name='userId']").val();
			var pw=$("input[name='password']").val();
			var pw_confirm=$("input[name='password2']").val();
			var name=$("input[name='userName']").val();
			
			
			if(id == null || id.length <1)
			{
				alert("���̵�� �ݵ�� �Է��ϼž� �մϴ�.");
				return;
			}
			
			if(duplResult != 'Y')
			{
				alert("�ߺ��� ���̵��Դϴ�! �ٸ� ���̵� ������ּ���.")
				$("input[name='userId']").focus();
				return
			}
			if(pw == null || pw.length <1)
			{
				alert("�н������  �ݵ�� �Է��ϼž� �մϴ�.");
				return;
			}
			if(pw_confirm == null || pw_confirm.length <1)
			{
				alert("�н����� Ȯ����  �ݵ�� �Է��ϼž� �մϴ�.");
				return;
			}
			if(name == null || name.length <1)
			{
				alert("�̸���  �ݵ�� �Է��ϼž� �մϴ�.");
				return;
			}
			
			if( pw != pw_confirm ) 
			{				
				alert("��й�ȣ Ȯ���� ��ġ���� �ʽ��ϴ�.");
				$("input:text[name='password2']").focus();
				return;
			}
				
			var value = "";	
			if( $("input:text[name='phone2']").val() != ""  &&  $("input:text[name='phone3']").val() != "") 
			{
				var value = $("option:selected").val() + "-" 
									+ $("input[name='phone2']").val() + "-" 
									+ $("input[name='phone3']").val();
			}
			//Debug..
			//alert("phone : "+value)
			$("input:hidden[name='phone']").val( value );
			
			$("form").attr("method" , "POST").attr("action" , "/user/addUser").submit();
		}
	
		function checkSsn() 
	    {
			var ssn1, ssn2; 
			var nByear, nTyear; 
			var today; 
	
			ssn = document.detailForm.ssn.value;
			// ��ȿ�� �ֹι�ȣ ������ ��츸 ���� ��� ����, PortalJuminCheck �Լ��� CommonScript.js �� ���� �ֹι�ȣ üũ �Լ��� 
			if(!PortalJuminCheck(ssn)) 
			{
				alert("�߸��� �ֹι�ȣ�Դϴ�.");
				return false;
			}
		}

		function PortalJuminCheck(fieldValue)
		{
		    var pattern = /^([0-9]{6})-?([0-9]{7})$/; 
			var num = fieldValue;
		    if (!pattern.test(num)) return false; 
		    num = RegExp.$1 + RegExp.$2;
	
			var sum = 0;
			var last = num.charCodeAt(12) - 0x30;
			var bases = "234567892345";
			for (var i=0; i<12; i++) 
			{
				if (isNaN(num.substring(i,i+1))) return false;
				sum += (num.charCodeAt(i) - 0x30) * (bases.charCodeAt(i) - 0x30);
			}
			var mod = sum % 11;
			return ((11 - mod) % 10 == last) ? true : false;
		}
		/* ########################## function ########################## */
	
	</script>
	<!-- Script -->
	<body bgcolor="#ffffff" text="#000000">
	
	<!-- Article -->
	<form name="detailForm">
		<table class="table" width="100%" height="37" border="0" cellpadding="0"	cellspacing="0">
			<tr>
				<td background="/images/ct_ttl_img02.gif" width="100%" style="padding:7 0 0 10px; margin:0 0 10 0px;">
					<b>ȸ������</b>
				</td>
			</tr>
		</table>
		
		<div class="container is-max-desktop" style="align:center;" >
			<table class="table"width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:13px;">
				
				<tr>
					<td height="1" colspan="3" bgcolor="D6D6D6"></td>
				</tr>
				
				<tr>
					<td width="130" class="ct_write">
						���̵� <img src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle"/>
					</td>
					<td class="ct_write01">
						<input type="text" name="userId" id="userId" style="width:100px; height:30px" class="ct_input_g input"  maxLength="20" >
						&nbsp;&nbsp;&nbsp;
						<b id="duplResult"></b>
					</td>
				</tr>
				<tr>
					<td width="130" class="ct_write">
						��й�ȣ <img src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle"/>
					</td>
					<td class="ct_write01">
						<input type="password" name="password" class="ct_input_g input" 
							style="width:100px; height:30px"  maxLength="10" minLength="6"  />
					</td>
				</tr>
				<tr>
					<td width="135" class="ct_write">
						��й�ȣ Ȯ�� <img src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle"/>
					</td>
					<td class="ct_write01">
						<input type="password" name="password2" class="ct_input_g input" 
							style="width:100px; height:30px"  maxLength="10" minLength="6"  />
					</td>
				</tr>
				<tr>
					<td width="130" class="ct_write">
						�̸� <img src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle"/>
					</td>
					<td class="ct_write01">
						<input type="text" name="userName" class="ct_input_g input" 
							style="width:100px; height:30px"  maxLength="50" />
					</td>
				</tr>
				<tr>
					<td width="130" class="ct_write">�ֹι�ȣ</td>
					<td class="ct_write01">
						<input type="text" name="ssn" class="ct_input_g input" style="width:100px; height:30px" 
							onChange="javascript:checkSsn();"  maxLength="13" />
						-����, 13�ڸ� �Է�
					</td>
				</tr>
				<tr>
					<td width="130" class="ct_write">�ּ�</td>
					<td class="ct_write01">
						<input type="text" name="addr" class="ct_input_g input" style="width:370px; height:30px"  maxLength="100"/>
					</td>
				</tr>
				<tr>
					<td width="130" class="ct_write">�޴���ȭ��ȣ</td>
					<td class="ct_write01">
						<div class="select is-small">
							<select name="phone1" class="ct_input_g"  
											onChange="document.detailForm.phone2.focus();">
								<option value="010" ${ ! empty user.phone1 && user.phone1 == "010" ? "selected" : ""  } >010</option>
								<option value="011" ${ ! empty user.phone1 && user.phone1 == "011" ? "selected" : ""  } >011</option>
								<option value="016" ${ ! empty user.phone1 && user.phone1 == "016" ? "selected" : ""  } >016</option>
								<option value="018" ${ ! empty user.phone1 && user.phone1 == "018" ? "selected" : ""  } >018</option>
								<option value="019" ${ ! empty user.phone1 && user.phone1 == "019" ? "selected" : ""  } >019</option>
							</select>
						</div>
						-
						<input 	type="text" name="phone2" class="ct_input_g input" 
										style="width:100px; height:30px"  maxLength="9" />
						- 
						<input 	type="text" name="phone3" class="ct_input_g input" 
										style="width:100px; height:30px"  maxLength="9" />
						<input type="hidden" name="phone" class="ct_input_g input"  />
					</td>
				</tr>
				<tr>
					<td width="130" class="ct_write">�̸��� </td>
					<td class="ct_write01">
			 			<input 	type="text" name="email" class="ct_input_g input" style="width:100px; height:30px" />										
					</td>
				</tr>
				<tr>
					<td height="1" colspan="3" bgcolor="D6D6D6"></td>
				</tr>
			</table>
		
			<table class="table"  width="100%" border="0" cellspacing="0" cellpadding="0"	style="margin-top:10px;">
				<tr>
					<td width="53%"></td>
					<td align="right">
						<table border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td><a class="button ct_btn01" style="height:40px">����</a></td>
								<td><a class="button ct_btn01" style="height:40px">���</a></td>				
							</tr>
						</table>
					</td>
				</tr>
			</table>
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
