package controller;

import connectDB.ConnectDB;
import country.Country;
import country.CountryCollection;
import flower.Flower;
import flower.FlowerCollection;
import flower.TypeFlower;
import flower.TypeFlowerCollection;

import javax.servlet.http.HttpServletRequest;

import java.sql.*;
import java.util.LinkedHashMap;
import java.util.Map;


public class FlowerController {
    public FlowerController() {
    }

    /****************************************************/
    public static Map<Long, Country> loadCountryFromDB(ConnectDB connectDB) {
        Map<Long, Country> countryFromDB = new LinkedHashMap<>();
        try (Connection connection = connectDB.getConnection()) {
            try (PreparedStatement statement = connection.prepareStatement("select id, name from vhitrinceva.country_f");
                 ResultSet resultSet = statement.executeQuery()) {
                while (resultSet.next()) {
                    Country country = new Country();
                    country.setId(resultSet.getLong(1));
                    country.setCountryName(resultSet.getString(2));
                    countryFromDB.put(country.getId(), country);
                }
            } catch (SQLException sqlException) {
                System.out.println("GunController loadCountryFromDB " + sqlException.getMessage());
            } finally {
                connectDB.closeConnection();
            }
        } catch (SQLException sqlException) {
            System.out.println("Cannot create connection, because " + sqlException);
        }
        System.out.println("countryFromDB -->" + countryFromDB.values());
        return countryFromDB;
    }

    public static Country createOrUpdateCountryFromHTML(HttpServletRequest request, Long id, CountryCollection countryCollection) {
        Country country = null;
        if (id >= 0L) {
            country = countryCollection.get(id);
        } else {
            country = new Country();
        }
        return country;
    }

    public static void changeCountryFromDB(HttpServletRequest request, ConnectDB connectDB, Long id, CountryCollection countryCollection) {
        String name = request.getParameter("name");
        if (name != null) {
            Country country = null;
            if (id < 0L) {
                country = new Country(name);
                Long newId = saveCountryFromDB(connectDB, country);
                country.setId(newId);
                countryCollection.put(country);
            } else {
                country = countryCollection.get(id);
                country.setCountryName(name);
                saveCountryFromDB(connectDB, country);
            }
        }
    }

    public static Long saveCountryFromDB(ConnectDB connectDB, Country country) {
        Long newId = country.getId();
        if (newId >= 0L) {
            try (Connection connection = connectDB.getConnection()) {
                String query = "update vhitrinceva.country_f set name=? where id=?";
                try (PreparedStatement statement = connection.prepareStatement(query)) {
                    statement.setString(1, country.getCountryName());
                    statement.setLong(2, newId);

                    statement.executeUpdate();
                    connection.commit();
                } catch (SQLException sqlException) {
                    System.out.println("Cannot update this parameter");
                    sqlException.printStackTrace();
                    connection.rollback();
                } finally {
                    connectDB.closeConnection();
                }
            } catch (SQLException sqlException) {
                System.out.println("Cannot create connection from Country");
                sqlException.printStackTrace();
            }
        } else {
            try (Connection connection = connectDB.getConnection()) {
                String main_query = "select vhitrinceva.seq_flower.nextval from dual";
                String query = "insert into vhitrinceva.country_f(id, name) values (?,?)";

                try (Statement stmt = connection.createStatement(); ResultSet rs = stmt.executeQuery(main_query)) {
                    while (rs.next()) {
                        newId = rs.getLong(1);
                    }
                } catch (SQLException sqlException) {
                    System.out.println("Cannot select seq");
                    sqlException.printStackTrace();
                }

                try (PreparedStatement statement = connection.prepareStatement(query)) {
                    statement.setLong(1, newId);
                    statement.setString(2, country.getCountryName());

                    statement.executeUpdate();
                    connection.commit();
                } catch (SQLException sqlException) {
                    System.out.println("Cannot create this parameter");
                    sqlException.printStackTrace();
                    connection.rollback();
                } finally {
                    connectDB.closeConnection();
                }

            } catch (SQLException sqlException) {
                System.out.println("Cannot create connection from Country");
                sqlException.printStackTrace();
            }
        }
        return newId;
    }

