<%--
  Created by IntelliJ IDEA.
  User: Хитринцева Валерия
  Date: 15.01.2022
  Time: 0:53
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" import="laureats.laureats.country.*"%>
<jsp:useBean id="countryCollection" class="laureats.laureats.country.CountryCollection" scope="application"/>

<html>
<head>
    <title>Name of Country</title>
</head>
<%
    request.setCharacterEncoding("UTF-8");
%>
<body>
<center>
    <table border="1" cellpadding="5" cellspacing="0">
        <tr> <th> Страна  </th>  <th> Редактирование </th>  <th> Удаление </th></tr>
        <%
            for(Country country : countryCollection.findAll()){
        %>
        <tr bgcolor="#deb887">
            <td> <%=country.getCountryName()%></td>
            <td>
                <form action="refactorCountry.jsp" method="post">
                    <input type="hidden" name="id" value="<%=country.getId()%>">
                    <input type="submit" value="Редактировать">
                </form>
            </td>
            <td>
                <form action="#" method="post">
                    <input type="hidden" name="id" value="<%=country.getId()%>">
                    <input type="submit" value="Удалить">
                </form>
            </td>
            <%
                }
            %>
        </tr>
        <tr>
            <td colspan="5">
                <form action="refactorCountry.jsp" method="post">
                    <input type="hidden" name="id" value="-1">
                    <input type="submit" value="Добавить">
                </form>
            </td>
        </tr>
    </table>
</center>
</body>
</html>