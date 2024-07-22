<%--
  Created by IntelliJ IDEA.
  User: PanDa_WinZ
  Date: 21.10.2021
  Time: 12:12
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" import="omsu.lib_omsu.users.*, omsu.lib_omsu.label.*" %>
<%@ page import="omsu.lib_omsu.controller.BookController" %>
<jsp:useBean id="labelCollection" class="omsu.lib_omsu.label.LabelCollection" scope="application"/>
<jsp:useBean id="connectDB" class="omsu.lib_omsu.connectDB.ConnectDB" scope="session" />
<html>
<head>
    <title>Издательство</title>
</head>
<jsp:include page="../head/head.jsp"/>
<%
    if(!connectDB.getCurrentUser().getStatus().getStatus().equals("librarian")){
%>
<jsp:forward page="../head/rights.jsp" />
<%
    }
%>
<body>
<%
    String id_ = request.getParameter("id");
    String isChanged = request.getParameter("ischanged");
    Long id = null;
    try{
        id = Long.parseLong(id_);
    }catch(Exception e){
        out.println("<font color=\"ivory\">error parsing Long value (id) =="+id_+"</font>");
        return;
    }

    if(isChanged != null && isChanged.equals("true")){
        try {
            BookController.changeLabelFromDB(request, connectDB, id, labelCollection);
        }catch(Exception e){
            out.println("<font color=\"ivory\">error in changeLabel <P>"+e.getMessage()+"</font>");
            return;
        }
%>
<jsp:forward page="../books/label.jsp" />
<%
    }else{
        Label label = BookController.createOrUpdateLabelFromHtml(request, id, labelCollection);
%>
<center>
    <form action="updateLabel.jsp" method="POST">
        <input type="hidden" name="id" value="<%=id%>">
        <input type="hidden" name="ischanged" value="true">
        <table border="3" cellpadding="7">
            <tr>
                <td align="center" bgcolor=#ffc0cb>Название </td>
                <td> <input type="text" name="name" value="<%=label.getName()%>" size="100"></td>
            </tr>
            <tr>
            <tr>
                <td colspan=2 align="center"><input type="submit" value="ок"/> </td>
            </tr>
        </table>
    </form>
</center>
</body>
</html>
<%
    }
%>