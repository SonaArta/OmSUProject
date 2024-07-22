<%--
  Created by IntelliJ IDEA.
  User: Хитринцева Валерия
  Date: 15.01.2022
  Time: 14:01
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" import="flower.*, country.*"%>
<%@ page import="controller.FlowerController" %>
<jsp:useBean id="flowerCollection" class="flower.FlowerCollection" scope="application"/>
<jsp:useBean id="countryCollection" class="country.CountryCollection" scope="application"/>
<jsp:useBean id="typeFlowerCollection" class="flower.TypeFlowerCollection" scope="application"/>
<jsp:useBean id="connectDB" class="connectDB.ConnectDB" scope="session" />
<!DOCTYPE html>

<html>
<head>
    <title>Store Gun</title>
</head>
<%
    request.setCharacterEncoding("UTF-8");
%>
<body>
<center>
    <a href="index.jsp">На главную</a>
    <a href="country.jsp">Страны экспорта</a>
    <table border="1" cellpadding="5" cellspacing="0">
        <tr> <th> Название </th>  <th> Сорт  </th> <th>Страна экспорта</th>  <th>Цена</th> <th>  </th> <th>  </th> <th> Корзина </th></tr>
        <%
            for(Flower flower : flowerCollection.findAll()){
        %>
        <tr bgcolor="#deb887">
            <td> <%=flower.getName()%></td>
            <td> <%=flower.getTypeFlower().getTypeName()%> </td>
            <td> <%=flower.getCountry().getCountryName()%> </td>
            <td> <%=flower.getPrice()%> </td>
            <td>
                <form action="refactorFlower.jsp" method="post">
                    <input type="hidden" name="id" value="<%=flower.getId()%>">
                    <input type="submit" value="Редактировать">
                </form>
            </td>
            <td>
                <form action="deleteFlower.jsp" method="post">
                    <input type="hidden" name="id" value="<%=flower.getId()%>">
                    <input type="submit" value="Удалить">
                </form>
            </td>
            <td>
                <form action="#" method="post">
                    <input type="submit" value="Добавить в корзину">
                </form>
            </td>
            <%
                }
            %>
        </tr>
        <tr>
            <td colspan="5">
                <form action="refactorFlower.jsp" method="post">
                    <input type="hidden" name="id" value="-1">
                    <input type="submit" value="Добавить">
                </form>
            </td>
        </tr>
    </table>
</center>
</body>
</html>
