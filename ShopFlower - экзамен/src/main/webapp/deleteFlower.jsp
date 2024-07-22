<%--
  Created by IntelliJ IDEA.
  User: Хитринцева Валерия
  Date: 15.01.2022
  Time: 14:09
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
    <title>Удаление ЦВЕТКА</title>
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
    Flower flower = null;
    if(id >= 0L){
        flower = flowerCollection.get(id);
        flowerCollection.remove(flower);
        FlowerController.removeFlowerFromDB(connectDB,id);
    }
%>
<center>
    <h2>УДАЛЕНИЕ ПОЛУЧИЛОСЬ!</h2>
    <form action="flower.jsp" method="post">
        <input type="submit" value="Вернуться назад">
    </form>
</center>
</body>
</html>
