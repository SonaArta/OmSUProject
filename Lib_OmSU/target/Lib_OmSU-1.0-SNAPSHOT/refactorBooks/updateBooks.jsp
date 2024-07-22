<%--
  Created by IntelliJ IDEA.
  User: Хитринцева Валерия
  Date: 23.10.2021
  Time: 8:23
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" import="omsu.lib_omsu.users.*, omsu.lib_omsu.controller.BookController " %>
<%@ page import="omsu.lib_omsu.books.Book" %>
<%@ page import="omsu.lib_omsu.author.Author" %>
<%@ page import="omsu.lib_omsu.label.Label" %>
<%@ page import="omsu.lib_omsu.author.AuthorCollection" %>
<%@ page import="omsu.lib_omsu.label.LabelCollection" %>
<jsp:useBean id="bookCollection" class="omsu.lib_omsu.books.BookCollection" scope="application"/>
<jsp:useBean id="authorCollection" class="omsu.lib_omsu.author.AuthorCollection" scope="application"/>
<jsp:useBean id="labelCollection" class="omsu.lib_omsu.label.LabelCollection" scope="application"/>
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
    <font color = "ffdea"><h2>Смотри, оно работает!</h2></font>
</center>
<%
    String id_ = request.getParameter("id");
    Long id = null;
    String isChanged = request.getParameter("ischanged");
    try {
        id = Long.parseLong(id_);
    }catch(Exception e){
        out.println("<font color=\"ivory\">error parsing Long value (id) =="+id_+"</font>");
        return;
    }
    LabelCollection labelColl = new LabelCollection();
    AuthorCollection authorColl = new AuthorCollection();
    if(isChanged != null && isChanged.equals("true")){
        try {
            BookController.changeBookFromDB(request, connectDB, id, bookCollection,authorCollection,labelCollection);
        }catch(Exception e){
            out.println("<font color=\"ivory\">error in changeReaderOrLibFromDB <P>"+e.getMessage()+"</font>");
            return;
        }
%>

<jsp:forward page="../books/books.jsp" />
<%
    }else {
        Book book = BookController.createOrUpdateBookFromHtml(request, id, bookCollection);
%>
<center>
    <form action="updateBooks.jsp" method = "POST">
        <input type="hidden" name="id" value="<%=id%>">
        <input type="hidden" name="ischanged" value="true">
        <table border ="3" cellpadding="7">
            <tr>
                <td align="center" bgcolor=#ffc0cb> Название </td>
                <td> <input type="text" name="name" value="<%=book.getName()%>"></td>
            </tr>
            <tr>
                <td align="center" bgcolor="gray"> ISBN </td>
                <td> <input type="text" name="isbn" value="<%=book.getIsbn()%>"></td>
            </tr>
            <tr>
                <td align="center" bgcolor="gray"> Автор </td>
                <td>
                    <select size="5" id="authorCollection" name="authorCollection" multiple="multiple">
                        <%
                            for(Author a : authorCollection.findAll()){%>
                        <option selected value="<%=a.getId()%>"> <%=a.getName()%></option>
                        <%
                            }
                        %>
                    </select>
                </td>
            </tr>

            <tr>
                <td align="center" bgcolor="gray"> Издательство </td>
                <td>
                    <select size="5" id="labelCollection" name="labelCollection" multiple="multiple">
                        <%
                            for(Label l : labelCollection.findAll()){%>
                        <option selected value="<%=l.getId()%>"> <%=l.getName()%></option>
                        <%
                            }%>
                    </select>
                </td>
            </tr>
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
