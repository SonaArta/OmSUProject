<%--
  Created by IntelliJ IDEA.
  User: PanDa_WinZ
  Date: 22.10.2021
  Time: 11:06
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Что-то пошло не так</title>
</head>
<jsp:include page="head.jsp"/>
<body bgcolor="#ffb6c1">
<center>
    <h1> <style> .colortext{color: red;} </style> <span class="colortext">Кажется у вас недостаточно прав </span> </h1>
    <h3> Советуем обратится к администрации библиотеки или системному администратору </h3>
    <form action="/Lib/index.jsp" method="POST">
        <input type="submit" value="Вернутся на главную страницу"/>
    </form>
</center>
</body>
</html>
