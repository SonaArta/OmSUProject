package omsu.lib_omsu.controller;

import omsu.lib_omsu.connectDB.ConnectDB;
import omsu.lib_omsu.users.*;

import java.sql.*;
import java.util.Map;
import java.util.LinkedHashMap;

import javax.servlet.http.HttpServletRequest;

public class UserController {

    public UserController() {}
    /***************Full_UserStatus**********/
    public static Map<Long, UserStatus> loadUserStatusFromDB(ConnectDB connectDB) {
        Map<Long, UserStatus> userStatusFromDB = new LinkedHashMap<>();
        try (Connection connection = connectDB.getConnection()){
            try (PreparedStatement statement = connection.prepareStatement("SELECT id, status FROM ACHUBAROVA.USER_STATUS order by status");
                 ResultSet resultSet = statement.executeQuery()) {
                while (resultSet.next()) {
                    UserStatus userStatus = new UserStatus();
                    userStatus.setId(resultSet.getLong(1));
                    userStatus.setStatus(resultSet.getString(2));
                    userStatusFromDB.put(userStatus.getId(), userStatus);
                }
            } catch (SQLException sqlException) {
                System.out.println("userController loadUserStatusFromDB"+ sqlException.getMessage());
            }finally {
                connectDB.closeConnection();
            }

        }catch (SQLException sqlException){
            System.out.println("Cannot create connection, because "+ sqlException.getMessage());
        }

        System.out.println("DB" + userStatusFromDB.values());
        return userStatusFromDB;
    }
    /****************************************/
    /***************Full_User***************/
    public static void createOrUpdateReaderOrLibFromDB(HttpServletRequest request, ConnectDB connectDB, Long id , UserStatusCollection userStatusCollection,
                                                       UserCollection userCollection, ReaderCollection readerCollection, LibrarianCollection librarianCollection) {
        String name = request.getParameter("name");
        String login = request.getParameter("login");
        String password = request.getParameter("password");
        String passport = request.getParameter("passport");
        String phoneNumber = request.getParameter("phoneNumber");
        String readerNumber = request.getParameter("readerNumber");
        String tabelNumber = request.getParameter("tabelNumber");

        String status_ = request.getParameter("status");
        UserStatus userStatus = null;
        Reader reader = null;
        Librarian lib = null;

        if (name != null && passport != null && phoneNumber != null && login != null && password != null && status_ != null) {
            //вызов для редактирования пользака
            if (status_.equals("reader")) {
                userStatus = userStatusCollection.get(UserStatusCollection.idReaderStatus);
                if (id < 0L) {
                    reader = new Reader(name, passport, phoneNumber, login, password,  readerNumber, userStatus, null);
                    Long newId = saveUserFromDataBase(connectDB, reader);
                    reader.setId(newId);
                    userCollection.put(reader);
                    readerCollection.put(reader);
                } else {
                    User u = userCollection.get(id);
                    reader = (Reader) u;
                    reader.setName(name);
                    reader.setPassport(passport);
                    reader.setPhoneNumber(phoneNumber);
                    reader.setLogin(login);
                    reader.setPassword(password);
                    reader.setReaderNumber(readerNumber);
                    readerCollection.put(reader);
                    saveUserFromDataBase(connectDB, reader);
                }
            }
            if (status_.equals("librarian")) {
                userStatus = userStatusCollection.get(UserStatusCollection.idLibrarianStatus);
                if (id < 0L) {
                    lib = new Librarian(name, passport, phoneNumber, login, password, userStatus, tabelNumber);
                    Long newId = saveUserFromDataBase(connectDB, lib);
                    lib.setId(newId);
                    userCollection.put(lib);
                    librarianCollection.put(lib);
                } else {
                    User u = userCollection.get(id);
                    lib = (Librarian) u;
                    lib.setName(name);
                    lib.setPassport(passport);
                    lib.setPhoneNumber(phoneNumber);
                    lib.setLogin(login);
                    lib.setPassword(password);
                    lib.setTabelNumber(tabelNumber);
                    librarianCollection.put(lib);
                    saveUserFromDataBase(connectDB, lib);
                }
            }
        }
        System.err.println(lib==null?reader:lib);
    }
    public static User createOrUpdateReaderOrLibFromHtml(HttpServletRequest request, Long id, UserStatusCollection userStatusCollection, UserCollection userCollection) {
        String type_ = request.getParameter("type");
        User user = null;
        if (id >= 0L) {
            user = userCollection.get(id);
        } else { //add
            if (type_ != null) {
                if (type_.equals("reader")) {
                    user = new Reader();
                    user.setStatus(userStatusCollection.get(UserStatusCollection.idReaderStatus));
                } else {
                    user = new Librarian();
                    user.setStatus(userStatusCollection.get(UserStatusCollection.idLibrarianStatus));
                }
            }
        }
        return user;
    }
    /**************************************/