    public static void removeCountryFromDB(ConnectDB connectDB, final Long id_) {
        try (Connection connection = connectDB.getConnection()) {
            String query = "delete from vhitrinceva.country_f where id=?";
            try (PreparedStatement statement = connection.prepareStatement(query)) {
                statement.setLong(1, id_);
                statement.executeUpdate();
                connection.commit();
            } catch (SQLException sqlException) {
                System.out.println("Cannot delete this parameter");
                sqlException.printStackTrace();
                connection.rollback();
            } finally {
                connectDB.closeConnection();
            }
        } catch (SQLException sqlException) {
            System.out.println("Cannot create connection from Country");
            sqlException.printStackTrace();
        }
    }

    /****************************************************/
    public static Map<Long, TypeFlower> loadTypeFlowerFromDB(ConnectDB connectDB) {
        Map<Long, TypeFlower> typeFlowerFromDB = new LinkedHashMap<>();
        try (Connection connection = connectDB.getConnection()) {
            try (PreparedStatement statement = connection.prepareStatement("select id, type_name from vhitrinceva.type_flower");
                 ResultSet resultSet = statement.executeQuery()) {
                while (resultSet.next()) {
                    TypeFlower typeFlower = new TypeFlower();
                    typeFlower.setId(resultSet.getLong(1));
                    typeFlower.setTypeName(resultSet.getString(2));
                    typeFlowerFromDB.put(typeFlower.getId(), typeFlower);
                }
            } catch (SQLException sqlException) {
                System.out.println("GunController loadTypeGunFromDB " + sqlException.getMessage());
            } finally {
                connectDB.closeConnection();
            }
        } catch (SQLException sqlException) {
            System.out.println("Cannot create connection, because " + sqlException);
        }
        System.out.println("typeFlowerFromDB -->" + typeFlowerFromDB.values());
        return typeFlowerFromDB;
    }

    public static TypeFlower createOrUpdateTypeFlowerFromHTML(HttpServletRequest request, Long id, TypeFlowerCollection typeFlowerCollection) {
        TypeFlower typeFlower = null;
        if (id >= 0L) {
            typeFlower = typeFlowerCollection.get(id);
        } else {
            typeFlower = new TypeFlower();
        }
        return typeFlower;
    }

    public static void changeTypeFlowerFromDB(HttpServletRequest request, ConnectDB connectDB, Long id, TypeFlowerCollection typeFlowerCollection) {
        String typeName = request.getParameter("name");
        if (typeName != null) {
            TypeFlower typeFlower = null;
            if (id < 0L) {
                typeFlower = new TypeFlower(typeName);
                Long newId = saveTypeFlowerFromDB(connectDB, typeFlower);
                typeFlower.setId(newId);
                typeFlowerCollection.put(typeFlower);
            } else {
                typeFlower = typeFlowerCollection.get(id);
                typeFlower.setTypeName(typeName);
                saveTypeFlowerFromDB(connectDB, typeFlower);
            }
        }
    }

