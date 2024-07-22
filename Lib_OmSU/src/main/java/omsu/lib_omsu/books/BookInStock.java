package omsu.lib_omsu.books;
import omsu.lib_omsu.books.*;

import java.util.*;

public class BookInStock
{
    private Long id = -1L;
    private Long year;
    private Long invNumber;
    private Book book;
    
    public BookInStock(Long year, Long invNumber, Book book)
    {
        this.year = year;
        this.invNumber = invNumber;
        this.book = book;
    }
    
    public Long getId()
    {
        return id;
    }
    
    public Long getInvNumber()
    {
        return invNumber;
    }
    
    public Long getYear()
    {
    	return year;
    }

    public Book getBook()
    {
    	return book;
    }

    public void setId(Long id)
    {
    	this.id = id;
    }

    public void setYear(Long year)
    {
    	this.year = year;
    }

    public void setInvNumber(Long invNumber)
    {
    	this.invNumber = invNumber;
    }

    public void setBook(Book book)
    {
    	this.book = book;
    }
    
}
