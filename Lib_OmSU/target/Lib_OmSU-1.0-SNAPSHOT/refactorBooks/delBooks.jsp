<%@ page import="omsu.lib_omsu.books.Book" %><%--
  Created by IntelliJ IDEA.
  User: Хитринцева Валерия
  Date: 04.11.2021
  Time: 18:53
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:useBean id="bookCollection" class="omsu.lib_omsu.books.BookCollection" scope="application"/>
<jsp:useBean id="bookController" class="omsu.lib_omsu.controller.BookController" scope="application"/>
<jsp:useBean id="connectDB" class="omsu.lib_omsu.connectDB.ConnectDB" scope="session" />
<html>
<head>
    <title>Удаление книг</title>
</head>

<jsp:include page="../head/head.jsp"/>
<%
    if(!connectDB.getCurrentUser().getStatus().getStatus().equals("librarian")){
%>
    <jsp:forward page="../head/rights.jsp"/>
<%
    }
%>
<body>
<%
    String id_ = request.getParameter("id");
    Long   id  = null;
    try{
        id = Long.parseLong(id_);
    }    catch(Exception e){
        out.println("<font color=\"ivory\">error parsing Long value (id) =="+id_+"</font>");
        return;
    }
    Book book = null;
    if(id>=0L)
    {
        book = bookCollection.get(id);
        bookCollection.remove(book);
        //BookCollection.removeBookFromDB(connection, id);
    }
%>
<center>
    <h2><style> .colortext{color: honeydew;} </style> <span class="colortext">
        Удаление прошло успешно!</span>
    </h2>
    <form action="../books/books.jsp" method="POST">
        <input type = "submit" value = "Вернуться к списку пользователей"/>
    </form>
</center>
</body>
</html>
