<%--
  Created by IntelliJ IDEA.
  User: Хитринцева Валерия
  Date: 15.01.2022
  Time: 14:07
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
            FlowerController.changeFlowerFromDB(request, connectDB, id,  flowerCollection);
        } catch (Exception exception){
            out.println("<font color=\"ivory\"> error in changeGunFromDB <P>"+exception.getMessage()+"</font>");
            return;
        }
%>
<jsp:forward page="flower.jsp"/>

<%
}else {
    Flower  flower =  FlowerController.createOrUpdateFlowerFromHTML(request, id,  flowerCollection);
%>
<center>
    <form action="refactorFlower.jsp" method="post">
        <input type="hidden" name="id" value="<%=id%>">
        <input type="hidden" name="ischanged" value="true">
        <table border="3" cellpadding="7">
            <tr>
                <td align="center"> Наименование </td>
                <td> <input type="text" name="name" value="<%= flower.getName()%>" size="100"></td>
            </tr>
            <tr>
                <td align="center">Сорт</td>
                <td>
                    <select size="1" id="typeName" name="typeName">
                        <%
                            for(TypeFlower typeFlower : typeFlowerCollection.findAll()){
                        %>
                        <option selected value="<%=typeFlower.getTypeName()%>"> <%=typeFlower.getTypeName()%> </option>
                        <%
                            }
                        %>
                    </select>
                </td>
            </tr>
            <tr>
                <td align="center">Страна экспорта</td>
                <td>
                    <select size="1" id="countryName" name="countryName">
                        <%
                            for(Country country : countryCollection.findAll()){
                        %>
                        <option selected value="<%=country.getCountryName()%>"> <%=country.getCountryName()%> </option>
                        <%
                            }
                        %>
                    </select>
                </td>
            </tr>
            <tr>
                <td align="center">  Цена  </td>
                <td> <input type="text" name="price" value="<%=flower.getPrice()%>" size="100"></td>
            </tr>
                <td colspan="2" align="center">
                    <input type="submit" value="Сохранить изменения"/>
                    <a href="flower.jsp">Список цветов</a>
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