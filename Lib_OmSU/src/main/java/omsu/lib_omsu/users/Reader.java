package omsu.lib_omsu.users;

import java.util.Objects;
import omsu.lib_omsu.*;
import omsu.lib_omsu.order.*;

public class Reader extends User{
    private String readerNumber;
    private OrderCollection orderCollection;

    public Reader() {
        super();
        this.status = null;
        this.readerNumber = "";
        this.orderCollection = null;
    }
    public Reader (User user)
    {
        super(user);
        this.readerNumber = "";
        this.orderCollection = null;
    }

    public Reader (String name, String passport, String phoneNumber,
                   String login, String password, String readerNumber, UserStatus status, OrderCollection orderCollection)
    {
        super(name, passport, phoneNumber, login, password,status);
        this.status = status;
        this.readerNumber = readerNumber;
        this.orderCollection = orderCollection;
    }
    public Reader (String name, String passport, String phoneNumber,
                   String login, String password, UserStatus status, String readerNumber)
    {
        super(name, passport, phoneNumber, login, password,status);
        this.status = status;
        this.readerNumber = readerNumber;
    }
    public Reader (User user, String readerNumber, OrderCollection orderCollection)
    {
        super(user);
        this.readerNumber = readerNumber;
        this.orderCollection = orderCollection;
    }


    public String getReaderNumber() {
        return readerNumber;
    }

    public void setReaderNumber(String readerNumber) {
        this.readerNumber = readerNumber;
    }

    public OrderCollection getOrderCollection() {
        return orderCollection;
    }

    public void setOrderCollection(OrderCollection orderCollection) {
        this.orderCollection = orderCollection;
    }

    @Override
    public String toString() {
        return "Reader{" + super.toString() +
                "readerNumber='" + readerNumber + '\'' +
                '}';
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (!(o instanceof Reader)) return false;
        if (!super.equals(o)) return false;
        Reader reader = (Reader) o;
        return Objects.equals(getReaderNumber(), reader.getReaderNumber());
    }

    @Override
    public int hashCode() {
        return Objects.hash(super.hashCode(), getReaderNumber());
    }
}
