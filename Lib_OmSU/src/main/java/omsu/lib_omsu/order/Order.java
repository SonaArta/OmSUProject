package omsu.lib_omsu.order;

import java.util.Date;
import java.util.Objects;

import omsu.lib_omsu.users.*;
import omsu.lib_omsu.books.*;

public class Order {
   private Long id = -1L;
   private Reader reader;
   private BookInStockCollection bookinStock;
   private String status;
   private Date beginData;
   private Date endData;
   private Date duration;
   private Long price;

    public Order()
    {
        reader       = null;
        bookinStock  = null;
        status       = null;
        beginData    = null;
        endData      = null;
        duration     = null;
        price        = 0L;
    }

    public Order(Order order)
    {
        this.reader      = order.getReader();
        this.bookinStock = order.getBookInStock();
        this.status      = order.getStatus();
        this.beginData   = order.getBeginData();
        this.endData     = order.getEndData();
        this.duration    = order.getDuration();
        this.price       = order.getPrice();
    }

    public Order( Reader reader, BookInStockCollection bookinStock, String status, Date beginData, Date endData, Date duration, Long price)
    {
        this.reader      = reader;
        this.bookinStock = bookinStock;
        this.status      = status;
        this.beginData   = beginData;
        this.endData     = endData;
        this.duration    = duration;
        this.price       = price;
    }
    public void setOrder(Order order)
    {
        this.reader      = getReader();
        this.bookinStock = getBookInStock();
        this.status      = getStatus();
        this.beginData   = getBeginData();
        this.endData     = getEndData();
        this.duration    = getDuration();
        this.price       = getPrice();
    }

    public Long getId() {
        return id;
    }

    public Reader getReader() {
        return reader;
    }

    public void setReader(Reader reader) {
        this.reader = reader;
    }

    public BookInStockCollection getBookInStock() {
        return bookinStock;
    }

    public void setBookInStock(BookInStockCollection bookinStock) {
        this.bookinStock = bookinStock;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Date getBeginData() {
        return beginData;
    }

    public void setBeginData(Date beginData) {
        this.beginData = beginData;
    }

    public Date getEndData() {
        return endData;
    }

    public void setEndData(Date endData) {
        this.endData = endData;
    }

    public Date getDuration() {
        return duration;
    }

    public void setDuration(Date duration) {
        this.duration = duration;
    }

    public Long getPrice() {
        return price;
    }

    public void setPrice(Long price) {
        this.price = price;
    }

    @Override
    public String toString() {
        return "Order{" +
                "id=" + id +
                ", reader ='" + reader + '\'' +
                ", BookInStock ='" + bookinStock + '\'' +
                ", Status ='" + status + '\'' +
                ", beginData ='" + beginData + '\'' +
                ", endData ='" + endData + '\'' +
                ", duration ='" + duration + '\'' +
                ", price ='" + price + '\'' +
                '}';
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (!(o instanceof Order)) return false;
        Order order = (Order) o;
        return Objects.equals(getId(), order.getId()) && Objects.equals(getReader(), order.getReader()) &&
                Objects.equals(getBookInStock(), order.getBookInStock()) &&
                Objects.equals(getStatus(), order.getStatus()) &&
                Objects.equals(getBeginData(), order.getBeginData()) &&
                Objects.equals(getEndData(), order.getEndData()) &&
                Objects.equals(getDuration(), order.getDuration()) &&
                Objects.equals(getPrice(), order.getPrice());
    }

    @Override
    public int hashCode() {
        return Objects.hash(getId(), getReader(), getBookInStock(), getStatus(), getBeginData(), getEndData(), getDuration(), getPrice());
    }
}
