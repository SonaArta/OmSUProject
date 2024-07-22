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
<jsp:useBean id="currentUser" class="omsu.lib_omsu.users.User" scope="session" />
<html>
<head>
    <title>Заказы</title>
</head>
<jsp:include page="../head/head.jsp"/>
<body bgcolor = "#c9a0dc">
<%
    Long id = currentUser.getId();
    if(currentUser.getLogin() == null)
    {
%>
<jsp:forward page="../login.jsp"/>
<%
    }
%>

<center>
    <table border="1" cellpadding="5" cellspacing="0">
        <tr> <th>ФИО читателя</th> <th>Книги</th> <th> Статус заказа</th> <th> Дата выдачи</th>
            <th> Дата возврата </th> <th> Период </th> <th> Цена </th>

        <%
            Order o = orderCollection.FindOrderReaderId(id);
        %>
        <tr bgcolor="gray">
            <td align="center"><%=o.getReader().getName()%></td>
            <td>
                <%
                    for(BookInStock bis: o.getBookInStock().FindAll()){

                %>
                <%=bis.getBook().getName()%> <br> <%}%>
            </td>
            <td align="center"><%=o.getStatus()%></td>
            <td align="center"><%=o.getBeginData()%></td>
            <td align="center"><%=o.getEndData()%></td>
            <td align="center"><%=o.getDuration()%></td>
            <td align="center"><%=o.getPrice()%></td>

        </tr>
    </table>
</center>

</body>
</html>
