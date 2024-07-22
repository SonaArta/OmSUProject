
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" import="laureats.laureats.*" %>
<%@ page import="laureats.laureats.controller.AwardsController" %>
<%@ page import="laureats.laureats.awards.Awards" %>
<jsp:useBean id="gunCollection" class="laureats.laureats.awards.AwardsCollection" scope="application"/>
<jsp:useBean id="fieldCollection" class="laureats.laureats.fields.FieldCollection" scope="application"/>
<jsp:useBean id="connectDB" class="laureats.laureats.connectDB.ConnectDB" scope="session" />

<html>
<head>
    <title>Store Gun</title>
</head>

<%
    request.setCharacterEncoding("UTF-8");
%>

<body>


<center>
    <table border="1" cellpadding="5" cellspacing="0">
        <tr> <th> Награда - Год</th> <th> Область </th> <th> Лауреаты </th>  <th> </th> <th> </th> </tr>
        <%
            for(Awards award: awardCollection.findAll()){
        %>
        <tr bgcolor="#deb887">

            <td> <%= award.getYear() %></td>
            <td> <%= award.getField().getFieldName()%></td>
            <td>
                <%
                    for(Person p: personColletion.findAll()){
                %>
                <% p.getName()%> <br>
                <%}%>
            </td>


            <td>
                <form action="refactorAwards.jsp" method="post">
                    <input type="hidden" name="id" value="<%=award.getId()%>">
                    <input type="submit" value="Редактировать">
                </form>
            </td>
            <td>
                <form action="#" method="post">
                    <input type="hidden" name="id" value="<%=award.getId()%>">
                    <input type="submit" value="Удалить">
                </form>
            </td>
            <td>
                <form action="#" method="post">
                    <input type="submit" value="Добавить в корзину">
                </form>
            </td>
            <% }%>
        </tr>
        <tr>
            <td colspan="5">
                <form action="refactorAwards" method="post">
                    <input type="hidden" name="id" value="-1">
                    <input type="submit" value="Добавить">
                </form>
            </td>
        </tr>
    </table>
</center>
</body>
</html>
