package connectDB;

import java.sql.Connection;
import java.sql.SQLException;


import oracle.jdbc.*;
import oracle.jdbc.pool.OracleDataSource;

import java.sql.Connection;
import java.sql.SQLException;

public class ConnectDB {
    OracleDataSource oracleDataSource;
    Connection connection;

    //Для авторизации базы
    public ConnectDB() {
        try {
            this.oracleDataSource = new OracleDataSource();
            oracleDataSource.setURL("jdbc:oracle:thin:@oracle.para-lab.ru:1521:XE");
            oracleDataSource.setUser("vhitrinceva");
            oracleDataSource.setPassword("1");
        } catch (SQLException sqlException) {
            System.out.println("Error! Not create connection!");
            sqlException.printStackTrace();
        }
    }

    //Для подключения
    public Connection getConnection() throws SQLException {
        connection = this.oracleDataSource.getConnection();
        connection.setAutoCommit(false);
        return this.connection;
    }

    //Отключение
    public void closeConnection() throws SQLException {
        this.connection.close();
    }

    //Отслеживание пользователя

}