    /****************Full_load_all*****************/
    public static Map<Long, User> loadUserCollFromDB(ConnectDB connectDB, UserStatusCollection userStatusCollection){
        Map<Long, User> userCollFromDataBase = new LinkedHashMap<>();
        try (Connection connection = connectDB.getConnection()){
            try (PreparedStatement statement = connection.prepareStatement("SELECT id, passport, phone_number, login, password, name, id_status FROM ACHUBAROVA.USERS order by name");
                 ResultSet resultSet = statement.executeQuery()) {
                while (resultSet.next()) {
                    User user = new User();
                    user.setId(resultSet.getLong("id"));
                    user.setName(resultSet.getString("name")); //Я так понимаю номер колонки, но база чет немного шалит
                    user.setPassport(resultSet.getString("passport"));
                    user.setPhoneNumber(resultSet.getString("phone_number"));
                    user.setLogin(resultSet.getString("login"));
                    user.setPassword(resultSet.getString("password"));
                    Long idStatus = resultSet.getLong("id_status");
                    userStatusCollection.get(idStatus);
                    user.setStatus(userStatusCollection.get(idStatus));
                    //коллекция статусов
                    userCollFromDataBase.put(user.getId(), user);
                }
            } catch (SQLException sqlException) {
                System.out.println("userController loadUserCollFromDB"+ sqlException.getMessage());
            }finally {
                connectDB.closeConnection();
            }

        } catch (SQLException sqlException){
            System.out.println("Cannot create connection, because " + sqlException.getMessage());
        }

        System.out.println("DB" + userCollFromDataBase.values());
        return userCollFromDataBase;
    }

    public static Map<Long, Reader> loadReaderCollFromDB(ConnectDB connectDB, UserCollection userCollection){
        Map<Long, Reader> readerCollFromDB = new LinkedHashMap<>();
        Long idUser = null;
        try(Connection connection = connectDB.getConnection()){
            try (PreparedStatement statement = connection.prepareStatement("SELECT id, id_user, reader_number FROM ACHUBAROVA.READER");
                 ResultSet resultSet = statement.executeQuery()) {
                    while (resultSet.next()) {
                        Reader reader = new Reader();
                        idUser = resultSet.getLong("id_user");
                        reader.setId(resultSet.getLong("id"));
                        reader.setUser(userCollection.get(idUser));
                        reader.setReaderNumber(resultSet.getString("reader_number"));
                        readerCollFromDB.put(reader.getId(),reader);
                    }
            } catch (SQLException sqlException) {
                System.out.println("userController loadReaderCollFromDB"+ sqlException.getMessage());
            }finally {
                connectDB.closeConnection();
            }
        }catch (SQLException sqlException){
            System.out.println("Cannot create connection, because " + sqlException.getMessage());
        }
        return readerCollFromDB;
    }

    public static Map<Long, Librarian> loadLibCollFromDB(ConnectDB connectDB, UserCollection userCollection){
        Map<Long, Librarian> libCollFromDB = new LinkedHashMap<>();
        Long idUser = null;
        try(Connection connection = connectDB.getConnection()){
            try (PreparedStatement statement = connection.prepareStatement("SELECT id, id_user, TABEL_NUMBER FROM ACHUBAROVA.LIBRARIAN");
                 ResultSet resultSet = statement.executeQuery()) {
                while (resultSet.next()) {
                    Librarian lib = new Librarian();
                    idUser = resultSet.getLong("id_user");
                    lib.setId(resultSet.getLong("id"));
                    lib.setUser(userCollection.get(idUser));
                    lib.setTabelNumber(resultSet.getString("tabel_number"));
                    libCollFromDB.put(lib.getId(),lib);
                }
            } catch (SQLException sqlException) {
                System.out.println("userController loadLibCollFromDB"+ sqlException.getMessage());
            }finally {
                connectDB.closeConnection();
            }
        }catch (SQLException sqlException){
            System.out.println("Cannot create connection, because " + sqlException.getMessage());
        }
        return libCollFromDB;
    }
    /*********************************************/

