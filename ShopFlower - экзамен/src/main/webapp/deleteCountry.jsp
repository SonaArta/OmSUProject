<%--
  Created by IntelliJ IDEA.
  User: Хитринцева Валерия
  Date: 15.01.2022
  Time: 13:56
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" import="flower.*, country.*"%>
<%@ page import="controller.FlowerController" %>
<jsp:useBean id="flowerCollection" class="flower.FlowerCollection" scope="application"/>
<jsp:useBean id="countryCollection" class="country.CountryCollection" scope="application"/>
<jsp:useBean id="typeFlowerCollection" class="flower.TypeFlowerCollection" scope="application"/>
<jsp:useBean id="connectDB" class="connectDB.ConnectDB" scope="session" />

<html>
<head>
    <title>Удаление страны</title>
</head>
<body>
<%
    String id_ = request.getParameter("id");
    Long id = null;
    try{
        id = Long.parseLong(id_);
    }catch (Exception e){
        out.println("<font color=\"ivory\"> error parsing Long value (id) == "+id_+"</font>");
        return;
    }
    Country country = null;
    if(id >= 0L){
        country = countryCollection.get(id);
        countryCollection.remove(country);
        FlowerController.removeCountryFromDB(connectDB,id);
    }
%>
<center>
    <h2>УДАЛЕНИЕ ПОЛУЧИЛОСЬ!</h2>
    <form action="country.jsp" method="post">
        <input type="submit" value="Вернуться назад">
    </form>
</center>
</body>
</html>
