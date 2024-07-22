package omsu.lib_omsu.controller;

import omsu.lib_omsu.books.*;
import omsu.lib_omsu.author.*;
import omsu.lib_omsu.connectDB.ConnectDB;
import omsu.lib_omsu.label.*;

import javax.servlet.http.HttpServletRequest;
import java.sql.*;
import java.util.LinkedHashMap;
import java.util.Map;

public class BookController
{
    /****Full_Label*****/
    public static Map<Long, Label> loadLabelFromDB(ConnectDB connectDB){
        Map<Long, Label> labelCollFromDB = new LinkedHashMap<>();

        try (Connection connection = connectDB.getConnection();
             PreparedStatement statement = connection.prepareStatement("SELECT id, name FROM ACHUBAROVA.Label order by name");
             ResultSet resultSet = statement.executeQuery()){
            while (resultSet.next()) {
                Label label = new Label();
                label.setId(resultSet.getLong(1));
                label.setName(resultSet.getString(2));
                labelCollFromDB.put(label.getId(), label);
            }

        } catch (SQLException sqlException) {
            System.out.println("bookController loadLabelFromDB"+ sqlException.getMessage());
        }

        System.out.println("LabelFromDB" + labelCollFromDB.values());
        return labelCollFromDB;
    }
    public static void changeLabelFromDB(HttpServletRequest request, ConnectDB connectDB, Long id, LabelCollection labelCollection){
        String name = request.getParameter("name");
        if(name != null) {
            Label label = null;
            if (id < 0L) {
                label = new Label(name);
                Long newId = saveLabelFromDataBase(connectDB, label);
                label.setId(newId);
                labelCollection.put(label);
            } else {
                label = labelCollection.get(id);
                label.setName(name);
                saveLabelFromDataBase(connectDB, label);
            }
        }
    }
    public static Label createOrUpdateLabelFromHtml(HttpServletRequest request, Long id, LabelCollection labelCollection){
        Label label = null;
        if(id >= 0L){
            label = labelCollection.get(id);
        }else{ //add
            label = new Label();
        }
        return label;
    }
    public static Long saveLabelFromDataBase(ConnectDB connectDB, Label label){
        Long newId = label.getId();
        if(newId >= 0L){
            //Update
            try(Connection connection = connectDB.getConnection()){
                String query = "update achubarova.label set name=? where id=?";
                try(PreparedStatement statement = connection.prepareStatement(query)){
                    statement.setString(1, label.getName());
                    statement.setLong(2, newId);

                    statement.executeUpdate(); //Обновили
                    connection.commit();
                }catch (SQLException sqlException) {
                    sqlException.printStackTrace();
                    connection.rollback();
                }finally {
                    connectDB.closeConnection();
                }
            }catch (SQLException throwables) {
                System.out.println("Cannot create connection");
                throwables.printStackTrace();
            }
        }else{
            //create
            try(Connection connection = connectDB.getConnection()){
                String main_query = "select achubarova.lib_seq.nextval from dual";
                String query = "insert into achubarova.label(id, name) values (? ,?)";

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
                    statement.setString(2, label.getName());

                    statement.executeUpdate();
                    connection.commit();
                } catch (SQLException throwables) {
                    System.out.println("Cannot update this parameter");
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
    public static void removeLabelFromDataBase(ConnectDB connectDB, final Long id_){
        try (Connection connection = connectDB.getConnection()){
            String query = "DELETE FROM ACHUBAROVA.Label WHERE id=?";
            try (PreparedStatement statement = connection.prepareStatement(query)){
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
    /*****************/

    /****Full_Authors*****/
    public static Map<Long, Author> loadAuthorFromDB(ConnectDB connectDB){
        Map<Long, Author> authorCollFromDB = new LinkedHashMap<>();

        try (Connection connection = connectDB.getConnection();
             PreparedStatement statement = connection.prepareStatement("SELECT id, name FROM ACHUBAROVA.Authors order by name");
             ResultSet resultSet = statement.executeQuery()){
            while (resultSet.next()) {
                Author author = new Author();
                author.setId(resultSet.getLong(1));
                author.setName(resultSet.getString(2));
                authorCollFromDB.put(author.getId(), author);
            }

        } catch (SQLException sqlException) {
            System.out.println("bookController loadAuthorsFromDB"+ sqlException.getMessage());
        }

        System.out.println("AuthorFromDB" + authorCollFromDB.values());
        return authorCollFromDB;
    }
    public static void changeAuthorFromDB(HttpServletRequest request, ConnectDB connectDB, Long id, AuthorCollection authorCollection){
        String name = request.getParameter("name");
        if(name != null) {
            Author author = null;
            if (id < 0L) {
                author = new Author(name);
                Long newId = saveAuthorFromDataBase(connectDB, author);
                author.setId(newId);
                authorCollection.put(author);
            } else {
                author = authorCollection.get(id);
                author.setName(name);
                saveAuthorFromDataBase(connectDB, author);
            }
        }
    }
    public static Author createOrUpdateAuthorFromHtml(HttpServletRequest request, Long id, AuthorCollection authorCollection){
        Author author = null;
        if(id >= 0L){
            author = authorCollection.get(id);
        }else{ //add
            author = new Author();
        }
        return author;
    }
    public static Long saveAuthorFromDataBase(ConnectDB connectDB, Author author){
        Long newId = author.getId();
        if(newId >= 0L){
            try(Connection connection = connectDB.getConnection()){
                String query = "update achubarova.authors set name=? where id=?";
                try(PreparedStatement statement = connection.prepareStatement(query)){
                    statement.setString(1, author.getName());
                    statement.setLong(2, newId);
                    statement.executeUpdate(); //Обновили
                    connection.commit();
                }catch (SQLException sqlException) {
                    sqlException.printStackTrace();
                    connection.rollback();
                }finally {
                    connectDB.closeConnection();
                }
            }catch (SQLException throwables) {
                System.out.println("Cannot create connection");
                throwables.printStackTrace();
            }
        }
        else{
            //create
            try(Connection connection = connectDB.getConnection()){
                String main_query = "select achubarova.lib_seq.nextval from dual";
                String query = "insert into achubarova.authors(id, name) values (? ,?)";

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
                    statement.setString(2, author.getName());
                    statement.executeUpdate();
                    connection.commit();
                } catch (SQLException throwables) {
                    System.out.println("Cannot update this parameter");
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
    public static void removeAuthorFromDataBase(ConnectDB connectDB, final Long id_){
        try (Connection connection = connectDB.getConnection()){
            String query = "DELETE FROM achubarova.authors WHERE id=?";
            try (PreparedStatement statement = connection.prepareStatement(query)){
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
    /********************/


    // Не совсем уверена как
    /***********Full_Book**********/
    public static Map<Long, Book> loadBookFromDB(ConnectDB connectDB, LabelCollection labelCollection, AuthorCollection authorCollection){
        Map<Long, Book> bookCollFromDataBase = new LinkedHashMap<>();
        Book book = new Book();
        Long idBook = null;
        String nameBook = null;
        String isbnBook = null;
        Long idLabel = null;
        Long idAuthors = null;
        try(Connection connection = connectDB.getConnection();
            PreparedStatement statement = connection.prepareStatement
                    ("select book.id, book.name, book.isbn,bl.ID_LABEL, ba.ID_AUTHORS, lab.NAME as lab_name, auth.NAME as auth_name from books book\n" +
                            "    JOIN book_label bl on bl.id_book = book.id\n" +
                            "    JOIN book_authors ba on ba.id_book = book.id\n" +
                            "    JOIN authors auth on ba.id_authors = auth.id\n" +
                            "    JOIN label lab on bl.id_label = lab.id \n" +
                            "order by book.id, auth.id, lab.id");
            ResultSet resultSet = statement.executeQuery();){
            while (resultSet.next()) {
                idBook = resultSet.getLong("id");
                nameBook = resultSet.getString("name");
                isbnBook = resultSet.getString("isbn");
                idLabel = resultSet.getLong("id_label");
                idAuthors = resultSet.getLong("id_authors");

                if(book.getId() != idBook){
                    book = new Book();
                    book.setId(idBook);
                    book.setName(nameBook);
                    book.setIsbn(isbnBook);
                    LabelCollection labelColl = new LabelCollection();
                    AuthorCollection authorColl = new AuthorCollection();
                    labelColl.put(labelCollection.get(idLabel));
                    authorColl.put(authorCollection.get(idAuthors));
                    book.setLabelCollection(labelColl);
                    book.setAuthorCollection(authorColl);
                    bookCollFromDataBase.put(book.getId(), book);
                }else{
                    if(!book.getAuthorCollection().getAuthorMapKeys().contains(idAuthors)){
                        book.getAuthorCollection().put(authorCollection.get(idAuthors));
                    }
                    if(!book.getLabelCollection().getLabelMapKeys().contains(idLabel)){
                        book.getLabelCollection().put(labelCollection.get(idLabel));
                    }
                }
                System.out.println("book -->" + book);
            }
        }catch (SQLException sqlException) {
            System.out.println("bookController loadBookFromDB: " + sqlException.getMessage());
        }
        return bookCollFromDataBase;
    }
    public static void changeBookFromDB(HttpServletRequest request, ConnectDB connectDB,Long id, BookCollection bookCollection,
                                  AuthorCollection authorCollection, LabelCollection labelCollection){
        String name = request.getParameter("name");
        String isbn = request.getParameter("isbn");

        AuthorCollection authorColl = new AuthorCollection();
        LabelCollection labelColl = new LabelCollection();

        String[] a_ = request.getParameterValues("authorCollection");
        for(String a: a_)
        {
            Long author_id = Long.parseLong(a);
            Author author = authorCollection.get(author_id);
            authorColl.put(author);
        }

        String l = request.getParameter("labelCollection");
        Long l_id = Long.parseLong(l);
        Label label = labelCollection.get(l_id);
        labelColl.put(label);

        if(name != null && isbn != null) {
            Book book = null;
            if (id < 0L) {
                book = new Book(name, isbn, authorColl , labelColl);
                Long newId = saveBookFromDataBase(connectDB,book);
                book.setId(newId);
                bookCollection.put(book);
            } else {
                book = bookCollection.get(id);
                book.setName(name);
                book.setIsbn(isbn);

                book.setAuthorCollection(authorColl);
                book.setLabelCollection(labelColl);
                saveBookFromDataBase(connectDB, book);
            }
        }
    }
    public static Book createOrUpdateBookFromHtml(HttpServletRequest request, Long id, BookCollection bookCollection){
        Book book = null;
        if(id >= 0L){
            book = bookCollection.get(id);
        }else{
            book = new Book();
        }
        return book;
    }
    /*****************************/
    /************ПОЧТИ ИДЕАЛЬНО, НУЖНО ОБРАТИТЬ ВНИМАНИЕ НА ДОБАВЛЕНИЕ И РЕДАКТИРОВАНИЕ СТОРОННИХ ТАБЛИЦ****************/
    public static Long saveBookFromDataBase(ConnectDB connectDB, Book book){
        Long newId = book.getId();
        LabelCollection labelCollection = book.getLabelCollection();
        AuthorCollection authorCollection = book.getAuthorCollection();
        if(newId >= 0L){
            //Update
            /******Label******/
            try(Connection connection = connectDB.getConnection()){
                String label_query = "update achubarova.book_label set id_label=? where id_book=?";
                for(Label label : labelCollection.findAll()) {
                    try (PreparedStatement stmt = connection.prepareStatement(label_query)) {
                        stmt.setLong(2, label.getId());
                        stmt.setLong(2, newId);

                        stmt.executeUpdate();
                        connection.commit();
                    } catch (SQLException throwables) {
                        System.out.println("Тут");
                        throwables.printStackTrace();
                        connection.rollback();
                    } finally {
                        connectDB.closeConnection();
                    }
                }
            }catch (SQLException throwables) {
                System.out.println("Cannot create BOOK_LABEL connection");
                throwables.printStackTrace();
            }

            /*****Authors*****/
            try(Connection connection = connectDB.getConnection()){
                String label_query = "update achubarova.BOOK_AUTHORS set ID_AUTHORS=? where id_book=?";
                for (Author author : authorCollection.findAll()){
                    try(PreparedStatement stmt = connection.prepareStatement(label_query)){
                        stmt.setLong(2,author.getId());
                        stmt.setLong(2,newId);

                        stmt.executeUpdate();
                        connection.commit();
                    } catch (SQLException throwables) {
                        System.out.println("Тут");
                        throwables.printStackTrace();
                        connection.rollback();
                    }finally {
                        connectDB.closeConnection();
                    }
                }
            }catch (SQLException throwables) {
                System.out.println("Cannot create BOOK_AUTHORS connection");
                throwables.printStackTrace();
            }

            try(Connection connection = connectDB.getConnection()){
                String query = "update achubarova.books set name=?, isbn=? where id=?";
                try(PreparedStatement statement = connection.prepareStatement(query)){
                    statement.setString(1, book.getName());
                    statement.setString(2, book.getIsbn());
                    statement.setLong(3, newId);

                    statement.executeUpdate(); //Обновили
                    connection.commit();
                }catch (SQLException sqlException) {
                    sqlException.printStackTrace();
                    connection.rollback();
                }finally {
                    connectDB.closeConnection();
                }
            }catch (SQLException throwables) {
                System.out.println("Cannot create BOOKS connection");
                throwables.printStackTrace();
            }
        }else{
            //create
            String label_query = "insert into achubarova.book_label(id_book, id_label) values(?, ?)";
            String author_query = "insert into achubarova.book_authors(id_book, id_authors) values(?, ?)";

            try(Connection connection = connectDB.getConnection()){
                String main_query = "select achubarova.lib_seq.nextval from dual";
                String query = "insert into achubarova.books(id, name, isbn) values (? ,?, ?)";

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
                    statement.setString(2, book.getName());
                    statement.setString(3, book.getIsbn());

                    statement.executeUpdate();
                    connection.commit();

                } catch (SQLException throwables) {
                    System.out.println("Cannot insert BOOKS parameter");
                    throwables.printStackTrace();
                    connection.rollback();
                }finally {
                    connectDB.closeConnection();
                }
            }catch (SQLException throwables) {
                System.out.println("Cannot create connection");
                throwables.printStackTrace();
            }
            /***Label***/
            try (Connection connection = connectDB.getConnection()) {
                for(Label label : labelCollection.findAll()) {
                    try (PreparedStatement stmt = connection.prepareStatement(label_query)) {
                        stmt.setLong(1, newId);
                        stmt.setLong(2, label.getId());

                        stmt.executeUpdate();
                        connection.commit();
                    } catch (SQLException throwables) {
                        System.out.println("Cannot insert in BOOK_LABEL parameter");
                        throwables.printStackTrace();
                        connection.rollback();
                    } finally {
                        connectDB.closeConnection();
                    }
                }
            /*******/
            } catch (SQLException throwables) {
                System.out.println("Cannot create BOOK_Label connection");
                throwables.printStackTrace();
            }
            /***Authors***/
            try (Connection connection = connectDB.getConnection()) {
                for(Author author : authorCollection.findAll()) {
                    try (PreparedStatement stmt = connection.prepareStatement(author_query)) {
                        stmt.setLong(1, newId);
                        stmt.setLong(2, author.getId());

                        stmt.executeUpdate();
                        connection.commit();
                    } catch (SQLException throwables) {
                        System.out.println("Cannot insert BOOK_AUTHORS parameter");
                        throwables.printStackTrace();
                        connection.rollback();
                    } finally {
                        connectDB.closeConnection();
                    }
                }
            } catch (SQLException throwables) {
                System.out.println("Cannot create BOOK_Label connection");
                throwables.printStackTrace();
            }
            /*******/
        }
        return newId;
    }

    public static void removeBookFromDataBase(ConnectDB connectDB, final Long id_){
        try(Connection connection = connectDB.getConnection()){
            String query = "Delete From achubarova.books where id=?";

            try(PreparedStatement statement = connection.prepareStatement(query)){
                statement.setLong(1, id_);

                statement.executeUpdate(); //Обновили
                connection.commit();
            } catch (SQLException throwables) {
                System.out.println(throwables.getMessage());
                connection.rollback();
            }finally {
                connectDB.closeConnection();
            }
        } catch (SQLException throwables) {
            System.out.println("Cannot create connection");
            throwables.printStackTrace();
        }
    }
}