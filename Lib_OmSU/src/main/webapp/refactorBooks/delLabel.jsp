<%@ page contentType="text/html;charset=UTF-8" language="java" import="omsu.lib_omsu.users.*, omsu.lib_omsu.label.*" %>
<%@ page import="omsu.lib_omsu.controller.BookController" %>
<jsp:useBean id="labelCollection" class="omsu.lib_omsu.label.LabelCollection" scope="application"/>
<jsp:useBean id="connectDB" class="omsu.lib_omsu.connectDB.ConnectDB" scope="session" />

<html>
<head>
    <title>Удаление издательства</title>
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
    String type_ = request.getParameter("type");
    String id_ = request.getParameter("id");
    Long id = null;
    try{
        id = Long.parseLong(id_);
    }catch(Exception e){
        out.println("<font color=\"ivory\">error parsing Long value (id) =="+id_+"</font>");
        return;
    }
    Label label = null;
    if(id>=0L){
        label = labelCollection.get(id);
        labelCollection.remove(label);
        BookController.removeLabelFromDataBase(connectDB,id);
    }
%>
<center>
    <h2><style> .colortext{color: honeydew;} </style> <span class="colortext">
        Удаление прошло успешно!</span>
    </h2>
    <form action="../books/label.jsp" method="POST">
        <input type="submit" value="Вернуться к списку авторов"/>
    </form>
</center>
</body>
</html>

