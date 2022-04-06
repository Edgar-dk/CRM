<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
<meta charset="UTF-8">
</head>
<body>
	<script type="text/javascript">
		/*1.通过一个辗转地址来跳转到一个Controller
		*   为什么呢，因为一个页面想到另外的页面，不可以直接访问的，
		*   因为这些子页面都在WEB-INF下面，想要访问的话，需要通过Controller辗转之后在去访问*/
		document.location.href = "settings/qx/user/toLogin.do";
	</script>
<h1>你好，这是一个首页</h1>
</body>
</html>