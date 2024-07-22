package omsu.lib_omsu.users;

import omsu.lib_omsu.order.*;

import java.util.Map;
import java.util.Collection;
import java.util.LinkedHashMap;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.HashSet;

public class UserCollection {
    Map<Long, User> userMap= new LinkedHashMap<>();
    OrderCollection orderCollection;

    public UserCollection() {
       /* User user1= new Librarian("Чубарова Алина Аркадьевна", "5220 554566", "+7 908 100 90 80",
                "alina", "123", "L123");
        User user2 = new Librarian("Хитринцева Валерия Вадимовна", "5220 553366", "+7 950 155 90 80",
                "valeria", "1234", "L321");
        User user3 = new Librarian("Нуркушева Мадина Мубаряковна", "5220 552266", "+7 950 100 00 80",
                "madina", "12345", "L231");
        User user4 = new Librarian("Аржанников Артём Витальевич", "5220 904566", "+7 908 000 97 80",
                "artem", "1q2w3e4", "L132");
        User user5 = new Librarian("Пасынков Денис Андреевич", "5220 904566", "+7 908 000 90 80",
                "denis", "1q23e4", "L213");
        User user6 = new Reader("Михеев Сергей Сергеевич", "5220 554566", "+7 908 170 90 80",
                "sergey", "1234r5", "R1", orderCollection );
        User user7 = new Reader("Газеев Дамир", "5220 553366", "+7 950 155 90 80",
                "damir", "1234","R2", orderCollection);
        User user8 = new Reader("Тимошенко Илья", "5220 552266", "+7 950 107 90 80",
                "ilya", "1tt3r5", "R3", orderCollection);
        User user9 = new Reader("Сулейманов Самат", "5220 904566", "+7 908 080 90 80", "samat", "1q2w3e4",
                "R1", orderCollection);
        User user10 = new Reader("Кадис Этрама ди Рейзел", "5220 000000", "8 800 555 35 35", "rei", "molodec", "R2000", orderCollection);
        userMap.put(user1.getId(),user1);
        userMap.put(user2.getId(),user2);
        userMap.put(user3.getId(),user3);
        userMap.put(user4.getId(),user4);
        userMap.put(user5.getId(),user5);
        userMap.put(user6.getId(),user6);
        userMap.put(user7.getId(),user7);
        userMap.put(user8.getId(),user8);
        userMap.put(user9.getId(),user9);
        userMap.put(user10.getId(),user10);*/
    }

    public Long put(User user){
        userMap.put(user.getId(), user);
        return user.getId();
    }

    public User get(Long id){
        return userMap.get(id);
    }

    public void add(User user) {
        userMap.put(user.getId(), user);
    }

    public void remove(User user){
        userMap.remove(user.getId());
    }

    @Override
    public String toString(){
        return userMap.toString();
    }

    public Collection<User> findAll(){
        return userMap.values();
    }

    public User findUserByLoginPassword(String login, String password){
        User user = null;
        if(login != null && password != null) {
            for (User u : userMap.values()) {
                System.out.println("------>"+u);
                if (u != null &&
                        login.equalsIgnoreCase(u.getLogin()) &&
                        password.equalsIgnoreCase(u.getPassword())
                ) {
                    user = u;
                    break;
                }
            }
        }
        return user;
    }

    public User findAll(String name, String passport, String phoneNumber,
                        String login, String password, String status){
        User user = null;
        if(name != null && passport != null && phoneNumber != null &&
                login != null && password != null && status != null)
        {
            for (User u : userMap.values()){
                System.out.println("This---->" +u);
                if(u != null && name.equalsIgnoreCase(u.getName()) &&
                                passport.equalsIgnoreCase(u.getPassport()) &&
                                phoneNumber.equalsIgnoreCase(u.getPhoneNumber())&&
                                login.equalsIgnoreCase(u.getLogin()) &&
                                password.equalsIgnoreCase(u.getPassword()))
                                //status.equalsIgnoreCase(u.getStatus()))
                {
                    user = u;
                    break;
                }
            }
        }
        return user;
    }

    public HashSet<User> getUserValues() {
        System.out.println("user="+userMap.values());
        return new HashSet<User>(userMap.values());
    }

    public void setUserCollection(Map<Long, User> userMap) {
        this.userMap = userMap;
    }
}
