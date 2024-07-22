<%@ page contentType="text/html;charset=UTF-8" language="java" import="omsu.lib_omsu.users.*, omsu.lib_omsu.label.*" %><%@ page import="omsu.lib_omsu.author.Author" %>
<%@ page import="omsu.lib_omsu.author.AuthorCollection" %>
<%@ page import="omsu.lib_omsu.controller.BookController" %>
<jsp:useBean id="authorCollection" class="omsu.lib_omsu.author.AuthorCollection" scope="application" />
<jsp:useBean id="connectDB" class="omsu.lib_omsu.connectDB.ConnectDB" scope="session" />

<html>
<head>
    <title>Удаление автора</title>
</head>
<jsp:include page="../head/head.jsp"/>
<%
    if(!connectDB.getCurrentUser().getStatus().getStatus().equals("librarian")){
%>
<jsp:forward page="../head/rights.jsp" />
<%
    }
%>
<body>
<%
    String id_ = request.getParameter("id");
    Long id = null;
    try{
        id = Long.parseLong(id_);
    }catch(Exception e){
        out.println("<font color=\"ivory\">error parsing Long value (id) =="+id_+"</font>");
        return;
    }
    Author author = null;
    if(id>=0L){
        author = authorCollection.get(id);
        authorCollection.remove(author);
        BookController.removeAuthorFromDataBase(connectDB,id);
    }
%>
<center>
    <h2><style> .colortext{color: honeydew;} </style> <span class="colortext">
        Удаление прошло успешно!</span>
    </h2>
    <form action="../books/authors.jsp" method="POST">
        <input type="submit" value="Вернуться к списку авторов"/>
    </form>
</center>
</body>
</html>
