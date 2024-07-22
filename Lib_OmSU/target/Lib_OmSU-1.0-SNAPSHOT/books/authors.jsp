<%--
  Created by IntelliJ IDEA.
  User: happy
  Date: 03.11.2021
  Time: 20:14
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8" import="java.util.*, omsu.lib_omsu.controller.BookController" %>
<%@ page import="omsu.lib_omsu.author.Author" %>
<%@ page import="omsu.lib_omsu.author.AuthorCollection" %>
<jsp:useBean id="authorCollection" class="omsu.lib_omsu.author.AuthorCollection" scope="application" />
<jsp:useBean id="connectDB" class="omsu.lib_omsu.connectDB.ConnectDB" scope="session" />
<!DOCTYPE html>
<html>
<head>
    <title>Авторы</title>
</head>
<jsp:include page="../head/head.jsp"/>
<body>
<%
    if(connectDB.getCurrentUser().getLogin()==null || connectDB.getCurrentUser().getLogin().isEmpty())
    {
%>
<jsp:forward page="../login.jsp"/>
<%
    }
    System.out.println(authorCollection.getAuthorValues());
    if (authorCollection.getAuthorValues().isEmpty()) {
        authorCollection.setAuthorCollection(BookController.loadAuthorFromDB(connectDB));
    }
%>
<center>
    <table border="1" cellpadding="5" cellspacing="0">
        <tr><th>Автор</th> <th>    </th> <th>    </th></tr>
        <%
            for(Author author : authorCollection.findAll() ){
        %>
        <tr bgcolor=#ffc0cb>
            <td align=center><%= author.getName() %></td>
            <td>
                <form action="../refactorBooks/updateAuthors.jsp" method="POST">
                    <input type="hidden" name="id" value="<%=author.getId()%>"/>
                    <input type="submit" value="Редактировать"/>
                </form>
            </td>
            <td>
                <form action="../refactorBooks/delAuthors.jsp" method="POST">
                    <input type="hidden" name="id" value="<%=author.getId()%>"/>
                    <input type="submit" value="Удалить"/>
                </form>
            </td>
        </tr>
        <%
            }
        %>
        <tr><td colspan="5">
            <form action="../refactorBooks/updateAuthors.jsp" method="POST">
                <input type="hidden" name="id" value="-1"/>
                <input type="submit" value="Добавить автора"/>
            </form>
        </td></tr>
    </table>
</center>
</body>
</html>
