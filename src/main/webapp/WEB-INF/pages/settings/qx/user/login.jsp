<!DOCTYPE html><%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
String basePath=request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()+"/";
/*注意：在jap中不可以像Java后端的那样，把一个常量封装到一个方法中，jsp是展示下页面上的，常量的话，只能写
* 具体的数字*/
%>
<html>
<head>
	<base href="<%=basePath%>">
<meta charset="UTF-8">
<link href="jquery/bootstrap_3.3.0/css/bootstrap.min.css" type="text/css" rel="stylesheet" />
<script type="text/javascript" src="jquery/jquery-1.11.1-min.js"></script>
<script type="text/javascript" src="jquery/bootstrap_3.3.0/js/bootstrap.min.js"></script>
	<%--1.选择添加事件
	      这个事件的执行是一个按钮事件，想要去执行的话，需要具体的
	      步骤，哪点击这个按钮要干什么，当然是获取页面上的数据，写的是JS数据
	      所以在上面一个JS标签里面，这个是最后执行的--%>
	<script type="text/javascript">
		/*2.解释一下，为什么是一个函数
		*   因为这事件想要执行的话，需要在一个函数中，写上一个大的函数
		*   所有的子函数事件在里面执行即可，怎么获取这个子函数，就需要
		*   根据子标签的名字（id）的形式获取，获取之后要干什么，这个干什么
		*   的瞬间就是点击按钮，之后执行的有了点击按钮，才有click
		*   $是接收里面的参数*/
		$(function (){

			/*widow把这个窗口转成jQuery对象，keydown是这个窗口上的键盘
			* e相当于键盘，把这个键盘传进来，在里面做一个筛选，筛选的是13
			* 的这个案件，点击这个13的案件，就执行下面的函数*/
			$(window).keydown(function (e){
				if (e.keyCode==13){
					$("#loginBtn").click();
				}
			});
			$("#loginBtn").click(function (){
				/*3.收集数据
				    根据这个id来获取里面的数据
				*   最外面的作用，是去掉里面的空格，前面的是
				*   用一个变量来接收*/
				var loginAct=$.trim($("#loginAct").val());
				var loginPwd=$.trim($("#loginPwd").val());
				var isRemPwd=$("#isRemPwd").prop("checked");
				/*4.表单验证*/
				if (loginAct==""){
					alert("账户不能为空");
					/*01.空的话，结束函数执行，下面的都不执行*/
					return;
				}if(loginPwd==""){
					alert("密码不可以为空");
					return;
				}
				/*5.发送请求*/
				$.ajax({
					url:'settings/qx/user/login.do',
					data:{
						loginAct:loginAct,
						loginPwd:loginPwd,
						isRemPwd:isRemPwd,
					},
					type:'post',
					dataType:'json',
					/*6.转发页面
					*   如果说页面发送的数据和数据库中的数据
					*   匹配正确的话，就把跳转，那么怎么知道
					*   这个匹配正确的状态，把页面的code拿过来
					*   这个code就是成功与否的标志，1成功，0失败
					*   这个是登陆页面的一个responsebody起的作用
					*   把这个对象的状态放回到这里*/
					success:function (data){
						if(data.code=="1"){
							/*7.window是当前的窗口，location是浏览器的地址栏，href是地址信息
							*   后面的是具体的内容*/
							window.location.href="workbench/index.do";
						}else {
							/*8.不成功的话，显示错误的信息*/
							$("#msg").text(data.message);
						}
					},
					/*9.在ajax执行之前去执行这个，true的话，才去执行ajax，false的话不执行
					*   相当于一个短信验证的作用*/
					beforeSend:function (){
						$("#msg").text("正在验证中......");
					}
				});
			});
		});
	</script>
</head>
<body>
	<div style="position: absolute; top: 0px; left: 0px; width: 60%;">
		<img src="image/IMG_7114.JPG" style="width: 100%; height: 90%; position: relative; top: 50px;">
	</div>
	<div id="top" style="height: 50px; background-color: #3C3C3C; width: 100%;">
		<div style="position: absolute; top: 5px; left: 0px; font-size: 30px; font-weight: 400; color: white; font-family: 'times new roman'">CRM &nbsp;<span style="font-size: 12px;">&copy;2019&nbsp;动力节点</span></div>
	</div>
	
	<div style="position: absolute; top: 120px; right: 100px;width:450px;height:400px;border:1px solid #D5D5D5">
		<div style="position: absolute; top: 0px; right: 60px;">
			<div class="page-header">
				<h1>登录</h1>
			</div>
			<form action="workbench/index.html" class="form-horizontal" role="form">
				<div class="form-group form-group-lg">
					<div style="width: 350px;">
						<input id="loginAct" class="form-control" type="text" placeholder="用户名">
					</div>
					<div style="width: 350px; position: relative;top: 20px;">
						<input id="loginPwd" class="form-control" type="password" placeholder="密码">
					</div>
					<div class="checkbox"  style="position: relative;top: 30px; left: 10px;">
						<label>
							<input id="isRemPwd" type="checkbox"> 十天内免登录
						</label>
						&nbsp;&nbsp;
						<span id="msg"></span>
					</div>
					<button type="button" id="loginBtn" class="btn btn-primary btn-lg btn-block"  style="width: 350px; position: relative;top: 45px;">登录</button>
				</div>
			</form>
		</div>
	</div>
</body>
</html>