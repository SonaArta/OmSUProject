<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" import="java.util.*, laureats.laureats.awards.*, laureats.laureats.country.*, laureats.laureats.controller.*" %>
<jsp:useBean id="countryCollection" class="laureats.laureats.country.CountryCollection" scope="application" />
<jsp:useBean id="gunCollection" class="laureats.laureats.awards.AwardsCollection" scope="application" />
<jsp:useBean id="connectDB" class="laureats.laureats.connectDB.ConnectDB" scope="session" />


<html>
<head>
    <title>Добавление/Редактирование</title>
</head>
<body>

<%
    request.setCharacterEncoding("UTF-8");
%>

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
           AwardsController.changeCountryFromDB(request, connectDB, id, countryCollection);
        } catch (Exception exception){
            out.println("<font color=\"ivory\"> error in changeCountryFromDB <P>"+exception.getMessage()+"</font>");
            return;
        }
%>
<jsp:forward page="country.jsp"/>

<%
}else {
    Country country = AwardsController.createOrUpdateCountryFromHTML(request, id, countryCollection);
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