<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
    /*注意：在jap中不可以像Java后端的那样，把一个常量封装到一个方法中，jsp是展示下页面上的，常量的话，只能写
     * 具体的数字*/
%>
<html>
<head>
    <base href="<%=basePath%>">
    <meta charset="UTF-8">

    <link href="jquery/bootstrap_3.3.0/css/bootstrap.min.css" type="text/css" rel="stylesheet"/>
    <link href="jquery/bootstrap-datetimepicker-master/css/bootstrap-datetimepicker.min.css" type="text/css" rel="stylesheet"/>
    <link  rel="stylesheet" type="text/css" href="jquery/bs_pagination-master/css/jquery.bs_pagination.min.css">

    <script type="text/javascript" src="jquery/jquery-1.11.1-min.js"></script>
    <script type="text/javascript" src="jquery/bootstrap_3.3.0/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="jquery/bootstrap-datetimepicker-master/js/bootstrap-datetimepicker.js"></script>
    <script type="text/javascript" src="jquery/bootstrap-datetimepicker-master/locale/bootstrap-datetimepicker.zh-CN.js"></script>
    <script type="text/javascript" src="jquery/bs_pagination-master/js/jquery.bs_pagination.min.js"></script>
    <script type="text/javascript" src="jquery/bs_pagination-master/localization/en.js"></script>

    <script type="text/javascript">

        $(function () {
            /*1.给这个创建按钮增加功能
            *   点击创建的时候，显示模态窗口*/
            $("#createActivityBtn").click(function () {

                /*先使用选择器获的jQuery对象，然后在转换成dom对象
                * 最后，在使用dom这个对象里面的函数，
                * 清空FORM表单*/
                $("#createActivityFrom").get(0).reset();

                $("#createActivityModal").modal("show");
            });

            /*2.点击保存按钮获取页面上的数据
            *   这个数据分散在页面的个个角落，
            *   怎么去获取这个数据呢，一般而言，数据
            *   都是在文本框中的，文本框又是有id的
            *   可以获取这个id来获取里面的value数据
            *   */
            $("#saveCreateActivityBtn").click(function () {
                var owner = $("#create-marketActivityOwner").val();
                var name = $.trim($("#create-marketActivityName").val());
                var startDate = $("#create-startDate").val();
                var endDate = $("#create-endDate").val();
                var cost = $.trim($("#create-cost").val());
                var description = $.trim($("#create-description").val());


                /*3.虽然说得到了数据，还是需要判断里面的数据
                *   是否发生错误，是否为空*/
                /*看字符里面是否为空，直接双等于号*/
                if (owner == "") {
                    alert("所有者不可以为空")
                    /*上面的条件成立的话，执行到了return的时候
                    * 直接把下面js的代码，停止执行*/
                    return;
                }
                if (name == "") {
                    alert("名称不可以为空")
                    return;
                }
                if (startDate != "" && endDate != "") {
                    //使用字符串的大小代替日期的大小
                    if (endDate < startDate) {
                        alert("结束日期不能比开始日期小");
                        return;
                    }
                }

                /*验证输入的成本的格式*/
                var regExp = /^(([1-9]\d*)|0)$/;
                if (!regExp.test(cost)) {
                    alert("成本只能为非负整数");
                    return;
                }


                /*4.页面上收集完数据之后，在通过ajax的方式
                *   向后台发送数据*/
                $.ajax({
                    url: 'workbench/activity/saveCreateActivity.do',
                    data: {
                        owner: owner,
                        name: name,
                        startDate: startDate,
                        endDate: endDate,
                        cost: cost,
                        description: description
                    },
                    type: 'post',
                    dataType: 'json',

                    /*01.返回数据成功之后，会返回一个成功的状态*/
                    success: function (data) {
                        if (data.code == "1") {
                            /*关闭模态窗口*/
                            $("#createActivityModal").modal("hide");
                            queryActivityByConditionForPage(1,$("#demo_page1").bs_pagination('getOption','rowsPerPage'));
                        } else {
                            alert(data.message);
                            $("#createActivityModal").modal("show");
                        }
                    }
                });
            });


            /*这个地方一个标签可以有多个类名，可以把类的全部选上*/
            $(".myDate").datetimepicker({
                language: 'zh-CN',//选择的语言
                format: 'yyyy-mm-dd',//日期的格式
                minView: 'month',//可以选择的最小试图，就是选择的最小日期
                initialDate: new Date(),//默认下选择日期的时候，选择的当前的时间
                autoclose: true,//设置完日期之后，会自动的关闭
                todayBtn: true,//在最下面默认显示今天
                clearBtn: true,//在下面显示清空按钮
            });

            /*在点击市场活动这个页面的时候，会加载这个函数
            * 执行的是查询页面信息的作用（不是点击查询按钮）*/
            queryActivityByConditionForPage(1,10);

            /*给查询事件，加上一个按钮，点击按钮的时候会查询出该有的数据*/
            $("#queryActivityBtn").click(function () {
                /*一个函数去调用另外一个函数，直接在一个函数中
                * 写上另外一个函数的名字即可
                * 其中参数也可以是一个函数
                * 为什么参数是一个函数，因为在更改了每页显示的条数的
                * 时候，这个页面的数据会刷新，刷新的过程是从新排列数据
                * 排列数据需要执行函数，这个函数，只能执行查询数据的函数
                * 参数也是需要有特别之处的，需要加上当前页面条数限制，getOption就是
                * 这个限制，使用等前更改的数据，为什么一更改可以获取到呢，因为bs_pagination这个
                * 文本库作用页面上，直接获取到了上一次数据的更新，使用即可使用
                * 然后加上限制条件，使用当前的
                * 在走一遍查询（这个查询的数据可能在持久层框架上的缓存中
                * 为了防止多次的查询数据），*/
                queryActivityByConditionForPage(1,$("#demo_page1").bs_pagination('getOption','rowsPerPage'));
            });
        });

        function queryActivityByConditionForPage(pageNo,pageSize) {
            /*按照文本框中的条件查询

            收集参数，显示在页面上,
            * 在收集数据的时候，不需要验证数据格式是否正确
            * 也不需要验证里面是否为空，直接向后台发送请求

            文本框中的数据，都是空的话，表示把这张表的全部数据查出来
            展示在页面上*/
            var name = $("#query-name").val();
            var owner = $("#query-owner").val();
            var startDate = $("#query-startDate").val();
            var endDate = $("#query-endDate").val();

            /*查询第一页的数据，每一页数据显示10条*/
            // var pageNo = 1;
            // var pageSize = 10;

            /*向后台发送请求
            * 大括号是一个Js中的对象*/
            $.ajax({
                url: 'workbench/activity/queryActivityByConditionForPage.do',
                data: {
                    name: name,
                    owner: owner,
                    startDate: startDate,
                    endDate: endDate,
                    pageNo: pageNo,
                    pageSize: pageSize
                },
                type: 'post',
                dataType: 'json',

                /*注意这个data就是返回的retMap这个数据，
                * 可以从里面获取数据库中的数据*/
                success: function (data) {
                    /*给这个文本框设置一个值*/
                    // $("#totalRowsB").text(data.totalRows);

                    /*分析：data过来的数据，每次都放在obj中，然后在下面去拼接字符串
                    * index是在执行一次的时候，这个变量加一，其实在下面也有一个
                    * this，把data中去的数据，放在this中，理论上，和obj的原理一样
                    * 放在哪一个变量都是可以的，this是简单一点的，obj可以处理复杂的数据
                    *
                    * 下面的步骤，先创建一个大的字符串，把表格的内容，放到字符串中，最后
                    * 在把这个大的字符串，放到这个Body中显示数据，双引号前面的\是转义字符，
                    * 表示，双引号和外面的哪一个不是同一个*/
                    var htmlStr = "";
                    $.each(data.activityList, function (index, obj) {
                        htmlStr += "<tr class=\"active\">";
                        htmlStr += "<td><input type=\"checkbox\" value=\"" + obj.id + "\"/></td>";
                        htmlStr += "<td><a style=\"text-decoration: none; cursor: pointer;\" onclick=\"window.location.href='detail.html';\">" + obj.name + "</a></td>";
                        htmlStr += "<td>" + obj.owner + "</td>";
                        htmlStr += "<td>" + obj.startDate + "</td>";
                        htmlStr += "<td>" + obj.endDate + "</td>";
                        htmlStr += "</tr>";
                    });

                    /*把一行数据放到Body中显示*/
                    $("#tBody").html(htmlStr);


                    /*为了防止，获取的参数是一个小数
                    * 增加判断条件，parseInt去除小数点后面的数*/
                    var totalPages=1;
                    if(data.totalRows%pageSize==0){
                        totalPages=data.totalRows/pageSize;
                    }else {
                        totalPages=parseInt(data.totalRows/pageSize)+1;
                    }


                    $("#demo_page1").bs_pagination({
                        currentPage:pageNo,//当前的页号

                        rowsPerPage:pageSize,//每页显示的条数，
                        totalRows:data.totalRows,//总条数
                        totalPages:totalPages,//总页数，必填的，可以自己更改

                        visiblePageLinks: 10,//最多可以显示的卡片数，
                        showGoToPage: true,//默认是否显示可以跳转的页数，默认是true可以不用，也可以使用，不使用可以在页面上没有太多的地方
                        showRowsPerPage: true,//是否显示每页显示的条数，默认是true，可以根据需求更改
                        showRowsInfo: true,//是否显示记录的信息，某人true



                        /*分析：
                        * 结合上面的和下面的一块去分析，上面的是在执行这个页面的时候，直接加载这个页面
                        * 执行上面的一个函数，显示在页面上的形式，就按照上面的参数显示，然后下面的代码也会执行
                        event是切换事件的本身，pageObj是翻页对象，里面记录了所有的翻页信息，同时也可以获取翻页的信息的
                        当用户更改页面上显示的条数，会从页面上获取数据，因为pageObj本身，就是这个bs_pagination对象
                        * 一旦bs_pagination这个对象里面的数据发生了改变，pageObj会立即获取数据，然后传递参数执行
                        * 因为上面一层最先执行的是bs_pagination，
                        ，这个时候，可能会有一个问题，为什么在切换数据的时候，会执行呢，因为这个切换页号的是一个文本框文本框
                        * 一执行，就把自带的id执行，上面的js代码中，有js代码，然后获取执行的数据，传递给下面函数的参数，
                        * 对于pageObj对象而言，是可以获取到这里面的参数的，然后把获取
                        到的数据传递给后台。在从数据库中查询数据，最后显示在页面上当切换了页面时，首先执行下面的一个函数，里面的参数pageObj获取
                        *
                        * 在第一次传递过来参数的时候，这个位置上，会再次执行一次，*/
                        onChangePage:function (event,pageObj){
                            queryActivityByConditionForPage(pageObj.currentPage,pageObj.rowsPerPage);
                        }
                    });
                }
            });
        }

    </script>
