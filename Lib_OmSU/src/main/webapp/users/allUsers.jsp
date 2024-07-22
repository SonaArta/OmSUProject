<%--
  Created by IntelliJ IDEA.
  User: PanDa_WinZ
  Date: 22.10.2021
  Time: 14:51
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8" import="java.util.*, omsu.lib_omsu.users.*, omsu.lib_omsu.controller.UserController" %>
<jsp:useBean id="userCollection" class="omsu.lib_omsu.users.UserCollection" scope="application" />
<jsp:useBean id="connectDB" class="omsu.lib_omsu.connectDB.ConnectDB" scope="session" />
<!DOCTYPE html>
<head>
    <title>Библиотека</title>
</head>
<jsp:include page="../head/head.jsp"/>
<body bgcolor="#708090">
<%
    if(connectDB.getCurrentUser().getLogin()==null || connectDB.getCurrentUser().getLogin().isEmpty()){
%>
<jsp:forward page="../login.jsp" />
<%
    }
%>

<center>
<table border="1" cellpadding="5" cellspacing="0">
    <tr><th>FIO</th><th><%if(connectDB.getCurrentUser().getStatus().getStatus().equals("librarian")){%>Паспорт<%}%></th><th>PhoneNumber</th><th>login</th> <th>Статус</th><th>    </th> <th>    </th></tr>
        <%
    for(User u : userCollection.findAll()){
%>
    <tr bgcolor=#ffc0cb>
        <td align=center><%= u.getName() %></td>
<%
        if(connectDB.getCurrentUser().getStatus().getStatus().equals("librarian")){
%>
        <td><%= u.getPassport() %></td>
<%
        }
%>
        <td><%= u.getPhoneNumber() %></td>
        <td><%= u.getLogin()%></td>
        <td><%= u.getStatus().getStatus() %></td>
        <td>
            <form action="../refactorUsers/updateUsers.jsp" method="POST">
                <input type="hidden" name="id" value="<%=u.getId()%>"/>
                <input type="submit" value="Редактировать"/>
            </form>
        </td>
        <td>
            <form action="../refactorUsers/delUsers.jsp" method="POST">
                <input type="hidden" name="id" value="<%=u.getId()%>"/>
                <input type="submit" value="Удалить"/>
            </form>
        </td>
<%
    }
%>
    </tr>
    <tr><td colspan="5">
        <form action="../refactorUsers/updateUsers.jsp" method="POST">
            <input type="hidden" name="id" value="-1"/>
            <input type="hidden" name="type" value="reader"/>
            <input type="submit" value="Добавить Чебурашку"/>
        </form>
        <form action="../refactorUsers/updateUsers.jsp" method="POST">
            <input type="hidden" name="id" value="-1"/>
            <input type="hidden" name="type" value="librarian"/>
            <input type="submit" value="Добавить Шапокляк"/>
        </form>
    </td>
    </tr>
</table>
</center>
</body>
</html>
