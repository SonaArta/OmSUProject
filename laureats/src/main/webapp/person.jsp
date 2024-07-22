<%--
  Created by IntelliJ IDEA.
  User: Хитринцева Валерия
  Date: 15.01.2022
  Time: 1:48
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" import="laureats.laureats.*" %>
<%@ page import="laureats.laureats.controller.AwardsController" %>
<%@ page import="laureats.laureats.awards.Awards" %>
<jsp:useBean id="gunCollection" class="laureats.laureats.awards.AwardsCollection" scope="application"/>
<jsp:useBean id="countryCollection" class="laureats.laureats.country.CountryCollection" scope="application"/>
<jsp:useBean id="typeGunCollection" class="laureats.laureats.fields.FieldCollection" scope="application"/>
<jsp:useBean id="connectDB" class="laureats.laureats.connectDB.ConnectDB" scope="session" />

<html>
<head>
    <title>Store Gun</title>
</head>

<%
    request.setCharacterEncoding("UTF-8");
%>

<body>


<center>
    <table border="1" cellpadding="5" cellspacing="0">
        <tr> <th> ФИО </th> <th> Страна </th> <th> Список наград </th> <th> </th> <th> </th> <th> Корзина </th></tr>
        <%
            for(Person person: personCollection.findAll()){
        %>
        <tr bgcolor="#deb887">
            <td> <%= person.getName() %></td>
            <td> <%= person.getCountry().getCountryName()%></td>
            <td>
                <%
                    for(Awards a: person.getAwardsCollection().findAll()){

                %>
                <%=a.getYear()%> <br>
                <% }%>
            </td>
            <td>
                <%
                    for(Awards a: person.getAwardsCollection().findAll()){

                %>
                <%=a.getField().getName()%> <br>
                <% }%>
            </td>
            <td>
                <form action="refactorPerson.jsp" method="post">
                    <input type="hidden" name="id" value="<%=person.getId()%>">
                    <input type="submit" value="Редактировать">
                </form>
            </td>
            <td>
                <form action="#" method="post">
                    <input type="hidden" name="id" value="<%=person.getId()%>">
                    <input type="submit" value="Удалить">
                </form>
            </td>
            <td>
                <form action="#" method="post">
                    <input type="submit" value="Добавить в корзину">
                </form>
            </td>
            <% }%>
        </tr>
        <tr>
            <td colspan="5">
                <form action="refactorPerson.jsp" method="post">
                    <input type="hidden" name="id" value="-1">
                    <input type="submit" value="Добавить">
                </form>
            </td>
        </tr>
    </table>
</center>
</body>
</html>
