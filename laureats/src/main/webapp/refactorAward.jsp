<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" import="java.util.*, com.cum.cum.gun.*, com.cum.cum.country.*, com.cum.cum.controller.*" %>
<jsp:useBean id="countryCollection" class="com.cum.cum.country.CountryCollection" scope="application" />
<jsp:useBean id="typeGunCollection" class="com.cum.cum.gun.TypeGunCollection" scope="application" />
<jsp:useBean id="gunCollection" class="com.cum.cum.gun.GunCollection" scope="application" />
<jsp:useBean id="connectDB" class="com.cum.cum.connectDB.ConnectDB" scope="session" />


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
           AwardController.changeGunFromDB(request, connectDB, id, gunCollection);
        } catch (Exception exception){
            out.println("<font color=\"ivory\"> error in changeGunFromDB <P>"+exception.getMessage()+"</font>");
            return;
        }
%>
<jsp:forward page="gun.jsp"/>

<%
}else {
    Gun gun = GunController.createOrUpdateGunFromHTML(request, id, gunCollection);
%>
<center>
    <form action="refactorGun.jsp" method="post">
        <input type="hidden" name="id" value="<%=id%>">
        <input type="hidden" name="ischanged" value="true">
        <table border="3" cellpadding="7">
            <tr>
                <td align="center"> Наименование </td>
                <td> <input type="text" name="name" value="<%=gun.getName()%>" size="100"></td>
            </tr>
            <tr>
                <td align="center">Тип оружия</td>
                <td>
                    <select size="2" id="typeName" name="typeName" multiple="multiple">
                        <%
                            for(TypeGun typeGun : typeGunCollection.findAll()){
                        %>
                        <option selected value="<%=typeGun.getTypeName()%>"> <%=typeGun.getTypeName()%> </option>
                        <%
                            }
                        %>
                    </select>
                </td>
            </tr>
            <tr>
                <td align="center">Страна производитель</td>
                <td>
                    <select size="2" id="countryName" name="countryName" multiple="multiple">
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
                <td colspan="2" align="center">
                    <input type="submit" value="Сохранить изменения"/>
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