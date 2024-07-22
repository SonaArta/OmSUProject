<%@ page contentType="text/html;charset=UTF-8" language="java" import="omsu.lib_omsu.users.*, omsu.lib_omsu.label.*" %><%@ page import="omsu.lib_omsu.author.Author" %>
<%@ page import="omsu.lib_omsu.author.AuthorCollection" %>
<%@ page import="omsu.lib_omsu.books.Book" %>
<%@ page import="omsu.lib_omsu.controller.BookController" %>
<jsp:useBean id="authorCollection" class="omsu.lib_omsu.author.AuthorCollection" scope="application" />
<jsp:useBean id="connectDB" class="omsu.lib_omsu.connectDB.ConnectDB" scope="session" />
<html>
<head>
  <title>Авторы</title>
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
                BookController.changeAuthorFromDB(request, connectDB, id, authorCollection);
            }catch(Exception e){
                out.println("<font color=\"ivory\">error in changeAuthorsFromDB <P>"+e.getMessage()+"</font>");
                return;
            }
%>
      <jsp:forward page="../books/authors.jsp" />
<%
      }else{
          Author author = BookController.createOrUpdateAuthorFromHtml(request, id, authorCollection);
%>
<center>
    <form action="updateAuthors.jsp" method="POST">
        <input type="hidden" name="id" value="<%=id%>">
        <input type="hidden" name="ischanged" value="true">
        <table border="3" cellpadding="7">
          <tr>
              <td align="center" bgcolor=#ffc0cb>Автор </td>
              <td> <input type="text" name="name" value="<%=author.getName()%>" size=100></td>
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