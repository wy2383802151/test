<%@page import="com.oracle.cars.model.Car"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> <!DOCTYPE html>
<html>
<head>
<meta charset="utf-8"/>
<title>二手车后台管理系统-所有二手列表</title>
<meta name="author" content="DeathGhost" />
<link rel="stylesheet" type="text/css" href="css/style.css">
<!--[if lt IE 9]>
<script src="js/html5.js"></script>
<![endif]-->
<script src="js/jquery.js"></script>
<script src="js/jquery.mCustomScrollbar.concat.min.js"></script>
<script>

	(function($){
		$(window).load(function(){
			
			$("a[rel='load-content']").click(function(e){
				e.preventDefault();
				var url=$(this).attr("href");
				$.get(url,function(data){
					$(".content .mCSB_container").append(data); //load new content inside .mCSB_container
					//scroll-to appended content 
					$(".content").mCustomScrollbar("scrollTo","h2:last");
				});
			});
			
			$(".content").delegate("a[href='top']","click",function(e){
				e.preventDefault();
				$(".content").mCustomScrollbar("scrollTo",$(this).attr("href"));
			});
			
		});
	})(jQuery);
</script>
</head>
<body>
<!--header-->
<header>
 <h1 style="color:white;font-weight: bold;font-size: 0.8cm;text-shadow: 2px 2px 2px red;margin-top: 8px">二手车后台管理系统</h1>
 <ul class="rt_nav" style="position: relative;top: -5px">
  <li><a href="login.html" class="quit_icon">安全退出</a></li>
 </ul>
</header>
<!--aside nav-->
<!--aside nav-->
<aside class="lt_aside_nav content mCustomScrollbar">
 <h2><a href=".">起始页</a></h2>
 <ul>
  <li>
   <dl>
    <dt>二手车管理</dt>
    <!--当前链接则添加class:active-->
    <dd><a href="CarServlet?method=listAll" class="active">二手车列表</a></dd>
    <dd><a href="carAdd.jsp">添加二手车</a></dd>
   </dl>
  </li>
  <li>
   <dl>
    <dt>用户管理</dt>
    <dd><a href="order_list.html">所有用户列表</a></dd>
    <dd><a href="order_detail.html">添加用户</a></dd>
   </dl>
  </li>
  <li>
   <dl>
    <dt>新闻管理</dt>
    <dd><a href="user_list.html">所有新闻列表</a></dd>
    <dd><a href="user_detail.html">添加新闻</a></dd>
   </dl>
  </li>
 </ul>
</aside>

<section class="rt_wrap content mCustomScrollbar">
 <div class="rt_content">
      <div class="page_title">
       <h2 class="fl">商品列表示例</h2>
       <a href="product_detail.html" class="fr top_rt_btn add_icon">添加商品</a>
      </div>
      <section class="mtb">
       <select class="select">
        <option>下拉菜单</option>
        <option>菜单1</option>
       </select>
       <input type="text" class="textbox textbox_225" placeholder="输入产品关键词或产品货号..."/>
       <input type="button" value="查询" class="group_btn"/>
      </section>
      <table class="table">
       <tr bgcolor="#19a97b">
        <th>图片</th>
        <th>品牌</th>
        <th>系列</th>
        <th>公里数</th>
        <th>售价</th>
        <th>颜色</th>
        <th>排量</th>
        <th>操作</th>
       </tr>
       <%  List<Car>  cars=(List<Car>)request.getAttribute("cars");
       		for(Car c:cars){
       %>
	       <tr>
	        <td class="center"><img src="<%=c.getZhaopian() %>"  style="width: 100px;height: 80px;border:1px solid black;"/> </td>
	        <td class="center"><%=c.getPinpaiming() %> </td>
	        <td class="center"><%=c.getXilie() %></td>
	        <td class="center"><%=c.getGonglishu() %></td>
	        <td class="center"><%=c.getShoujia() %></td>
	        <td class="center"><%=c.getYanse() %></td>
	        <td class="center"><%=c.getPailiang() %></td>
	        <td class="center">
	         <a href="CarServlet?method=getCarInfo&carid=<%=c.getCarid() %>" title="编辑" class="link_icon">&#101;</a>
	         <a href="javascript:if(window.confirm('您确认要删除这条数据吗?')){location.href='CarServlet?method=delete&carid=<%=c.getCarid() %>'}" title="删除" class="link_icon">&#100;</a>
	        </td>
	       </tr>
       <%} %>
    
      </table>
      <aside class="paging">
       <a>第一页</a>
       <a>1</a>
       <a>2</a>
       <a>3</a>
       <a>…</a>
       <a>1004</a>
       <a>最后一页</a>
      </aside>
 </div>
</section>
<%  if(request.getAttribute("deleteResult")!=null){
	if(request.getAttribute("deleteResult").toString().equals("true")){
		%>
		<script type="text/javascript">
		alert("删除成功!");
		</script>
		<%
	}else{
		%>
		<script type="text/javascript">
		alert("删除失败!");
		</script>
		<%
	}
} %>
</body>
</html>
