<%@page import="com.carrot.beans.MemberVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<style>
	
	.deliver_title{
		margin: 1rem 0 1rem 0;
    	font-size: 1.5rem;
	}
	.deliver_content_first{
		display :flex;
		justify-content : space-between;
		margin-bottom :1rem;
	}
	.deliver_content_first input{
		width: 100%;
		height: 3rem;
		font-size : 1rem;
		padding : 1rem;
		margin-top :1rem;
		margin-bottom : 1rem;
	}
	.deliver_content_addr{
		display:flex;
		margin-top : 1rem;
		margin-bottom :1rem;
	}
	.deliver_content_addr input{
		height: 2.5rem;
    	width: 90%;
	}
	.deliver_content_addr button{
		height: 2.5rem;
		width : 10%;
	}
	.deliver_content_firstblock{
		width :45%;
	}
	.deliver_content_firstblock div{
		width :100%;
	}
	
	.deliver_extra_addr_wrapper{
		width :100%;
	}
	.deliver_extra_addr_wrapper input{
		width: 100%;
		height: 2.5rem;
    	font-size: 1rem;
    	padding: 1rem;
	}
	.addr_option_wrapper{
		padding-top :2rem;
		width:100%;
		margin : 1rem 0 1rem 0;
	}
	.addr_option_wrapper select{
		width: 100%;
		height: 2.5rem;
    	font-size: 1rem;
    	margin-bottom :1rem;
    	
	}
	#hide_input{
		display : none;
		margin-top : 1rem;
		width: 100%;
		height: 2.5rem;
    	font-size: 1rem;
    	padding: 1rem;
	}
	.order_form_second_button{
		font-size : 1.1rem;
		position : relative;
		top : 5.6rem;
		width : 100%;
		height : 3.2rem;
		background : black;
		color : white;
		text-align : center;
		
	}
	
	.order_member_info{
		font-size : 0.8rem;
		display: flex;
		align-items : center;
		justify-content: end;
		height:3rem;
		border-top :1px solid grey;
		border-bottom :1px solid grey;
		margin-top : 1rem;
	}
	.order_member_info div{
		margin-left: 0.5rem;
	}
	.order_member_info2{
		display :none;
		padding-left :1rem;
		padding-top :1rem;
		padding-bottom :1rem;
		margin-top :1rem;
		border-top: 1px solid grey;
   		border-bottom: 1px solid grey;
		
	}
	.order_member_info2 input{
		padding : 0.5rem;
		width : 14rem;
	}
	.order_member_correction_button{
		margin-left : 2rem;
		height :100%;
		width : 5rem;
		font-size : 1rem;
	}
	.order_member_input_wrapper{
		display: flex;
		flex-direction :column;
		row-gap : 0.4rem;
	}
	.order_member_info2 i{
		float : right
	}
	.order_member_info2 div:nth-child(3){
		align-self:center;
		width: 100%;
	}
	
</style>

	<%
		/* MemberVO vo = (MemberVO)session.getAttribute("memberVO"); */
		/* request.setAttribute("memberVO", vo); */
	%>
	<script>
		
	</script>
	<div class="order_form_second_wrapper">
		<div class="order_member_info long">
			<div class="order_member_email">${memberVO.email }</div>
			<div class="order_member_phone">${memberVO.phone_num }</div>
			<div class="order_member_open_button"><i class="fas fa-plus open_info"></i></div>
		</div>
		<div class="order_member_info2 long">
			<div class="order_member_input_wrapper">
				<div><input id="second_member_email" type="text" value="${memberVO.email }"></div>
				<div><input id="second_member_phone" type="text" value="${memberVO.phone_num }"></div>
			</div>
			<div><button class="order_member_correction_button">??????</button></div>
			<div class="order_member_close_button"><i class="fas fa-minus close_info"></i></div>
		</div>
		<div class="deliver_title">
			????????? ??????
		</div>
		<form action="${pageContext.request.contextPath }/orderform" method="post">
			<input type="hidden" name="orderform_type" value="2">
		
			<div class="deliver_content_first">
				<div class="deliver_content_firstblock">
					<span>???????????? ???</span>
					<div >
						<input type="text" placeholder="??????">
					</div>
				</div>
				<div class="deliver_content_firstblock">
					<span>?????????</span>
					<div>
						<input type="text" placeholder="-?????? ??????">
					</div>
				</div>
				
			</div>
			<div class="deliver_content_second">
				<span>????????????</span>
				<div class="deliver_content_addr">
					<input type="text" id="order_address">
					<button onclick="sample4_execDaumPostcode()">??????</button>
				</div>
			</div>
			<div class="deliver_extra_addr_wrapper">
				<input type="text" id="detail_delivery" placeholder="????????? ?????? ??????">
			</div>
			
			<div class="addr_option_wrapper">
				<select name="" id="direct_input_button" onchange='direct_input_event(this.value)'>
					<option value="" selected disabled>??????????????? ???????????????</option>
					<option value="contact">????????? ?????? ??????????????????.</option>
					<option value="door">??? ?????????????????????</option>
					<option  id="" value="direct">????????????</option>
					
				</select>
				<input type="text" id="hide_input" placeholder="??????????????? ???????????? ?????????.">
			</div>
			<div class="long">
				<button class="order_form_second_button" type="submit">?????? ?????? ??????</button>
			</div>

		</form>
	</div>
	<script>
	const direct_input_button = document.getElementById('direct_input_button');
	const hide_input = document.getElementById('hide_input');

	function direct_input_event(value){	
		if(value == 'direct'){
		
			hide_input.style.display = 'block';
		}
		else{
			hide_input.style.display = 'none';
			hide_input.innerHTML ='';
		} 
	}
	function sample4_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                
                var roadAddr = data.roadAddress; // ????????? ?????? ??????
                document.getElementById("order_address").value = roadAddr;

            } 
        }).open();
    }
	// ?????? ?????????,????????? ?????? ???????????????
	/* const origin_wrap = document.querySelector('.order_member_info');
	const second_wrap = document.querySelector('.order_member_info2');
	
	document.querySelector('.open_info').addEventListener('click',() =>{
		origin_wrap.style.display = 'none';
		second_wrap.style.display = 'flex';
	});
	
	document.querySelector('.close_info').addEventListener('click', () =>{
		origin_wrap.style.display = 'flex';
		second_wrap.style.display = 'none';
	}); */
	
	// ?????? ?????? ?????? ????????? ??????
	 function correction(){
		const email = document.getElementById('second_member_email');
		const phone = document.getElementById('second_member_phone');
		const path = '${pageContext.request.contextPath}'+'/orderform';
		const info = {email : email, phone : phone};
		 fetch(path,{
			method :'put',
			body: JSON.stringify(info)
		})
		.then(res){
			 if(res.status==200){
				 
				 
			 }
		 };
		
	} 
	//member_info open,close
	
	document.querySelector('.order_member_open_button').addEventListener('click', ()=>{
			document.querySelector('.order_member_info').style.display = 'none';
			document.querySelector('.order_member_info2').style.display ='flex';
		});
 	document.querySelector('.order_member_close_button').addEventListener('click',()=>{
 		document.querySelector('.order_member_info').style.display = 'flex';
		document.querySelector('.order_member_info2').style.display ='none';	 		
 	})

	</script>
</html>