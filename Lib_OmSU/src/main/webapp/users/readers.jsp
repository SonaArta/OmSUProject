<%--
  Created by IntelliJ IDEA.
  User: PanDa_WinZ
  Date: 22.10.2021
  Time: 10:51
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8" import="java.util.*, omsu.lib_omsu.users.*, omsu.lib_omsu.controller.UserController" %>
<jsp:useBean id="userCollection" class="omsu.lib_omsu.users.UserCollection" scope="application" />
<jsp:useBean id="readerCollection" class="omsu.lib_omsu.users.ReaderCollection" scope="application" />
<jsp:useBean id="connectDB" class="omsu.lib_omsu.connectDB.ConnectDB" scope="session"/>
<html>
<head>
    <title>Читатели</title>
</head>
<jsp:include page="../head/head.jsp"/>
<body bgcolor="#708090">
<%
    if(connectDB.getCurrentUser().getLogin()==null || connectDB.getCurrentUser().getLogin().isEmpty()){
%>
<jsp:forward page="../login.jsp" />
<%
    }
    System.out.println(readerCollection.getReaderValues());
%>
<center>
    <table border="3" cellpadding="7">
        <tr><th>ФИО</th><th>Паспорт</th><th>Номер телефона</th><th>login</th><th>Номер читательского билета</th><th> </th><th> </th></tr>
        <%
            for(Reader reader: readerCollection.getReaderValues()){
        %>
        <tr bgcolor=#ffc0cb>
            <td><%= reader.getName() %></td>
            <td><%= reader.getPassport() %></td>
            <td><%= reader.getPhoneNumber() %></td>
            <td><%= reader.getLogin()%></td>
            <td><%= reader.getReaderNumber()%></td>
            <td>
                <form action="../refactorUsers/updateReaders.jsp" method="POST">
                    <input type="hidden" name="id" value="<%=reader.getId()%>"/>
                    <input type="submit" value="Редактировать"/>
                </form>
            </td>
            <td>
                <form action="../refactorUsers/delReaders.jsp" method="POST">
                    <input type="hidden" name="id" value="<%=reader.getId()%>"/>
                    <input type="submit" value="Удалить"/>
                </form>
            </td>
        </tr>
        <%

            }
        %>
        <tr><td colspan="5">
            <form action="../refactorUsers/updateReaders.jsp" method="POST">
                <input type="hidden" name="id" value="-1"/>
                <input type="hidden" name="type" value="reader"/>
                <input type="submit" value="Добавить Чебурашку"/>
            </form>
        </td></tr>
    </table>
</center>
</body>
</html>

