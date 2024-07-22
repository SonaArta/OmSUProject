<%@ page contentType="text/html;charset=UTF-8" language="java" import="omsu.lib_omsu.users.*" %>
<jsp:useBean id="connectDB" class="omsu.lib_omsu.connectDB.ConnectDB" scope="session"/>
<html>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Библиотека NUX</title>
<style type="text/css">
    TABLE {
      background: maroon; /* Цвет фона таблицы */
      width: 800px; /* Ширина таблицы */
      border: 1px solid black; /* Рамка вокруг таблицы */
      margin: auto;
    }
    TD{
      padding: 3px; /* Поля вокруг содержимого ячеек */
    }
    TH {
      text-align: center; /* Выравнивание по левому краю */
      background: black; /* Цвет фона */
      color: pink; /* Цвет текста */
    }
    body {
      background-image: url(../images/fon2.jpg); /* Путь к фоновому изображению */
      background-color: #c7b39b; /* Цвет фона */
    }

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
      float: right;
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
    if(connectDB.getCurrentUser().getLogin()==null || connectDB.getCurrentUser().getLogin().isEmpty()){
%>
      <jsp:forward page="../login.jsp" />
<%
    }
%>
  <%
    request.setCharacterEncoding("UTF-8");
%>


<div class="navbar">
  <a href="/Lib/index.jsp">Главная страница</a>
  <a href="/Lib/search/search.jsp">Поиск</a>
  <div class="dropdown">
    <button class="dropbtn">Книги
      <i class="fa fa-caret-down"></i>
    </button>
    <div class="dropdown-content">
      <a href="/Lib/books/books.jsp">Книги в наличии</a>
      <a href="/Lib/books/label.jsp">Издательства</a>
      <a href="/Lib/books/authors.jsp">Авторы</a>
    </div>
  </div>
  <div class="dropdown">
    <button class="dropbtn">Пользователи
      <i class="fa fa-caret-down"></i>
    </button>
    <div class="dropdown-content">
      <a href="/Lib/users/librarian.jsp">Наши сотрудники</a>
      <a href="/Lib/users/readers.jsp">Список читателей</a>
      <a href="/Lib/users/allUsers.jsp">Все пользователи</a>
    </div>
  </div>
  <a href="/Lib/hello-servlet">Проверка даты</a>
  <div style="float: right;">
    <div class="dropdown">
      <button class="dropbtn">Ваш личный кабинет,<%=connectDB.getCurrentUser().getLogin()%>
        <i class="fa fa-caret-down"></i>
      </button>
      <div class="dropdown-content">
        <a href="/Lib/users/personalInformation.jsp">Персональная информация</a>
        <a href="/Lib/index.jsp">Новые заказы</a>
        <a href="/Lib/currentAllOrders.jsp">Текущие заказы</a>
        <a href="/Lib/search/search.jsp">Просроченные заказы</a>
        <a href="/Lib/login.jsp" >Выход</a>
      </div>
    </div>
  </div>
</div>
<%--<div class="navbar"  "><a href="/Lib"><%=currentUser.getLogin()%></a></div>--%>
