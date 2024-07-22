package omsu.lib_omsu.users;

import java.util.HashSet;
import java.util.Objects;
import java.util.Set;

public class User{
    private Long id = -1L;
    private String name;
    private String passport;
    private String phoneNumber;
    private String login;
    private String password;
    protected UserStatus status; //Так как меняем поля родителя в дочерних классах

    public User(){
        name="";
        passport="";
        phoneNumber="";
        login="";
        passport="";
        status=new UserStatus();
    }

    public User(User user){
        this.name = user.name;
        this.passport = user.passport;
        this.phoneNumber = user.phoneNumber;
        this.login = user.login;
        this.password = user.password;
        this.status = user.status;
    }

    public User(String name, String passport, String phoneNumber, String login, String password, UserStatus status){
        this.name = name;
        this.passport = passport;
        this.phoneNumber = phoneNumber;
        this.login = login;
        this.password = password;
        this.status = status;
    }

    public Long getId() {
        return id;
    }

    public String getName() {
        return name;
    }

    public String getPassport() {
        return passport;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public String getLogin() {
        return login;
    }

    public String getPassword() {
        return password;
    }

    public UserStatus getStatus() {
        return status;
    }

    public void setId(Long id){
        this.id = id;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setPassport(String passport) {
        this.passport = passport;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    public void setLogin(String login) {
        this.login = login;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public void setStatus(UserStatus status) {
        this.status = status;
    }

    public void setUser(User user){
        this.id = user.getId();
        this.name = user.getName();
        this.passport = user.getPassport();
        this.phoneNumber = user.getPhoneNumber();
        this.login = user.getLogin();
        this.password = user.getPassword();
        this.status = user.getStatus();
    }

    @Override
    public String toString() {
        return "User{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", passport='" + passport + '\'' +
                ", phoneNumber='" + phoneNumber + '\'' +
                ", login='" + login + '\'' +
                ", password='" + password + '\'' +
                ", status='" + status + '\'' +
                '}';
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (!(o instanceof User)) return false;
        User user = (User) o;
        return Objects.equals(getId(), user.getId()) && Objects.equals(getName(), user.getName()) &&
                Objects.equals(getPassport(), user.getPassport()) &&
                Objects.equals(getPhoneNumber(), user.getPhoneNumber()) &&
                Objects.equals(getLogin(), user.getLogin()) &&
                Objects.equals(getPassword(), user.getPassword()) &&
                Objects.equals(getStatus(), user.getStatus());
    }

    @Override
    public int hashCode() {
        return Objects.hash(getId(), getName(), getPassport(), getPhoneNumber(), getLogin(), getPassword(), getStatus());
    }
}