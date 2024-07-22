<%--
  Created by IntelliJ IDEA.
  User: arik7
  Date: 18.10.2021
  Time: 10:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8" import="java.util.*, omsu.lib_omsu.users.*" %>
<jsp:useBean id="counterBean" class="omsu.lib_omsu.counter.CounterBean" scope="application" />
<jsp:useBean id="userCollection" class="omsu.lib_omsu.users.UserCollection" scope="application" />
<jsp:useBean id="currentUser" class="omsu.lib_omsu.users.User" scope="session" />
<!DOCTYPE html>
<html>
<head>
    <title>JSP - Hello World</title>
</head>
<body bgcolor="#708090">

<P><%=currentUser%>
        <%
    if(currentUser.getLogin()==null){
%>
    <jsp:forward page="../login.jsp" />
        <%
    }
%>

<P>
<h1>Hello World!
    <br><%= (new Date()) %>
</h1>
<br/>
<a href="hello-servlet">Hello Servlet</a>
<%
    int counter;
    counter = counterBean.getCounter();
%>
<p align="center">counter==
        <%
    out.println(counter);
    session.setAttribute("FIRSTDATE", (new Date()));
%>
    <center>
<table border="3" cellpadding="7">
    <tr><th>FIO</th><th>PhoneNumber</th><th>Status</th><th>login</th></tr>
        <%
    for(User u : userCollection.findAll()){
%>
    <tr bgcolor=#ffc0cb>
        <td align=center><%= u.getName() %></td>
        <td><%= u.getPhoneNumber() %></td>
        <td><%= u.getStatus() %></td>
        <td><%= u.getLogin()%></td>
        <td>
            <form action="../login.jsp" method="POST">
                <input type="submit" value="Редактировать"/>
            </form>
        </td>
        <td>
            <form action="../login.jsp" method="POST">
                <input type="submit" value="Удалить"/></td>
            </form>
    </tr>
        <%
    }
%>
    </center>
</body>
</html>
<%
    System.out.println("page index.jsp counter="+counter);
    out.println("Check :=> ");
    Date d = (Date)session.getAttribute("FIRSTDATE");
    out.println("getSession(FIRSTDATE)=="+d);
%>

