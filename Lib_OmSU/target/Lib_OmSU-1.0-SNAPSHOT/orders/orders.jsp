<%--
  Created by IntelliJ IDEA.
  User: Хитринцева Валерия
  Date: 04.11.2021
  Time: 19:14
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="omsu.lib_omsu.author.Author" %>
<%@ page import="omsu.lib_omsu.label.Label" %>
<%@ page import="omsu.lib_omsu.order.Order" %>
<%@ page import="omsu.lib_omsu.users.Reader" %>
<%@ page import="omsu.lib_omsu.books.BookInStock" %>
<jsp:useBean id="counterBean" class="omsu.lib_omsu.counter.CounterBean" scope="application" />
<jsp:useBean id="orderCollection" class="omsu.lib_omsu.order.OrderCollection" scope="application" />
<jsp:useBean id="connectDB" class="omsu.lib_omsu.connectDB.ConnectDB" scope="session" />
<html>
<head>
    <title>Заказы</title>
</head>
<jsp:include page="../head/head.jsp"/>
<body bgcolor = "#c9a0dc">
<%
    if(connectDB.getCurrentUser().getStatus().getStatus() == "librarian")
    {
%>
<jsp:forward page="ordersLibrarian.jsp"/>
<%
    }
    else{
%>
<jsp:forward page="orderReader.jsp"/>
<%}%>


</body>
</html>
