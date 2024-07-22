<%--
  Created by IntelliJ IDEA.
  User: alina
  Date: 12.11.2021
  Time: 22:04
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8" import="java.util.*, omsu.lib_omsu.search.*" %>
<jsp:useBean id="currentUser" class="omsu.lib_omsu.users.User" scope="session"/>
<html>
<head>
    <title>Поиск</title>
</head>
<jsp:include page="../head/head.jsp"/>
<body bgcolor="#708090">
    <%
    if(currentUser.getLogin()==null){
%>
<jsp:forward page="../login.jsp" />
    <%
    }
%>
<body>
<center>
    <h1><style> .colortext{color: honeydew;} </style> <span class="colortext">
        ПОИСКОВАЯ СИСТЕМА NUX </span>
        <%
            String searchString = " ";
            searchString = request.getParameter("searchString");
        %>
        <form action="search.jsp" method="post">
            <h3><input type="text" name="searchString" value="<%=searchString%>" size="100" rows="5"></h3>
        <center><input type="submit" value="Поиск"/></center>
        </form>
    </h1>
</center>

</body>
</html>
