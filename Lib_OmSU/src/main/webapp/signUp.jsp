<%--
  Created by IntelliJ IDEA.
  User: PanDa_WinZ
  Date: 20.11.2021
  Time: 14:29
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8" import="java.util.*, omsu.lib_omsu.users.*" %>
<%@ page import="omsu.lib_omsu.controller.UserController" %>
<jsp:useBean id="userCollection" class="omsu.lib_omsu.users.UserCollection" scope="application" />
<jsp:useBean id="readerCollection" class="omsu.lib_omsu.users.ReaderCollection" scope="application" />
<jsp:useBean id="librarianCollection" class="omsu.lib_omsu.users.LibrarianCollection" scope="application" />
<jsp:useBean id="userStatusCollection" class="omsu.lib_omsu.users.UserStatusCollection" scope="application" />
<jsp:useBean id="connectDB" class="omsu.lib_omsu.connectDB.ConnectDB" scope="session"/>
<html>
<head>
  <title>Регистрация</title>
  <meta charset="UTF-8" />
  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Авторизация</title>
  <meta name="keywords" content="css3, login, form, custom, input, submit, button, html5, placeholder" />
  <meta name="author" content="Codrops" />
  <link rel="stylesheet" type="text/css" href="css/style.css" />
  <script src="js/modernizr.custom.63321.js"></script>
  <!--[if lte IE 7]>
  <style>.main{display:none;}
  .support-note .note-ie{display:block;}</style><![endif]-->
  <style>
    body {
      background: #1f2124 url(images/wood_pattern.jpg);
    }
  </style>
  <%
    request.setCharacterEncoding("UTF-8");
  %>
</head>
<style>
  TABLE {
    background: maroon; /* Цвет фона таблицы */
    width: 400px; /* Ширина таблицы */
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
  .round {
    border-radius: 100px; /* Радиус скругления */
    border: 1px solid #ffb347; /* Параметры рамки */
    box-shadow: 0 0 7px #666; /* Параметры тени */
  }
</style>
</style>
<body>
<%
    String name = request.getParameter("name");
    String login = request.getParameter("login");
    String password = request.getParameter("password");
    String passport = request.getParameter("passport");
    String phoneNumber = request.getParameter("phoneNumber");
    String readerNumber = request.getParameter("readerNumber");

        UserStatus status = userStatusCollection.get(UserStatusCollection.idReaderStatus);
        String isChanged = request.getParameter("ischanged");
        System.out.println("-> 2 step user ");
        if(isChanged != null && isChanged.equals("true")) {
            User user = new Reader(name, passport, phoneNumber, login, password, readerNumber, status, null);
            userCollection.put(user);
            UserController.saveUserFromDataBase(connectDB,user);
            System.out.println("New user -->" + user);
%>
            <form class="form-2" action="login.jsp">
                <center>
                    <h1><span class="sign-up">Регистрация прошла успешно</span></h1>
                    <p class="clearfix" align="center">
                    <input type="submit" name="submit" value="Авторизоваться">
                    </p>
                </center>
            </form>
<%
        }else{
            System.out.println("-> Create -------------->");
            Long id = 0L;
%>
<center>
    <h1>
      Регистрация
    </h1>
</center>
<center>
<div class="container">
<section class="main">
    <form class="form-2" action="/Lib/signUp.jsp" method = "POST">
        <input type="hidden" name="ischanged" value="true">
        <input type="hidden" name="id" value="<%=id%>">
            <tr>
                <td align="center" bgcolor=#ffc0cb> ФИО</td>
                <td> <input type="text" name="name"></td>
            </tr>
            <tr>
                <td align="center" bgcolor="gray"> Паспорт </td>
                <td> <input type="text" name="passport"></td>
            </tr>
            <tr>
                <td align="center" bgcolor="gray"> Номер телефона </td>
                <td> <input type="text" name="phoneNumber"></td>
            </tr>
            <tr>
                <td align="center" bgcolor="gray"> Логин </td>
                <td> <input type="text" name="login"></td>
            </tr>
            <tr>
                <td align="center" bgcolor="gray"> Пароль </td>
                <td> <input type="password" name="password"></td>
            </tr>
            <tr>
                <td align="center" bgcolor="gray"> Номер читательского билета </td>
                <td> <input type="text" name="readerNumber"></td>
            </tr>
            <tr>
                <td align="center" bgcolor=#ffc0cb>Статус</td>
                <td><input type="text" name="status" value="<%=status.getStatus()%>" readonly></td>
            </tr>
            <tr>
                <p class="clearfix">
                <input type="submit" name="submit" value="Ок">
                <a href="/Lib/login.jsp" class="log-twitter">Вернуться назад</a>
                </p>
            </tr>
    </form>
</section>
</div>
</center>
</body>
<%
        System.out.println("Create user successfully ");
        }

%>
</html>