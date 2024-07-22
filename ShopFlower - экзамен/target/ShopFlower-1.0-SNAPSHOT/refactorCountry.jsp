<%--
  Created by IntelliJ IDEA.
  User: Хитринцева Валерия
  Date: 15.01.2022
  Time: 13:55
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
    <title>Добавление/Редактирование</title>
</head>
<%
    request.setCharacterEncoding("UTF-8");
%>
<body>
<%
    String id_ = request.getParameter("id");
    String isChanged = request.getParameter("ischanged");
    Long id = null;
    try{
        id = Long.parseLong(id_);
    }catch (Exception exception){
        out.println("<font color=\"ivory\"> error parsing Long value (id) == "+id_+"</font>");
        return;
    }

    if(isChanged != null && isChanged.equals("true")){
        try{
            FlowerController.changeCountryFromDB(request, connectDB, id, countryCollection);
        } catch (Exception exception){
            out.println("<font color=\"ivory\"> error in changeFlowerFromDB <P>"+exception.getMessage()+"</font>");
            return;
        }
%>
<jsp:forward page="country.jsp"/>

<%
}else {
    Country country = FlowerController.createOrUpdateCountryFromHTML(request, id, countryCollection);
%>
<center>
    <form action="refactorCountry.jsp" method="post">
        <input type="hidden" name="id" value="<%=id%>">
        <input type="hidden" name="ischanged" value="true">
        <table border="3" cellpadding="7">
            <tr>
                <td align="center"> Наименование </td>
                <td> <input type="text" name="name" value="<%=country.getCountryName()%>" size="100"></td>
            </tr>
            <tr>
                <td colspan="2" align="center">
                    <input type="submit" value="Сохранить изменения"/>
                    <a href="country.jsp">Страны</a>
                </td>
            </tr>
        </table>
    </form>
</center>
</body>
</html>
<%
    }
%>