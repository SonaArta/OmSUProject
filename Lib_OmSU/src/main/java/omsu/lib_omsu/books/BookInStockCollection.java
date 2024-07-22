package omsu.lib_omsu.books;
import omsu.lib_omsu.books.*;
import java.util.*;

public class BookInStockCollection
{
    private Map<Long, BookInStock> bookMap = new HashMap<>();
    private int bookAmount;
    
    public BookInStockCollection()
    {
        bookAmount = 0;
    }
    
    public Long put(BookInStock book)
    {
        bookMap.put(book.getId(), book);
        bookAmount++;
        return book.getId();
    }
    
    public void remove(BookInStock book)
    {
        bookMap.remove(book.getId());
        bookAmount--;
    }

    public Collection<BookInStock> FindAll(){
        return bookMap.values();
    }
}