<%@ page import="omsu.lib_omsu.label.Label" %><%--
  Created by IntelliJ IDEA.
  User: PanDa_WinZ
  Date: 30.10.2021
  Time: 9:50
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8" import="java.util.*, omsu.lib_omsu.controller.BookController" %>
<jsp:useBean id="labelCollection" class="omsu.lib_omsu.label.LabelCollection" scope="application" />
<jsp:useBean id="connectDB" class="omsu.lib_omsu.connectDB.ConnectDB" scope="session" />
<!DOCTYPE html>
<html>
<head>
    <title>Издательство</title>
</head>
<jsp:include page="../head/head.jsp"/>
<body>
<%
    if(connectDB.getCurrentUser().getLogin()==null || connectDB.getCurrentUser().getLogin().isEmpty())
    {
%>
<jsp:forward page="../login.jsp"/>
<%
    }
    System.out.println(labelCollection.getLabelValues());
    if (labelCollection.getLabelValues().isEmpty()) {
        labelCollection.setLabelCollection(BookController.loadLabelFromDB(connectDB));
    }
%>
<center>
    <table border="1" cellpadding="5" cellspacing="0">
        <tr><th>Название <th>    </th> <th>    </th></tr>
        <%
            for(Label l : labelCollection.findAll()){
        %>
        <tr bgcolor=#ffc0cb>
            <td align=center><%= l.getName() %></td>
            <td>
                <form action="../refactorBooks/updateLabel.jsp" method="POST">
                    <input type="hidden" name="id" value="<%=l.getId()%>"/>
                    <input type="submit" value="Редактировать"/>
                </form>
            </td>
            <td>
                <form action="../refactorBooks/delLabel.jsp" method="POST">
                    <input type="hidden" name="id" value="<%=l.getId()%>"/>
                    <input type="submit" value="Удалить"/>
                </form>
            </td>
        </tr>
        <%
            }
        %>
        <tr><td colspan="5">
            <form action="../refactorBooks/updateLabel.jsp" method="POST">
                <input type="hidden" name="id" value="-1"/>
                <input type="submit" value="Добавить Издательство"/>
            </form>
        </td></tr>
    </table>
</center>
</body>
</html>
