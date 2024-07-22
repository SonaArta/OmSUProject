<%@ page contentType="text/html; charset=UTF-8" language="java" import="omsu.lib_omsu.users.User, omsu.lib_omsu.controller.UserController" %>
<%@ page import="java.sql.SQLException" %>
<jsp:useBean id="userCollection" class="omsu.lib_omsu.users.UserCollection" scope="application"/>
<jsp:useBean id="librarianCollection" class="omsu.lib_omsu.users.LibrarianCollection" scope="application"/>
<jsp:useBean id="readerCollection" class="omsu.lib_omsu.users.ReaderCollection" scope="application"/>
<jsp:useBean id="userStatusCollection" class="omsu.lib_omsu.users.UserStatusCollection" scope="application"/>
<jsp:useBean id="connectDB" class="omsu.lib_omsu.connectDB.ConnectDB" scope="session"/>
<html>
<head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Авторизация</title>
    <meta name="keywords" content="css3, login, form, custom, input, submit, button, html5, placeholder" />
    <meta name="author" content="Codrops" />
    <link rel="stylesheet" type="text/css" href="css/style.css" />
    <script src="js/modernizr.custom.63321.js"></script>
    <!--[if lte IE 7]>
    <style>.main{display:none;}
        .support-note .note-ie{display:block;}</style><![endif]-->
    <style>
        body {
            background: #1f2124 url(images/wood_pattern.jpg);
        }
    </style>
</head>
<style>
    TABLE {
        background: maroon; /* Цвет фона таблицы */
        width: 300px; /* Ширина таблицы */
        border: 1px solid black; /* Рамка вокруг таблицы */
        margin: auto;
    }
    TD{
        padding: 3px; /* Поля вокруг содержимого ячеек */
    }
    TH {
        text-align: center; /* Выравнивание по левому краю */
        background: black; /* Цвет фона */
        color: pink; /* Цвет текста */
    }
     .round {
         border-radius: 100px; /* Радиус скругления */
         border: 1px solid #ffb347; /* Параметры рамки */
         box-shadow: 0 0 7px #666; /* Параметры тени */
     }
</style>
</style>
<body bgcolor="#ffb6c1" >
<center>
<%
    System.out.println(userCollection.getUserValues());
    if (userCollection.getUserValues().isEmpty()) {
        userStatusCollection.setUserStatusCollection(UserController.loadUserStatusFromDB(connectDB));
        userCollection.setUserCollection(UserController.loadUserCollFromDB(connectDB,userStatusCollection));

        //попытка разделения
        for(User user : userCollection.findAll()) {
            if (user.getStatus().getId().equals(userStatusCollection.idLibrarianStatus)) {
                librarianCollection.setLibCollection(UserController.loadLibCollFromDB(connectDB, userCollection));
            }
            if (user.getStatus().getId().equals(userStatusCollection.idReaderStatus)) {
                readerCollection.setReaderCollection(UserController.loadReaderCollFromDB(connectDB, userCollection));
            }
        }
    }
    System.out.println(userCollection.getUserValues());
    System.out.println(librarianCollection.getLibValues());
    System.out.println(readerCollection.getReaderValues());

        Long id = -1L;
        String login = request.getParameter("login");
        String password = request.getParameter("password");

        if(login != null && password != null){
            User user = userCollection.findUserByLoginPassword(login,password);

            if (user != null){
                connectDB.setCurrentUser(user); //Используем везде
                System.err.println("user=" + user.getName());
%>
                <jsp:forward page="index.jsp" />
<%
            }else{
%>
            <form class="form-2" action="login.jsp">
                <h1><span class="log-in">
                    Пользователь не найден, возможно неверно введёе логин или пароль
                </span></h1>
                <center>
                    <p class="clearfix">
                    <input type="submit" name="submit" value="Вернутся назад">
                    <a href="/Lib/signUp.jsp" class="log-twitter">Регистрация
                        <input type="hidden" name="id" value="<%=id%>">
                    </a>
                    </p>
                </center>
            </form>
<%
            }
        }else{
%>
    <div class="container">
        <img src="images/nux_logo1_3.gif" width="300" height="300" alt="logo" class="round">
        <h1><style> .colortext{color: #27292c} </style> <span class="colortext">
        </span>
        </h1>
        <section class="main">
            <form class="form-2">
                <h1><span class="log-in">Войти</span>  <span class="sign-up">или зарегистрироваться</span></h1>
                <p class="float">
                    <label for="login"><i class="icon-user"></i>Логин</label>
                    <input type="text" name="login" placeholder="Логин">
                </p>
                <p class="float">
                    <label for="password"><i class="icon-lock"></i>Пароль</label>
                    <input type="password" name="password" placeholder="Пароль" class="showpassword">
                </p>
                <p class="clearfix">
                    <input type="submit" name="submit" value="Вход">
                    <a href="/Lib/signUp.jsp" class="log-twitter">Регистрация
                        <input type="hidden" name="id" value="<%=id%>">
                    </a>
                </p>
            </form>​​
        </section>
    </div>
    <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.8.2/jquery.min.js"></script>
    <script type="text/javascript">
        $(function(){
            $(".showpassword").each(function(index,input) {
                var $input = $(input);
                $("<p class='opt'/>").append(
                    $("<input type='checkbox' class='showpasswordcheckbox' id='showPassword' />").click(function() {
                        var change = $(this).is(":checked") ? "text" : "password";
                        var rep = $("<input placeholder='Пароль' type='" + change + "' />")
                            .attr("id", $input.attr("id"))
                            .attr("name", $input.attr("name"))
                            .attr('class', $input.attr('class'))
                            .val($input.val())
                            .insertBefore($input);
                        $input.remove();
                        $input = rep;
                    })
                ).append($("<label for='showPassword'/>").text("Показать пароль")).insertAfter($input.parent());
            });

            $('#showPassword').click(function(){
                if($("#showPassword").is(":checked")) {
                    $('.icon-lock').addClass('icon-unlock');
                    $('.icon-unlock').removeClass('icon-lock');
                } else {
                    $('.icon-unlock').addClass('icon-lock');
                    $('.icon-lock').removeClass('icon-unlock');
                }
            });
        });
    </script>
</center>
</body>
</html>
<%
        }
%>