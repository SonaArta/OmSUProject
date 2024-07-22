<%@ page import="java.util.Date" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<jsp:useBean id="counterBean" class="omsu.lib_omsu.counter.CounterBean" scope="application" />
<html>
<head>
    <title>Title</title>
</head>
<body>
<p>
<p align-="center">counter==<%= counterBean.getCounter()%>
<p>
        <%
Date d = (Date)session.getAttribute("FIRSTDATE");
out.println("getSession(FIRSTDATE)=="+d);
%>
</body>
</html>