    public static Long saveTypeFlowerFromDB(ConnectDB connectDB, TypeFlower typeFlower) {
        Long newId = typeFlower.getId();
        if (newId >= 0L) {
            try (Connection connection = connectDB.getConnection()) {
                String query = "update vhitrinceva.type_flower set type_name=? where id=?";
                try (PreparedStatement statement = connection.prepareStatement(query)) {
                    statement.setString(1, typeFlower.getTypeName());
                    statement.setLong(2, newId);

                    statement.executeUpdate();
                    connection.commit();
                } catch (SQLException sqlException) {
                    System.out.println("Cannot update this parameter");
                    sqlException.printStackTrace();
                    connection.rollback();
                } finally {
                    connectDB.closeConnection();
                }
            } catch (SQLException sqlException) {
                System.out.println("Cannot create connection from TypeCun");
                sqlException.printStackTrace();
            }
        } else {
            try (Connection connection = connectDB.getConnection()) {
                String main_query = "select vhitrinceva.seq_flower.nextval from dual";
                String query = "insert into vhitrinceva.type_flower(id, type_name) values (?,?)";

                try (Statement stmt = connection.createStatement(); ResultSet rs = stmt.executeQuery(main_query)) {
                    while (rs.next()) {
                        newId = rs.getLong(1);
                    }
                } catch (SQLException sqlException) {
                    System.out.println("Cannot select seq");
                    sqlException.printStackTrace();
                }

                try (PreparedStatement statement = connection.prepareStatement(query)) {
                    statement.setLong(1, newId);
                    statement.setString(2, typeFlower.getTypeName());

                    statement.executeUpdate();
                    connection.commit();
                } catch (SQLException sqlException) {
                    System.out.println("Cannot create this parameter");
                    sqlException.printStackTrace();
                    connection.rollback();
                } finally {
                    connectDB.closeConnection();
                }

            } catch (SQLException sqlException) {
                System.out.println("Cannot create connection from Country");
                sqlException.printStackTrace();
            }
        }
        return newId;
    }

    public static void removeTypeFlowerFromDB(ConnectDB connectDB, final Long id_) {
        try (Connection connection = connectDB.getConnection()) {
            String query = "delete from vhitrinceva.type_flower where id=?";
            try (PreparedStatement statement = connection.prepareStatement(query)) {
                statement.setLong(1, id_);
                statement.executeUpdate();
                connection.commit();
            } catch (SQLException sqlException) {
                System.out.println("Cannot dalete this parameter");
                sqlException.printStackTrace();
                connection.rollback();
            } finally {
                connectDB.closeConnection();
            }
        } catch (SQLException sqlException) {
            System.out.println("Cannot create connection from Country");
            sqlException.printStackTrace();
        }
    }

    /****************************************************/

    public static Map<Long, Flower> loadFlowerFromDB(ConnectDB connectDB, TypeFlowerCollection typeFlowerCollection, CountryCollection countryCollection) {
        Map<Long, Flower> flowerFromDB = new LinkedHashMap<>();
        try (Connection connection = connectDB.getConnection()) {
            try (PreparedStatement statement = connection.prepareStatement("select id, name, price, id_type_flower, id_country from vhitrinceva.flower");
                 ResultSet resultSet = statement.executeQuery()) {
                while (resultSet.next()) {
                    Flower flower = new Flower();
                    flower.setId(resultSet.getLong("id"));
                    flower.setName(resultSet.getString("name"));
                    flower.setPrice(resultSet.getString("price"));

                    Long idTypeFlower = resultSet.getLong("id_type_flower");
                    Long idCountry = resultSet.getLong("id_country");

                    flower.setTypeFlower(typeFlowerCollection.get(idTypeFlower));
                    flower.setCountry(countryCollection.get(idCountry));
                    flowerFromDB.put(flower.getId(), flower);
                }
            } catch (SQLException sqlException) {
                System.out.println("FlowerController loadFlowerFromDB " + sqlException.getMessage());
            } finally {
                connectDB.closeConnection();
            }
        } catch (SQLException sqlException) {
            System.out.println("Cannot create connection, because " + sqlException.getMessage());
        }
        System.out.println("FlowerFromDB -->" + flowerFromDB.values());
        return flowerFromDB;
    }

    public static Flower createOrUpdateFlowerFromHTML(HttpServletRequest request, Long id, FlowerCollection flowerCollection) {
        Flower flower = null;
        if (id >= 0L) {
            flower = flowerCollection.get(id);
        } else {
            flower = new Flower();
        }
        return flower;
    }

