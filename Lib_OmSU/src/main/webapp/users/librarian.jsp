<%--
  Created by IntelliJ IDEA.
  User: PanDa_WinZ
  Date: 22.10.2021
  Time: 16:40
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8" import="java.util.*, omsu.lib_omsu.users.*, omsu.lib_omsu.controller.UserController" %>
<jsp:useBean id="userCollection" class="omsu.lib_omsu.users.UserCollection" scope="application" />
<jsp:useBean id="librarianCollection" class="omsu.lib_omsu.users.LibrarianCollection" scope="application" />
<jsp:useBean id="connectDB" class="omsu.lib_omsu.connectDB.ConnectDB" scope="session" />
<html>
<head>
    <title>Наши сотрудники</title>
</head>
<jsp:include page="../head/head.jsp"/>
<body bgcolor="#708090">
<%
    if(connectDB.getCurrentUser().getLogin()==null || connectDB.getCurrentUser().getLogin().isEmpty()){
%>
<jsp:forward page="../login.jsp" />
<%
    }
    System.out.println(librarianCollection.getLibValues());
%>
<center>
    <table border="3" cellpadding="7">
        <tr><th>ФИО</th><th>Паспорт</th><th>Номер телефона</th><th>login</th><th>Табельный номер</th><th> </th><th> </th></tr>
        <%
            for(Librarian librarian: librarianCollection.getLibValues()){
        %>
        <tr bgcolor=#ffc0cb>
            <td align=center><%= librarian.getName() %></td>
            <td><%= librarian.getPassport() %></td>
            <td><%= librarian.getPhoneNumber() %></td>
            <td><%= librarian.getLogin()%></td>
            <td><%= librarian.getTabelNumber() %></td>
            <td>
                <form action="../refactorUsers/updateLibrarians.jsp" method="POST">
                    <input type="hidden" name="id" value="<%=librarian.getId()%>"/>
                    <input type="submit" value="Редактировать"/>
                </form>
            </td>
            <td>
                <form action="../refactorUsers/delLibrarian.jsp" method="POST">
                    <input type="hidden" name="id" value="<%=librarian.getId()%>"/>
                    <input type="submit" value="Удалить"/>
                </form>
            </td>
        </tr>
        <%
            }
        %>
        <tr><td colspan="5">
            <form action="../refactorUsers/updateLibrarians.jsp" method="POST">
                <input type="hidden" name="id" value="-1"/>
                <input type="hidden" name="type" value="librarian"/>
                <input type="submit" value="Добавить Шапокляк"/>
            </form>
        </td></tr>
    </table>
</center>
</body>
</html>

