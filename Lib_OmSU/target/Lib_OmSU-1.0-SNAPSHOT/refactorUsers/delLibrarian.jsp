<%--
  Created by IntelliJ IDEA.
  User: PanDa_WinZ
  Date: 01.11.2021
  Time: 11:40
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" import="omsu.lib_omsu.users.*, omsu.lib_omsu.controller.UserController" %>
<jsp:useBean id="userCollection" class="omsu.lib_omsu.users.UserCollection" scope="application"/>
<jsp:useBean id="librarianCollection" class="omsu.lib_omsu.users.LibrarianCollection" scope="application"/>
<jsp:useBean id="connectDB" class="omsu.lib_omsu.connectDB.ConnectDB" scope="session" />

<html>
<head>
    <title>Удаление библиотекаря</title>
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
    User user = null;
    if(id>=0L){
        user = userCollection.get(id);
        librarianCollection.remove((Librarian) user);
        userCollection.remove(user);
        UserController.removeUserFromDataBase(connectDB,id,user);
    }
%>
<center>
    <h2><style> .colortext{color: honeydew;} </style> <span class="colortext">
        Удаление прошло успешно!</span>
    </h2>
    <form action="../users/librarian.jsp" method="POST">
        <input type="submit" value="Вернуться к списку пользователей"/>
    </form>
</center>
</body>
</html>

