<%@ page contentType="text/html;charset=UTF-8" language="java" import="laureats.laureats.*,laureats.laureats.controller.*" %>
<%@ page import="laureats.laureats.country.Country" %>
<jsp:useBean id="countryCollection" class="laureats.laureats.country.CountryCollection" scope="application"/>
<jsp:useBean id="connectDB" class="laureats.laureats.connectDB.ConnectDB" scope="session"/>
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
        awardsController.removeCountryFromDB(connectDB,id);
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
