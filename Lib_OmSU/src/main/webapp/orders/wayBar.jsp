<%--
  Created by IntelliJ IDEA.
  User: denb2
  Date: 19.11.2021
  Time: 23:59
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" import="omsu.lib_omsu.users.*" %>
<jsp:useBean id="currentUser" class="omsu.lib_omsu.users.User" scope="session" />
<html>
<head>
    <title>Title</title>
</head>

<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<style type="text/css">

    .navbar {
        overflow: hidden;
        background-color: #333;
    <%--background-image: url(https://html5book.ru/wp-content/uploads/2017/03/dulcineia-dias-195000.jpg);--%>
        font-family: Arial, Helvetica, sans-serif;
    }

    .navbar a {
        float: left;
        font-size: 16px;
        color: white;
        text-align: center;
        padding: 14px 16px;
        text-decoration: none;
    }

    .dropdown {
        float: left;
        overflow: hidden;
    }

    .dropdown .dropbtn {
        font-size: 16px;
        border: none;
        outline: none;
        color: white;
        padding: 14px 16px;
        background-color: inherit;
        font-family: inherit;
        margin: 0;
    }

    .navbar a:hover, .dropdown:hover .dropbtn {
        background-color: red;
    }

    .dropdown-content {
        display: none;
        position: absolute;
        background-color: gray;
        min-width: 160px;
        box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
        z-index: 1;
    }

    .dropdown-content a {
        float: none;
        color: black;
        padding: 12px 16px;
        text-decoration: none;
        display: block;
        text-align: left;
    }

    .dropdown-content a:hover {
        background-color: #ddd;
    }

    .dropdown:hover .dropdown-content {
        display: block;
    }
</style>

<body bgcolor="#708090">
<%
    if(currentUser.getLogin()==null || currentUser.getLogin().isEmpty()){
%>
<jsp:forward page="../login.jsp" />
<%
    }
%>
<%
    request.setCharacterEncoding("UTF-8");
%>


<%
    if(currentUser.getStatus() == "librarian"){
%>
<div class="navbar">
    <a href="/Lib/users/personal_information.jsp">Персональная информация</a>
    <a href="/Lib/index.jsp" align="left">Новые заказы</a>
    <a href="currentAllOrders.jsp" align="center">Текущие заказы</a>
    <a href="/Lib/search/search.jsp" align="right">Просроченные заказы</a>
    <div style="float: right;">
        <a href="/Lib/login.jsp" align="right">Выход</a>
    </div>
</div>
<%
    }else{
%>
<div class="navbar">
    <a href="/Lib/users/personal_information.jsp">Персональная информация</a>
    <a href="/Lib/orders/current_all_orders.jsp">Текущие заказы</a>
    <div style="float: right;">
        <a href="/Lib/login.jsp" align="right">Выход</a>
    </div>
</div>
<%
    }
%>
</body>
</html>