</head>
<body>

<!-- 创建市场活动的模态窗口 -->
<div class="modal fade" id="createActivityModal" role="dialog">
    <div class="modal-dialog" role="document" style="width: 85%;">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">
                    <span aria-hidden="true">×</span>
                </button>
                <h4 class="modal-title" id="myModalLabel1">创建市场活动</h4>
            </div>
            <div class="modal-body">

                <form id="createActivityFrom" class="form-horizontal" role="form">

                    <div class="form-group">
                        <label for="create-marketActivityOwner" class="col-sm-2 control-label">所有者<span
                                style="font-size: 15px; color: red;">*</span></label>
                        <div class="col-sm-10" style="width: 300px;">
                            <select class="form-control" id="create-marketActivityOwner">
                                <%--1.分析：users是作用域的名字，表示从这个中取出数据
                                           然后把数据放在var中，里面的一个标签表示展示数据
                                           value是按照这数据的id展示，这个名字
                                           获取的实体类，用在展示在模态窗口上--%>
                                <c:forEach items="${users}" var="u">
                                    <option value="${u.id}">${u.name}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <label for="create-marketActivityName" class="col-sm-2 control-label">名称<span
                                style="font-size: 15px; color: red;">*</span></label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" class="form-control" id="create-marketActivityName">
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="create-startDate" class="col-sm-2 control-label">开始日期</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" class="form-control myDate" id="create-startDate" readonly>
                        </div>
                        <label for="create-endDate" class="col-sm-2 control-label">结束日期</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" class="form-control myDate" id="create-endDate" readonly>
                        </div>
                    </div>
                    <div class="form-group">

                        <label for="create-cost" class="col-sm-2 control-label">成本</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" class="form-control" id="create-cost">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="create-describe" class="col-sm-2 control-label">描述</label>
                        <div class="col-sm-10" style="width: 81%;">
                            <textarea class="form-control" rows="3" id="create-describe"></textarea>
                        </div>
                    </div>

                </form>

            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="saveCreateActivityBtn">保存</button>
            </div>
        </div>
    </div>