    public static void changeFlowerFromDB(HttpServletRequest request, ConnectDB connectDB, Long id, FlowerCollection flowerCollection) {
        String name = request.getParameter("name");
        String price = request.getParameter("price");
        String typeName = request.getParameter("typeName");
        String countryName = request.getParameter("countryName");
        TypeFlower typeFlower = null;
        Country country = null;

        if (name != null && typeName != null && countryName != null) {
            Flower flower = null;
            if (id < 0L) {
                typeFlower = new TypeFlower(typeName);
                country = new Country(countryName);
                flower = new Flower(name, price, typeFlower, country);
                Long newId = saveFlowerFromDB(connectDB, flower);
                flower.setId(newId);
                flowerCollection.put(flower);
            } else {
                flower = flowerCollection.get(id);
                flower.setName(name);
                flower.setPrice(price);
                typeFlower = new TypeFlower(typeName);
                country = new Country(countryName);
                flower.setTypeFlower(typeFlower);
                flower.setCountry(country);
                saveFlowerFromDB(connectDB, flower);
            }
        }
    }

    public static Long saveFlowerFromDB(ConnectDB connectDB, Flower flower) {
        Long newId = flower.getId();
        if (newId >= 0L) {
            try (Connection connection = connectDB.getConnection()) {
                String query = "update vhitrinceva.flower set name=?, price=?, id_type_flower=?, id_country=? where id=?";
                try (PreparedStatement statement = connection.prepareStatement(query)) {
                    statement.setString(1, flower.getName());
                    statement.setString(2, flower.getPrice());
                    statement.setLong(3, flower.getTypeFlower().getId());
                    statement.setLong(4, flower.getCountry().getId());
                    statement.setLong(5, newId);

                    statement.executeUpdate();
                    connection.commit();
                } catch (SQLException sqlException) {
                    System.out.println("Cannot update this parameter");
                    sqlException.printStackTrace();
                    connection.rollback();
                } finally {
                    connectDB.closeConnection();
                }
            } catch (SQLException sqlException) {
                System.out.println("Cannot create connection");
                sqlException.printStackTrace();
            }
        } else {
            String main_query = "select vhitrinceva.seq_flower.nextval from dual";
            String query = "insert into vhitrinceva.flower(id, name,price, id_type_flower, id_country) values (?,?,?,?,?)";
            try (Connection connection = connectDB.getConnection()) {
                try (Statement stmt = connection.createStatement(); ResultSet rs = stmt.executeQuery(main_query)) {
                    while (rs.next()) {
                        newId = rs.getLong(1);
                    }
                } catch (SQLException sqlException) {
                    System.out.println("Cannot select seq");
                    sqlException.printStackTrace();
                }

                try (PreparedStatement statement = connection.prepareStatement(query)) {
                    statement.setLong(1, newId);
                    statement.setString(2, flower.getName());
                    statement.setString(3, flower.getName());
                    statement.setLong(4, flower.getTypeFlower().getId());
                    statement.setLong(5, flower.getCountry().getId());

                    statement.executeUpdate();
                    connection.commit();
                } catch (SQLException sqlException) {
                    System.out.println("Cannot create this parameter in Flower.");
                    sqlException.printStackTrace();
                    connection.rollback();
                } finally {
                    connectDB.closeConnection();
                }
            } catch (SQLException sqlException) {
                System.out.println("Cannot create connection");
                sqlException.printStackTrace();
            }
        }
        return newId;
    }

    public static void removeFlowerFromDB(ConnectDB connectDB, final Long id_) {
        try (Connection connection = connectDB.getConnection()) {
            String query = "delete from achubarova.gun where id=?";
            try (PreparedStatement statement = connection.prepareStatement(query)) {
                statement.setLong(1, id_);
                statement.executeUpdate();
                connection.commit();
            } catch (SQLException sqlException) {
                System.out.println("Cannot delete from Gun" + sqlException.getMessage());
                connection.rollback();
            } finally {
                connectDB.closeConnection();
            }
        } catch (SQLException sqlException) {
            System.out.println("Cannot create connection");
            sqlException.printStackTrace();
        }
    }
}
