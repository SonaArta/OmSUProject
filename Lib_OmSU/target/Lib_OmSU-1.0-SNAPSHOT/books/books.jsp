<%--
  Created by IntelliJ IDEA.
  User: Хитринцева Валерия
  Date: 21.10.2021
  Time: 12:20
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" import="java.util.*, omsu.lib_omsu.books.*" %>
<%@ page import="com.sun.source.tree.LiteralTree" %>
<%@ page import="omsu.lib_omsu.author.*" %>
<%@ page import="omsu.lib_omsu.label.*" %>
<%@ page import="omsu.lib_omsu.controller.BookController" %>
<jsp:useBean id="bookCollection" class="omsu.lib_omsu.books.BookCollection" scope="application" />
<jsp:useBean id="authorCollection" class="omsu.lib_omsu.author.AuthorCollection" scope="application" />
<jsp:useBean id="labelCollection" class="omsu.lib_omsu.label.LabelCollection" scope="application" />
<jsp:useBean id="connectDB" class="omsu.lib_omsu.connectDB.ConnectDB" scope="session" />
<!DOCTYPE html>
<html>
<head>
    <title> Книги </title>
</head>
<jsp:include page="../head/head.jsp"/>
<body bgcolor = "#c9a0dc">
<%
    if(connectDB.getCurrentUser().getLogin()==null || connectDB.getCurrentUser().getLogin().isEmpty())
    {
%>
<jsp:forward page="../login.jsp"/>
<%
    }

    System.out.println(bookCollection.getBookValues());
    if (bookCollection.getBookValues().isEmpty()) {
        labelCollection.setLabelCollection(BookController.loadLabelFromDB(connectDB));
        authorCollection.setAuthorCollection(BookController.loadAuthorFromDB(connectDB));
        bookCollection.setBookCollection(BookController.loadBookFromDB(connectDB,labelCollection, authorCollection));
    }
    System.out.println(bookCollection.getBookValues());
%>

<center>
    <table border="1" cellpadding="5" cellspacing="0">
        <tr> <th> Название</th> <th> ISBN </th> <th>Автор</th><th>Издательство</th> <th>   </th> <th>   </th></tr>
        <%
            for(Book b: bookCollection.FindAll()){
        %>
        <tr bgcolor="#fff0f5">
            <td align=center><%= b.getName()%></td>
            <td><%= b.getIsbn()%></td>
            <td>
                <%for(Author a: b.getAuthorCollection().findAll()){ %> <%=a.getName()%> <br> <% }%>
            </td>
            <td>
                <% for(Label l: b.getLabelCollection().findAll()){ %> <%=l.getName()%> <br> <% }%>
            </td>

            <td align ="center">
                <form action = "../refactorBooks/updateBooks.jsp" method = "POST">
                    <input type="hidden" name="id" value="<%=b.getId()%>"/>
                    <input type = "submit" value = "Редактировать" />
                </form>
            </td>
            <td align ="center">
                <form action = "../refactorBooks/delBooks.jsp" method = "POST">
                    <input type="hidden" name="id" value="<%=b.getId()%>"/>
                    <input type = "submit" value = "Удалить" />
                </form>
            </td>
        </tr>
        <%
            }
        %>
        <tr><td colspan="5">
            <form action="../refactorBooks/updateBooks.jsp" method="POST">
                <input type="hidden" name="id" value="-1"/>
                <input type="submit" value="Добавить книгу"/>
            </form>
        </td></tr>
    </table>
</center>
</body>

</html>