</div>

<!-- 修改市场活动的模态窗口 -->
<div class="modal fade" id="editActivityModal" role="dialog">
    <div class="modal-dialog" role="document" style="width: 85%;">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">
                    <span aria-hidden="true">×</span>
                </button>
                <h4 class="modal-title" id="myModalLabel2">修改市场活动</h4>
            </div>
            <div class="modal-body">

                <form class="form-horizontal" role="form">

                    <div class="form-group">
                        <label for="edit-marketActivityOwner" class="col-sm-2 control-label">所有者<span
                                style="font-size: 15px; color: #006aff;">*</span></label>
                        <div class="col-sm-10" style="width: 300px;">
                            <select class="form-control" id="edit-marketActivityOwner">
                                <option>zhangsan</option>
                                <option>lisi</option>
                                <option>wangwu</option>
                            </select>
                        </div>
                        <label for="edit-marketActivityName" class="col-sm-2 control-label">名称<span
                                style="font-size: 15px; color: #5900ff;">*</span></label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" class="form-control" id="edit-marketActivityName" value="发传单">
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="edit-startTime" class="col-sm-2 control-label">开始日期</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" class="form-control" id="edit-startTime" value="2020-10-10">
                        </div>
                        <label for="edit-endTime" class="col-sm-2 control-label">结束日期</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" class="form-control" id="edit-endTime" value="2020-10-20">
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="edit-cost" class="col-sm-2 control-label">成本</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" class="form-control" id="edit-cost" value="5,000">
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="create-description" class="col-sm-2 control-label">描述</label>
                        <div class="col-sm-10" style="width: 81%;">
                            <textarea class="form-control" rows="3" id="create-description"></textarea>
                        </div>
                    </div>

                </form>

            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" data-dismiss="modal">更新</button>
            </div>
        </div>
    </div>
