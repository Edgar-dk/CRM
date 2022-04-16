<%--
  Created by IntelliJ IDEA.
  User: Edga会飞的小猪
  Date: 2022/4/13
  Time: 19:47
  To change this template use File | Settings | File Templates.
--%>
<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String basePath=request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()+"/";
    /*注意：在jap中不可以像Java后端的那样，把一个常量封装到一个方法中，jsp是展示下页面上的，常量的话，只能写
     * 具体的数字*/
%>
<html>
<head>
    <%--引入基本的开发包--%>
    <script type="text/javascript" src="jquery/jquery-1.11.1-min.js"></script>
        <link rel="stylesheet" type="text/css" href="jquery/bootstrap_3.3.0/css/bootstrap.min.css">
        <script type="text/javascript" src="jquery/bootstrap_3.3.0/js/bootstrap.min.js"></script>
        <link  rel="stylesheet" type="text/css" href="jquery/bs_pagination-master/css/jquery.bs_pagination.min.css">
        <script type="text/javascript" src="jquery/bs_pagination-master/js/jquery.bs_pagination.min.js"></script>
        <script type="text/javascript" src="jquery/bs_pagination-master/localization/en.js"></script>
    <base href="<%=basePath%>">
    <title>分页插件的使用</title>
    <script type="text/javascript">

    </script>
</head>
<body>
<div id="demo_page1"></div>
</body>
</html>
