<%--
  Created by IntelliJ IDEA.
  User: denb2
  Date: 20.11.2021
  Time: 1:26
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" import="omsu.lib_omsu.users.*, omsu.lib_omsu.controller.OrderController" %>
<%@ page import="omsu.lib_omsu.order.Order" %>
<jsp:useBean id="OrderCollection" class="omsu.lib_omsu.order.OrderCollection" scope="application"/>
<jsp:useBean id="order" class="omsu.lib_omsu.order.Order" scope="application"/>
<jsp:useBean id="UserCollection" class="omsu.lib_omsu.users.UserCollection" scope="application"/>
<jsp:useBean id="connectDB" class="omsu.lib_omsu.connectDB.ConnectDB" scope="session" />
<html>
<head>
    <title>Создание и редактирование</title>
</head>
<jsp:include page="../head/head.jsp"/>
<%--<jsp:include page="wayBar.jsp"/>--%>
<center>
    <font color="#ffdead"><h2>Бланк</h2></font>
</center>
<%
    //OrderController controller = new OrderController();
    UserCollection userCollection = new UserCollection();

    String type_ = request.getParameter("type");
    String id_ = request.getParameter("id");
    //System.out.println("id_="+id_);
    Long id = null;
    try{
        id = Long.parseLong(id_);
        //System.out.println("id="+id);
    }catch(Exception e){
        out.println("<font color=\"ivory\">error parsing Long value (id) =="+id_+"</font>");
        return;
    }

    //для показа формы редактирования
    //System.out.println("edit form id="+id);
    Order order = new Order();
    order.setReader((Reader) connectDB.getCurrentUser());
    order.setStatus("Ne vidana");

%>
<center>
    <form action="updateLibrarians.jsp" method="POST">

        <input type="hidden" name="id" value="<%=id%>">

        <table border="3" cellpadding="7">
            <tr>
                <td align="center" bgcolor=#ffc0cb>Книга </td>
                <td> <input type="text" name="name" value="" size="100"></td>
            </tr>
            <tr>
                <td align="center" bgcolor=#ffc0cb>Паспорт</td>
                <td><input type="text" name="passport" value="<%=user.getPassport()%>" size="100"></td>
            </tr>
            <tr>
                <td align="center" bgcolor=#ffc0cb>Номер телефона</td>
                <td><input type="text" name="phoneNumber" value="<%=user.getPhoneNumber()%>" size="100"></td>
            </tr>
            <tr>
                <td align="center" bgcolor=#ffc0cb><p>Логин</td>
                <td><input type="text" name="login" value="<%=user.getLogin()%>" size="100"></td>
            </tr>
            <tr>
                <td align="center" bgcolor=#ffc0cb>Пароль</td>
                <td><input type="password" name="password"></td>
            </tr>
            <tr>
                <td align="center" bgcolor=#ffc0cb>Статус</td>
                <td><input type="text" name="status" value="<%=user.getStatus()%>" readonly></td>
            </tr>

            <%
                if(user.getStatus().equals("librarian")){
                    Librarian l = (Librarian) user;
            %>
            <tr>
                <td align="center" bgcolor=#ffc0cb>Таб. номер</td>
                <td><input type="text" name="tabelNumber" value="<%=l.getTabelNumber()%>" size="100"></td>
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