</div>

<!-- 导入市场活动的模态窗口 -->
<div class="modal fade" id="importActivityModal" role="dialog">
    <div class="modal-dialog" role="document" style="width: 85%;">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">
                    <span aria-hidden="true">×</span>
                </button>
                <h4 class="modal-title" id="myModalLabel">导入市场活动</h4>
            </div>
            <div class="modal-body" style="height: 350px;">
                <div style="position: relative;top: 20px; left: 50px;">
                    请选择要上传的文件：<small style="color: gray;">[仅支持.xls]</small>
                </div>
                <div style="position: relative;top: 40px; left: 50px;">
                    <input type="file" id="activityFile">
                </div>
                <div style="position: relative; width: 400px; height: 320px; left: 45% ; top: -40px;">
                    <h3>重要提示</h3>
                    <ul>
                        <li>操作仅针对Excel，仅支持后缀名为XLS的文件。</li>
                        <li>给定文件的第一行将视为字段名。</li>
                        <li>请确认您的文件大小不超过5MB。</li>
                        <li>日期值以文本形式保存，必须符合yyyy-MM-dd格式。</li>
                        <li>日期时间以文本形式保存，必须符合yyyy-MM-dd HH:mm:ss的格式。</li>
                        <li>默认情况下，字符编码是UTF-8 (统一码)，请确保您导入的文件使用的是正确的字符编码方式。</li>
                        <li>建议您在导入真实数据之前用测试文件测试文件导入功能。</li>
                    </ul>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button id="importActivityBtn" type="button" class="btn btn-primary">导入</button>
            </div>
        </div>
    </div>
</div>


<div>
    <div style="position: relative; left: 10px; top: -10px;">
        <div class="page-header">
            <h3>市场活动列表</h3>
        </div>
    </div>
