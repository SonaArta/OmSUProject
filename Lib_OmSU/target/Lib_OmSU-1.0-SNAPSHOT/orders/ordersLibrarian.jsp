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
    if(connectDB.getCurrentUser().getLogin()==null || connectDB.getCurrentUser().getLogin().isEmpty())
    {
%>
<jsp:forward page="../login.jsp"/>
<%
    }
%>

<center>
    <table border="1" cellpadding="5" cellspacing="0">
        <tr> <th>ФИО читателя</th> <th> Индивидуальный номер читателя </th><th>Книги</th> <th> invNumber </th> <th> isbn </th><th> Статус заказа</th> <th> Дата выдачи</th>
            <th> Дата возврата </th> <th> Период </th> <th> Цена </th> <th>  </th> <th> </th></tr>

        <%
            for(Order o: orderCollection.FindAll()){
        %>
        <tr bgcolor="gray">
            <td align="center"><%=o.getReader().getName()%></td>
            <td align="center"><%=o.getReader().getReaderNumber()%></td>
            <td>
                <%
                    for(BookInStock bis: o.getBookInStock().FindAll()){

                %>
                <%=bis.getBook().getName()%> <br> <br>
                <%}%>
            </td>
            <td>
                <%
                    for(BookInStock bis: o.getBookInStock().FindAll()){

                %>
                <%=bis.getInvNumber()%> <br> <br>
                <%}%>
            </td>
            <td>
                <%
                    for(BookInStock bis: o.getBookInStock().FindAll()){

                %>
                <%=bis.getBook().getIsbn()%> <br> <br>
                <%}%>
            </td>
            <td align="center"><%=o.getStatus()%></td>
            <td align="center"><%=o.getBeginData()%></td>
            <td align="center"><%=o.getEndData()%></td>
            <td align="center"><%=o.getDuration()%></td>
            <td align="center"><%=o.getPrice()%></td>

            <td align ="center">
                <form action = "../refactorBooks/updateBooks.jsp" method = "POST">
                    <input type="hidden" name="id" value="<%=o.getId()%>"/>
                    <input type = "submit" value = "Редактировать" />
                </form>
            </td>
            <td align ="center">
                <form action = "../refactorBooks/delBooks.jsp" method = "POST">
                    <input type="hidden" name="id" value="<%=o.getId()%>"/>
                    <input type = "submit" value = "Удалить" />
                </form>
            </td>
        </tr>
        <%
            }
        %>
    </table>
</center>

</body>
</html>
