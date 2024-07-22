package omsu.lib_omsu.order;

import java.awt.datatransfer.FlavorEvent;
import java.util.Objects;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;

import java.util.*;

import omsu.lib_omsu.author.Author;
import omsu.lib_omsu.author.AuthorCollection;
import omsu.lib_omsu.books.*;
import omsu.lib_omsu.label.LabelCollection;
import omsu.lib_omsu.users.*;


public class OrderCollection {
    private static Map<Long, Order> orderMap = new LinkedHashMap<>();

    public OrderCollection() {
        /*UserStatus status = new UserStatus("reader");
        Reader user7 = new Reader("Газеев Дамир", "5220 553366", "+7 950 155 90 80",
                "damir", "1trtr5", status,"R2");
        Reader user8 = new Reader("Тимошенко Илья", "5220 552266", "+7 950 107 90 80",
                "ilya", "1tt3r5",status, "R3");
        Reader user9 = new Reader("Сулейманов Самат", "5220 904566", "+7 908 080 90 80", "samat", "1q2w3e4",
                status,"R1");

        AuthorCollection authorСollection = new AuthorCollection();
        Author a = new Author("HellBoy");
        authorСollection.put(a);
        AuthorCollection authorСoll = new AuthorCollection();
        Author author1 = new Author("Asp Spreng");
        Author author2 = new Author("Pit Hammann");
        Author author3 = new Author( "墨香铜臭");
        authorСoll.put(author1);
        authorСoll.put(author2);
        authorСoll.put(author3);

        LabelCollection labelCollection = new LabelCollection();

        Book book1 = new Book("DIE KLEINE BALLADE VOM SCHWARZEN SCHMETTERLING", authorСoll, labelCollection, 123L);
        Book book2 = new Book("VARIETÉ OBSCUR", authorСollection, labelCollection,356L);
        Book book3 = new Book("DER KNOCHENMANN, DAS VÖGLEIN UND DIE NYMPHE", authorСoll, labelCollection,678L);

        BookInStock bookInStock1 = new BookInStock(2021L,123L, book1);
        BookInStock bookInStock2 = new BookInStock(2022L,1443L, book2);
        BookInStock bookInStock3 = new BookInStock(2023L,125463L, book3);

        BookInStockCollection bookiIn_1 = new BookInStockCollection();
        BookInStockCollection bookiIn_2 = new BookInStockCollection();
        bookiIn_1.put(bookInStock1);
        bookiIn_1.put(bookInStock2);
        bookiIn_2.put(bookInStock3);

         Date date1 = new Date();
         Thread.sleep(2000);
         Date date2 = new Date();
         Thread.sleep(2000);
         Date date3 = new Date();
         Order order1 = new Order(user7, bookiIn_1, "boje pomogi", date1, date2,date3,1L);
         Order order2 = new Order(user8, bookiIn_2, "bodudogi", date1, date2,date3,1L);
         Order order3 = new Order(user9, bookiIn_1, "boudud", date1, date2,date3,1L);

         orderMap.put(order1.getId(), order1);
         orderMap.put(order2.getId(),order2);
         orderMap.put(order3.getId(),order3);
         */
    }
    public Long put(Order order)
    {
        orderMap.put(order.getId(), order);
        return order.getId();
    }
    public void remove(Order order)
    {
        orderMap.remove(order.getId());
    }

    @Override
    public String toString()
    {
        return orderMap.toString();
    }

    public Iterator<Order> getOrderMapIterator()
    {
        return orderMap.values().iterator();
    }

    public Set<Long> getOrderMapKeys(){
        return orderMap.keySet();
    }

    public Collection<Order> FindAll()
    {return orderMap.values(); }

    public Collection<Order> FindOrderReaderId(Long idReader)
    {
        Map<Long, Order> readerOrders = new LinkedHashMap<>();
        for(Order o: orderMap.values()) {
            if(o.getReader().getId() != null && o.getReader().getId().equals(idReader)) {
              readerOrders.put(o.getId(), o);
            }
        }
        return readerOrders.values();
    }

    public Set<Order> findAll(Order order, String pattern)
    {
       Set<Order> orderSet = new HashSet<>();
        for (Order o: orderMap.values()){
            if ((o.getId() != null && o.getId().toString().equals(pattern))                       ||
                    (o.getReader().getReaderNumber() != null && o.getReader().getReaderNumber().equals(pattern))      ||
                   /* (o.getBookinStock() != null && (o.getBookinStock().equals(pattern)) )||* ля хз какие поля для книги боже как интеллектуально мне не нравится*/
                    (o.getStatus()      != null && o.getStatus().equals(pattern))      ||
                    (o.getBeginData()   != null && o.getBeginData().equals(pattern))   ||
                    (o.getEndData()     != null && o.getEndData().equals(pattern))     ||
                    (o.getDuration()    != null && o.getDuration().equals(pattern))    ||
                    (o.getPrice()       != null && o.getPrice().toString().equals(pattern)))
            {
                orderSet.add(o);
            }
        }
        return orderSet;
    }
}
