<%--
  Created by IntelliJ IDEA.
  User: denb2
  Date: 10.12.2021
  Time: 21:51
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" import="java.util.*, omsu.lib_omsu.books.*" %>
<%@ page import="com.sun.source.tree.LiteralTree" %>
<%@ page import="omsu.lib_omsu.author.*" %>
<%@ page import="omsu.lib_omsu.label.*" %>
<%@ page import="omsu.lib_omsu.controller.BookController" %>
<jsp:useBean id="bookCollection" class="omsu.lib_omsu.books.BookCollection" scope="application" />
<jsp:useBean id="authorCollection" class="omsu.lib_omsu.author.AuthorCollection" scope="application" />
<jsp:useBean id="labelCollection" class="omsu.lib_omsu.label.LabelCollection" scope="application" />
<jsp:useBean id="connectDB" class="omsu.lib_omsu.connectDB.ConnectDB" scope="session" />
<!DOCTYPE html>
<html>
<head>
    <title> Книги </title>
</head>
<jsp:include page="../head/head.jsp"/>
    <%
    if(connectDB.getCurrentUser().getLogin()==null || connectDB.getCurrentUser().getLogin().isEmpty())
    {
%>
<jsp:forward page="../login.jsp"/>
    <%
    }

    if(request.getParameter("changed") != null){
        String id_ = request.getParameter("id");
        Long id = Long.parseLong(id_);

        String name = request.getParameter("name");
        String isbn = request.getParameter("isbn");
        //Long isbn = Long.parseLong(isbn_);

        AuthorCollection authors = new AuthorCollection();
        LabelCollection labels = new LabelCollection();

        String[] a_ = request.getParameterValues("author");
        for(String a: a_)
        {
            Long author_id = Long.parseLong(a);
            Author author = authorCollection.get(author_id);
            authors.put(author);
        }

        String l = request.getParameter("label");
        Long l_id = Long.parseLong(l);
        Label label = labelCollection.get(l_id);
        labels.put(label);

        Book book = new Book(name, isbn, authors, labels);
        bookCollection.put(book);
        //BookController.saveBookFromDataBase(connectDB, book, false);
    %>
<jsp:forward page="../books/books.jsp"/>
<%
    }
    else{

    Long id = 0L;
%>

<center>
    <form action="createBook.jsp" method = "POST">
        <input type="hidden" name="changed" value="<%=1L%>">
        <input type="hidden" name="id" value="<%=id%>">
        <table border ="3" cellpadding="7">
            <tr>
                <td align="center" bgcolor=#ffc0cb> Название </td>
                <%--<td> <input type="text" name="name" value="<%=book.getName()%>"></td>--%>
                <td> <input type="text" name="name"></td>
            </tr>
            <tr>
                <td align="center" bgcolor="gray"> ISBN </td>
                <%--<td> <input type="text" name="isbn" value="<%=book.getIsbn()%>"></td>--%>
                <td> <input type="text" name="isbn"></td>
            </tr>
            <tr>
                <td align="center" bgcolor="gray"> Автор </td>
                <td>
                    <select multiple id="author" name="author">
                        <%
                            for(Author a: authorCollection.findAll()){ %>
                        <option selected value="<%=a.getId()%>"> <%=a.getName()%></option>
                        <%}%>
                    </select>
                </td>
            </tr>

            <tr>
                <td align="center" bgcolor="gray"> Издательство </td>
                <td>
                    <select name="label">
                        <% for(Label l: labelCollection.findAll()){ %>
                        <option selected value="<%=l.getId()%>"> <%=l.getName()%></option>
                        <%}%>
                    </select>
                </td>
            </tr>

            <tr>
                <td colspan=2 align="center"><input type="submit" value="ок"/> </td>
            </tr>
        </table>
    </form>
</center>
<%
    }
%>
</body>
</html>