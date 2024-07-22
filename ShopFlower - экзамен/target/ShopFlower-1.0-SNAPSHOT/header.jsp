<%--
  Created by IntelliJ IDEA.
  User: Хитринцева Валерия
  Date: 15.01.2022
  Time: 15:13
  To change this template use File | Settings | File Templates.
--%>
<jsp:useBean id="connectDB" class="connectDB.ConnectDB" scope="session"/>
<html>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
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

<%--<div class="navbar"  "><a href="/Lib"><%=currentUser.getLogin()%></a></div>--%>