    /***тут надо доделать***/ /******Мои полномочия всё, я не понимаю, как заставить его работать******/
    //Сохранение изменений в базу
    public static Long saveUserFromDataBase(ConnectDB connectDB, User user) {
        Long newId = user.getId();
        if (newId>=0L) {
            //редактирование
            try(Connection connection = connectDB.getConnection()){
                String query = "update achubarova.users set name=?, passport=?, phone_Number=?, login=?, password=? where id=?";
                try (PreparedStatement statement = connection.prepareStatement(query)) {
                    statement.setString(1, user.getName());
                    statement.setString(2, user.getPassport());
                    statement.setString(3, user.getPhoneNumber());
                    statement.setString(4, user.getLogin());
                    statement.setString(5, user.getPassword());
                    statement.setLong(6, newId);

                    statement.executeUpdate(); //Обновили
                    connection.commit();
                } catch (SQLException sqlException) {
                    sqlException.printStackTrace();
                    connection.rollback();
                }finally {
                    connectDB.closeConnection();
                }
            }catch (SQLException throwables) {
                System.out.println("Cannot create connection");
                throwables.printStackTrace();
            }
        } else {
            //Добавление
            try(Connection connection = connectDB.getConnection()){
                String main_query = "select achubarova.lib_seq.nextval from dual";
                String query = "insert into achubarova.users(id, name, passport, phone_Number, login, password, id_status) values (?, ?, ?, ?, ? ,?, ?)";
                try(Statement stmt = connection.createStatement(); ResultSet rs = stmt.executeQuery(main_query)){
                    while(rs.next()){
                        newId = rs.getLong(1);
                    }
                }catch (SQLException throwables) {
                    System.out.println("Cannot select seq");
                    throwables.printStackTrace();
                }
                try (PreparedStatement statement = connection.prepareStatement(query)) {
                    statement.setLong(1, newId);
                    statement.setString(2, user.getName());
                    statement.setString(3, user.getPassport());
                    statement.setString(4, user.getPhoneNumber());
                    statement.setString(5, user.getLogin());
                    statement.setString(6, user.getPassword());
                    statement.setLong(7, user.getStatus().getId());

                    statement.executeUpdate();
                    connection.commit();

                } catch (SQLException throwables) {
                    System.out.println("Cannot insert new user");
                    throwables.printStackTrace();
                    connection.rollback();
                }finally {
                    connectDB.closeConnection();
                }

            }catch (SQLException throwables) {
                System.out.println("Cannot create connection");
                throwables.printStackTrace();
            }
        }
        return newId;
    }

    /***Вроде работает, причём для всех***/
    public static void removeUserFromDataBase(ConnectDB connectDB, final Long id_, User user){
        try (Connection connection = connectDB.getConnection()){
            String reader_query = "DELETE FROM achubarova.reader WHERE id_user=?";
            String lib_query = "DELETE FROM achubarova.librarian WHERE id_user=?";
            String query = "DELETE FROM ACHUBAROVA.Users WHERE id=?";

            try (PreparedStatement statement = connection.prepareStatement(query)){
                if(user.getStatus().getId() == 1L){
                    try (PreparedStatement statement1 = connection.prepareStatement(lib_query)){
                        statement1.setLong(1, id_);
                        statement1.executeUpdate(); //Обновили
                        connection.commit();
                    } catch (SQLException throwables) {
                        System.out.println(throwables.getMessage());
                        connection.rollback();
                    }
                }
                if(user.getStatus().getId() == 2L){
                    try (PreparedStatement statement1 = connection.prepareStatement(reader_query)){
                        statement1.setLong(1, id_);
                        statement1.executeUpdate(); //Обновили
                        connection.commit();
                    } catch (SQLException throwables) {
                        System.out.println(throwables.getMessage());
                        connection.rollback();
                    }
                }
                statement.setLong(1, id_);
                statement.executeUpdate(); //Обновили
                connection.commit();
            } catch (SQLException throwables) {
                System.out.println(throwables.getMessage());
                connection.rollback();
            }finally {
                connectDB.closeConnection();
            }

        }catch (SQLException throwables) {
            System.out.println("Cannot create connection");
            throwables.printStackTrace();
        }
    }
    /***********************/
}
