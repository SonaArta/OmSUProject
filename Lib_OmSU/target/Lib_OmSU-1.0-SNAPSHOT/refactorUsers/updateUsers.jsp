<%@ page contentType="text/html;charset=UTF-8" language="java" import="omsu.lib_omsu.users.*, omsu.lib_omsu.controller.UserController" %>
<jsp:useBean id="userCollection" class="omsu.lib_omsu.users.UserCollection" scope="application"/>
<jsp:useBean id="readerCollection" class="omsu.lib_omsu.users.ReaderCollection" scope="application"/>
<jsp:useBean id="librarianCollection" class="omsu.lib_omsu.users.LibrarianCollection" scope="application"/>
<jsp:useBean id="userStatusCollection" class="omsu.lib_omsu.users.UserStatusCollection" scope="application"/>
<jsp:useBean id="connectDB" class="omsu.lib_omsu.connectDB.ConnectDB" scope="session" />
<html>
<head>
    <title>Создание и редактирование</title>
</head>
<jsp:include page="../head/head.jsp"/>
<%
    if(!connectDB.getCurrentUser().getStatus().getStatus().equals("librarian")){
%>
<jsp:forward page="../head/rights.jsp" />
<%
    }
%>
<center>
    <font color="#ffdead"><h2> У нас всё работает!</h2></font>
</center>
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
            UserController.createOrUpdateReaderOrLibFromDB(request, connectDB, id, userStatusCollection, userCollection, readerCollection, librarianCollection);
        }catch(Exception e){
            out.println("<font color=\"ivory\">error in changeReaderOrLibFromDB <P>"+e.getMessage()+"</font>");
            return;
        }
%>

<jsp:forward page="../users/allUsers.jsp" />

<%
}else{
    //для показа формы редактирования
    User user = UserController.createOrUpdateReaderOrLibFromHtml(request, id, userStatusCollection, userCollection);
%>
<center>
    <form action="updateUsers.jsp" method="POST">
        <input type="hidden" name="id" value="<%=id%>">
        <input type="hidden" name="ischanged" value="true">
        <table border="3" cellpadding="7">
            <tr>
                <td align="center" bgcolor=#ffc0cb>ФИО </td>
                <td> <input type="text" name="name" value="<%=user.getName()%>"></td>
            </tr>
            <tr>
                <td align="center" bgcolor=#ffc0cb>Паспорт</td>
                <td><input type="text" name="passport" value="<%=user.getPassport()%>"></td>
            </tr>
            <tr>
                <td align="center" bgcolor=#ffc0cb>Номер телефона</td>
                <td><input type="text" name="phoneNumber" value="<%=user.getPhoneNumber()%>"></td>
            </tr>
            <tr>
                <td align="center" bgcolor=#ffc0cb><p>Логин</td>
                <td><input type="text" name="login" value="<%=user.getLogin()%>"></td>
            </tr>
            <tr>
                <td align="center" bgcolor=#ffc0cb>Пароль</td>
                <td><input type="password" name="password"></td>
            </tr>
            <tr>
                <td align="center" bgcolor=#ffc0cb>Статус</td>
                <td><input type="text" name="status" value="<%=user.getStatus().getStatus()%>" readonly></td>
            </tr>
            <%
                if(user.getStatus().getStatus().equals("reader")){
                    Reader r = (Reader) user;
            %>
            <tr>
                <td align="center" bgcolor=#ffc0cb>Номер ч/б</td>
                <td><input type="text" name="readerNumber" value="<%=r.getReaderNumber()%>"></td>
            </tr>
            <%
                }
                if(user.getStatus().getStatus().equals("librarian")){
                    Librarian l = (Librarian) user;
            %>
            <tr>
                <td align="center" bgcolor=#ffc0cb>Таб. номер</td>
                <td><input type="text" name="tabelNumber" value="<%=l.getTabelNumber()%>"></td>
            </tr>
            <%
                }
            %>
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