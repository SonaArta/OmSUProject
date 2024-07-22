<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" import="flower.*, country.*"%>
<%@ page import="controller.FlowerController" %>
<jsp:useBean id="flowerCollection" class="flower.FlowerCollection" scope="application"/>
<jsp:useBean id="countryCollection" class="country.CountryCollection" scope="application"/>
<jsp:useBean id="typeFlowerCollection" class="flower.TypeFlowerCollection" scope="application"/>
<jsp:useBean id="connectDB" class="connectDB.ConnectDB" scope="session" />

<!DOCTYPE html>
<html>
<head>
    <title>Shop Flower</title>
</head>
<jsp:include page="header.jsp"/>
<body>
<h1><%= "Hello World!" %>
</h1>
<br/>
<%
    System.out.println(flowerCollection.getFlowerValues());
    if(flowerCollection.getFlowerValues().isEmpty()){
        countryCollection.setCountryCollection(FlowerController.loadCountryFromDB(connectDB));
        typeFlowerCollection.setTypeFlowerCollection(FlowerController.loadTypeFlowerFromDB(connectDB));
        flowerCollection.setFlowerCollection(FlowerController.loadFlowerFromDB(connectDB,typeFlowerCollection,countryCollection));
    }
    System.out.println(flowerCollection.getFlowerValues());
%>
<a href="hello-servlet">Hello Servlet</a>
<a href="flower.jsp">Список цветов</a>
<a href="country.jsp">Страны экспорта</a>
</body>
</html>