</div>
<div style="position: relative; top: -20px; left: 0px; width: 100%; height: 100%;">
    <div style="width: 100%; position: absolute;top: 5px; left: 10px;">

        <div class="btn-toolbar" role="toolbar" style="height: 80px;">
            <form class="form-inline" role="form" style="position: relative;top: 8%; left: 5px;">

                <div class="form-group">
                    <div class="input-group">
                        <div class="input-group-addon">名称</div>
                        <input class="form-control" type="text" id="query-name">
                    </div>
                </div>

                <div class="form-group">
                    <div class="input-group">
                        <div class="input-group-addon">所有者</div>
                        <input class="form-control" type="text" id="query-owner">
                    </div>
                </div>


                <div class="form-group">
                    <div class="input-group">
                        <div class="input-group-addon">开始日期</div>
                        <input class="form-control" type="text" id="query-startDate"/>
                    </div>
                </div>
                <div class="form-group">
                    <div class="input-group">
                        <div class="input-group-addon">结束日期</div>
                        <input class="form-control" type="text" id="query-endDate">
                    </div>
                </div>

                <button type="button" class="btn btn-default" id="queryActivityBtn">查询</button>

            </form>
        </div>
        <div class="btn-toolbar" role="toolbar"
             style="background-color: #F7F7F7; height: 50px; position: relative;top: 5px;">
            <div class="btn-group" style="position: relative; top: 18%;">
                <button type="button" class="btn btn-primary" id="createActivityBtn"><span
                        class="glyphicon glyphicon-plus"></span> 创建
                </button>
                <button type="button" class="btn btn-default" data-toggle="modal" data-target="#editActivityModal"><span
                        class="glyphicon glyphicon-pencil"></span> 修改
                </button>
                <button type="button" class="btn btn-danger"><span class="glyphicon glyphicon-minus"></span> 删除</button>
            </div>
            <div class="btn-group" style="position: relative; top: 18%;">
                <button type="button" class="btn btn-default" data-toggle="modal" data-target="#importActivityModal">
                    <span class="glyphicon glyphicon-import"></span> 上传列表数据（导入）
                </button>
                <button id="exportActivityAllBtn" type="button" class="btn btn-default"><span
                        class="glyphicon glyphicon-export"></span> 下载列表数据（批量导出）
                </button>
                <button id="exportActivityXzBtn" type="button" class="btn btn-default"><span
                        class="glyphicon glyphicon-export"></span> 下载列表数据（选择导出）
                </button>
            </div>
        </div>
        <div style="position: relative;top: 10px;">
            <table class="table table-hover">
                <thead>
                <tr style="color: #B3B3B3;">
                    <td><input type="checkbox"/></td>
                    <td>名称</td>
                    <td>所有者</td>
                    <td>开始日期</td>
                    <td>结束日期</td>
                </tr>
                </thead>
                <tbody id="tBody">
                <%--<tr class="active">
                    <td><input type="checkbox"/></td>
                    <td><a style="text-decoration: none; cursor: pointer;"
                           onclick="window.location.href='detail.html';">发传单</a></td>
                    <td>zhangsan</td>
                    <td>2020-10-10</td>
                    <td>2020-10-20</td>
                </tr>
                <tr class="active">
                    <td><input type="checkbox"/></td>
                    <td><a style="text-decoration: none; cursor: pointer;"
                           onclick="window.location.href='detail.html';">发传单</a></td>
                    <td>zhangsan</td>
                    <td>2020-10-10</td>
                    <td>2020-10-20</td>
                </tr>--%>
                </tbody>
            </table>
            <div id="demo_page1"></div>
        </div>

       <%-- <div style="height: 50px; position: relative;top: 30px;">
            <div>
                <button type="button" class="btn btn-default" style="cursor: default;">共<b id="totalRowsB">50</b>条记录
                </button>
            </div>
            <div class="btn-group" style="position: relative;top: -34px; left: 110px;">
                <button type="button" class="btn btn-default" style="cursor: default;">显示</button>
                <div class="btn-group">
                    <button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown">
                        10
                        <span class="caret"></span>
                    </button>
                    <ul class="dropdown-menu" role="menu">
                        <li><a href="#">20</a></li>
                        <li><a href="#">30</a></li>
                    </ul>
                </div>
                <button type="button" class="btn btn-default" style="cursor: default;">条/页</button>
            </div>
            <div style="position: relative;top: -88px; left: 285px;">
                <nav>
                    <ul class="pagination">
                        <li class="disabled"><a href="#">首页</a></li>
                        <li class="disabled"><a href="#">上一页</a></li>
                        <li class="active"><a href="#">1</a></li>
                        <li><a href="#">2</a></li>
                        <li><a href="#">3</a></li>
                        <li><a href="#">4</a></li>
                        <li><a href="#">5</a></li>
                        <li><a href="#">下一页</a></li>
                        <li class="disabled"><a href="#">末页</a></li>
                    </ul>
                </nav>
            </div>
        </div>--%>

    </div>

</div>
</body>
</html>