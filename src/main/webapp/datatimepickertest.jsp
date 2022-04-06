<%--
  Created by IntelliJ IDEA.
  User: Edga会飞的小猪
  Date: 2022/4/6
  Time: 13:41
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
    <base href="<%=basePath%>">

    <%--1.引入jQuery的包
        代码的执行是按照顺序的，所以在引入包的时候，也应该按照一定的顺序来进行--%>
    <script type="text/javascript" src="jquery/jquery-1.11.1-min.js"></script>

    <%--2.引入BooTstrap框架--%>
    <link rel="stylesheet" type="text/css" href="jquery/bootstrap_3.3.0/css/bootstrap.min.css"></link>
    <script type="text/javascript" src="jquery/bootstrap_3.3.0/js/bootstrap.min.js"></script>


    <%--3.引入插件日历--%>
    <link rel="stylesheet" type="text/css" href="jquery/bootstrap-datetimepicker-master/css/bootstrap-datetimepicker.min.css">
    <script type="text/javascript" src="jquery/bootstrap-datetimepicker-master/js/bootstrap-datetimepicker.js"></script>
    <script type="text/javascript" src="jquery/bootstrap-datetimepicker-master/locale/bootstrap-datetimepicker.zh-CN.js"></script>

    <title>演示日历插件</title>



    <%--4.执行JS代码
          这个执行的时候，是按照一定的顺序进行的，因此，可以把JS代码写在
          下面，但是为了以后的维护，防止JS代码和CSS代码的混淆，所以JS代码写在head中
          下里面写一个Jquery的入口函数，执行的时候，在最后执行Jquery函数--%>
    <script type="text/javascript" >
        $(function (){
            $("#myDate").datetimepicker({
                language:'zh-CN',//选择的语言
                format:'yyyy-mm-dd',//日期的格式
                minView:'month',//可以选择的最小试图，就是选择的最小日期
                initialDate:new Date(),//默认下选择日期的时候，选择的当前的时间
                autoclose:true,//设置完日期之后，会自动的关闭
                todayBtn:true,//在最下面默认显示今天
                clearBtn:true,//在下面显示清空按钮
            });
        });
    </script>
</head>
<body>


<%--最后面的一个参数，目的是只让用户读，不可以更改数据--%>
<input type="text" id="myDate" readonly>
</body>
</html>
