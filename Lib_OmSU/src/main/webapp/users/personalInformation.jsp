<%--
  Created by IntelliJ IDEA.
  User: denb2
  Date: 20.11.2021
  Time: 3:07
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" import="omsu.lib_omsu.users.*" %>
<jsp:useBean id="connectDB" class="omsu.lib_omsu.connectDB.ConnectDB" scope="session" />
<html>
<head>
    <title>Персональная информация</title>
</head>
<jsp:include page="../head/head.jsp"/>
<%--<jsp:include page="../orders/wayBar.jsp"/>--%>

<body bgcolor = "#c9a0dc">

<%
    if(connectDB.getCurrentUser().getStatus().getStatus() == "librarian"){
%>
<table border="1" cellpadding="5" cellspacing="0">

    <tr bgcolor="gray">
        <td align="center"><%=connectDB.getCurrentUser().getName()%></td>
        <td align="center"><%=connectDB.getCurrentUser().getPassport()%></td>
        <td align="center"><%=connectDB.getCurrentUser().getPhoneNumber()%></td>
        <td align="center"><%=connectDB.getCurrentUser().getLogin()%></td>
        <td align="center"><%="Пока нет глобальной области, или не реализован паттерн синглтон будет сложно узнать то, что не принадлежит классу User"%></td>
    </tr>
</table>
<%
    }else{
%>
<table border="1" cellpadding="5" cellspacing="0">
    <tr><th>ФИО</th><th>Номер телефона</th><th>Информация</th>
    </tr>
    <tr bgcolor="gray">
        <td><%=connectDB.getCurrentUser().getName()%></td>
        <td><%=connectDB.getCurrentUser().getPhoneNumber()%></td>
        <td><%="Пока нет глобальной области, или не реализован паттерн синглтон будет сложно узнать то, что не принадлежит классу User"%></td>
    </tr>
</table>
<%
    }
%>
</body>
</html>
