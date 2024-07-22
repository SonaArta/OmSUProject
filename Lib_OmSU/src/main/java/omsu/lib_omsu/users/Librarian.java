package omsu.lib_omsu.users;

import java.util.Objects;

public class Librarian extends User{
    private String tabelNumber;

    public Librarian(){
        super();
        this.status = null;
        this.tabelNumber = "";
    }

    public Librarian(String name, String passport, String phoneNumber,
                     String login, String password,UserStatus status, String tabelNumber)
    {
        super(name, passport, phoneNumber, login, password,status);
        this.status = status;
        this.tabelNumber = tabelNumber;
    }

    public Librarian(User user, String tabelNumber)
    {
        super(user);
        this.tabelNumber = tabelNumber;
    }

    public String getTabelNumber() {
        return tabelNumber;
    }

    public void setTabelNumber(String tabelNumber) {
        this.tabelNumber = tabelNumber;
    }

    @Override
    public String toString() {
        return "Librarion{" + super.toString() +
                "tabelNumber='" + tabelNumber + '\'' +
                '}';
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (!(o instanceof Librarian)) return false;
        if (!super.equals(o)) return false;
        Librarian librarian = (Librarian) o;
        return Objects.equals(getTabelNumber(), librarian.getTabelNumber());
    }

    @Override
    public int hashCode() {
        return Objects.hash(super.hashCode(), getTabelNumber());
    }
}
