<%@page import="com.oracle.cars.model.Car"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> <!DOCTYPE html>
<html>
<head>
<meta charset="utf-8"/>
<title>二手车后台管理系统-修改二手车</title>
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
       <h2 class="fl">二手车修改</h2>
       <a class="fr top_rt_btn">返回产品列表</a>
      </div>
     <section>
     <form method="post"  action="CarServlet?method=update"  enctype="multipart/form-data">
     <input type="hidden"  name="carid"    value="<%=((Car)request.getAttribute("car")).getCarid() %>"  />
      <ul class="ulColumn2">
       <li>
        <span class="item_name" style="width:120px;">图片：</span>
        <label class="uploadImg">
         <input type="file"  name="zhaopian"  />
         <span>上傳图片</span>
        </label>
        <img src="<%=((Car)request.getAttribute("car")).getZhaopian()  %>" style="width: 80px;height: 80px;border:1px solid black;position: relative;top: -20px" />
       </li>
       <li>
        <span class="item_name" style="width:120px;">品牌：</span>
        <input type="text"  name="pinpaiming"  value="<%=((Car)request.getAttribute("car")).getPinpaiming() %>" class="textbox textbox_295" placeholder="品牌名"/>
       </li>
       <li>
        <span class="item_name" style="width:120px;">系列：</span>
        <input type="text" name="xilie"   value="<%=((Car)request.getAttribute("car")).getXilie() %>" class="textbox textbox_295" placeholder="系列"/>
       </li>
       <li>
        <span class="item_name" style="width:120px;">公里：</span>
        <input type="text"  name="gonglishu"   value="<%=((Car)request.getAttribute("car")).getGonglishu() %>"  class="textbox textbox_295" placeholder="公里数"/>
       </li>
       <li>
        <span class="item_name" style="width:120px;">售价：</span>
        <input type="text"  name="shoujia"   value="<%=((Car)request.getAttribute("car")).getShoujia() %>"  class="textbox textbox_295" placeholder="售价"/>
       </li>
       <li>
        <span class="item_name" style="width:120px;">颜色：</span>
        <input type="text" name="yanse"   value="<%=((Car)request.getAttribute("car")).getYanse() %>"  class="textbox textbox_295" placeholder="颜色"/>
       </li>
       <li>
        <span class="item_name" style="width:120px;">排量：</span>
        <input type="text"  name="pailiang"    value="<%=((Car)request.getAttribute("car")).getPailiang() %>"  class="textbox textbox_295" placeholder="排量"/>
       </li>
      
       <li>
        <span class="item_name" style="width:120px;"></span>
        <input type="submit" class="link_btn" value="提交修改"/>
       </li>
      </ul>
      </form>
     </section>
 </div>
</section>
<script src="js/ueditor.config.js"></script>
<script src="js/ueditor.all.min.js"> </script>
<script type="text/javascript">

    //实例化编辑器
    //建议使用工厂方法getEditor创建和引用编辑器实例，如果在某个闭包下引用该编辑器，直接调用UE.getEditor('editor')就能拿到相关的实例
    var ue = UE.getEditor('editor');


    function isFocus(e){
        alert(UE.getEditor('editor').isFocus());
        UE.dom.domUtils.preventDefault(e)
    }
    function setblur(e){
        UE.getEditor('editor').blur();
        UE.dom.domUtils.preventDefault(e)
    }
    function insertHtml() {
        var value = prompt('插入html代码', '');
        UE.getEditor('editor').execCommand('insertHtml', value)
    }
    function createEditor() {
        enableBtn();
        UE.getEditor('editor');
    }
    function getAllHtml() {
        alert(UE.getEditor('editor').getAllHtml())
    }
    function getContent() {
        var arr = [];
        arr.push("使用editor.getContent()方法可以获得编辑器的内容");
        arr.push("内容为：");
        arr.push(UE.getEditor('editor').getContent());
        alert(arr.join("\n"));
    }
    function getPlainTxt() {
        var arr = [];
        arr.push("使用editor.getPlainTxt()方法可以获得编辑器的带格式的纯文本内容");
        arr.push("内容为：");
        arr.push(UE.getEditor('editor').getPlainTxt());
        alert(arr.join('\n'))
    }
    function setContent(isAppendTo) {
        var arr = [];
        arr.push("使用editor.setContent('欢迎使用ueditor')方法可以设置编辑器的内容");
        UE.getEditor('editor').setContent('欢迎使用ueditor', isAppendTo);
        alert(arr.join("\n"));
    }
    function setDisabled() {
        UE.getEditor('editor').setDisabled('fullscreen');
        disableBtn("enable");
    }

    function setEnabled() {
        UE.getEditor('editor').setEnabled();
        enableBtn();
    }

    function getText() {
        //当你点击按钮时编辑区域已经失去了焦点，如果直接用getText将不会得到内容，所以要在选回来，然后取得内容
        var range = UE.getEditor('editor').selection.getRange();
        range.select();
        var txt = UE.getEditor('editor').selection.getText();
        alert(txt)
    }

    function getContentTxt() {
        var arr = [];
        arr.push("使用editor.getContentTxt()方法可以获得编辑器的纯文本内容");
        arr.push("编辑器的纯文本内容为：");
        arr.push(UE.getEditor('editor').getContentTxt());
        alert(arr.join("\n"));
    }
    function hasContent() {
        var arr = [];
        arr.push("使用editor.hasContents()方法判断编辑器里是否有内容");
        arr.push("判断结果为：");
        arr.push(UE.getEditor('editor').hasContents());
        alert(arr.join("\n"));
    }
    function setFocus() {
        UE.getEditor('editor').focus();
    }
    function deleteEditor() {
        disableBtn();
        UE.getEditor('editor').destroy();
    }
    function disableBtn(str) {
        var div = document.getElementById('btns');
        var btns = UE.dom.domUtils.getElementsByTagName(div, "button");
        for (var i = 0, btn; btn = btns[i++];) {
            if (btn.id == str) {
                UE.dom.domUtils.removeAttributes(btn, ["disabled"]);
            } else {
                btn.setAttribute("disabled", "true");
            }
        }
    }
    function enableBtn() {
        var div = document.getElementById('btns');
        var btns = UE.dom.domUtils.getElementsByTagName(div, "button");
        for (var i = 0, btn; btn = btns[i++];) {
            UE.dom.domUtils.removeAttributes(btn, ["disabled"]);
        }
    }

    function getLocalData () {
        alert(UE.getEditor('editor').execCommand( "getlocaldata" ));
    }

    function clearLocalData () {
        UE.getEditor('editor').execCommand( "clearlocaldata" );
        alert("已清空草稿箱")
    }
</script>
</body>
</html>
