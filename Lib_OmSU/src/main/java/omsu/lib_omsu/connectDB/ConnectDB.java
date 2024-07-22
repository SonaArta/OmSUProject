package omsu.lib_omsu.connectDB;

import java.sql.*;
import oracle.jdbc.*;

import omsu.lib_omsu.users.*;
import omsu.lib_omsu.books.*;
import omsu.lib_omsu.controller.*;
import omsu.lib_omsu.label.*;
import omsu.lib_omsu.author.*;
import omsu.lib_omsu.order.*;
import oracle.jdbc.pool.OracleDataSource;


public class ConnectDB {
    OracleDataSource oracleDataSource;
    //Нужно ли делать приватными?
    Connection connection;
    User user = new User();

    //Для авторизации базы
    public ConnectDB(){
        try{
            this.oracleDataSource = new OracleDataSource();
            oracleDataSource.setURL("jdbc:oracle:thin:@oracle.para-lab.ru:1521:XE"); //Лучше задать строками?
            oracleDataSource.setUser("achubarova");
            oracleDataSource.setPassword("1");
        } catch (SQLException sqlException) {
            System.out.println("ERROR!"); //вывод ошибки
            sqlException.printStackTrace();
        }
    }

    //Для подключения
    public Connection getConnection() throws SQLException {
        connection = this.oracleDataSource.getConnection();
        connection.setAutoCommit(false);
        return this.connection;
    }
    //отключение
    public void closeConnection() throws SQLException {
        this.connection.close();
    }

    //отслеживание пользователя
    public void setCurrentUser(User user){
        this.user.setUser(user);
    }
    public User getCurrentUser(){
        return user;
    }
}
