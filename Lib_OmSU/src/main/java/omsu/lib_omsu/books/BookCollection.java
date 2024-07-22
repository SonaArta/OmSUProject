package omsu.lib_omsu.books;

import omsu.lib_omsu.author.Author;
import omsu.lib_omsu.author.AuthorCollection;
import omsu.lib_omsu.label.Label;
import omsu.lib_omsu.label.LabelCollection;
import omsu.lib_omsu.users.User;
import omsu.lib_omsu.users.UserStatus;

import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.Objects;
import java.util.*;

public class BookCollection
{
    private Map<Long, Book> bookMap = new LinkedHashMap<>();
    private AuthorCollection authorСollection = new AuthorCollection();
    private LabelCollection labelCollection = new LabelCollection();

    public BookCollection()
    {
        /*AuthorCollection authorСoll = new AuthorCollection();
        LabelCollection labelColl = new LabelCollection();
        Author a = new Author("test_name");
        authorСoll.put(a);
        Label l = new Label("test_label");
        labelColl.put(l);

        Book book1 = new Book("DIE KLEINE BALLADE VOM SCHWARZEN SCHMETTERLING", authorСoll, labelColl, 123L);
        Book book2 = new Book("VARIETÉ OBSCUR", authorСollection, labelCollection,356L);
        Book book3 = new Book("DER KNOCHENMANN, DAS VÖGLEIN UND DIE NYMPHE", authorСollection, labelCollection,678L);
        Book book4 = new Book("NIE AM TAGE", authorСollection, labelCollection, 8910L);
        Book book5 = new Book("АЛИНА МЕНЯ ОБИДЕЛА НИКАКОГО УВАЖЕНИЯ В ЭТОЙ ГРУППЕ",authorСollection, labelCollection, 8910L);

        bookMap.put(book1.getId(),book1);
        bookMap.put(book2.getId(),book2);
        bookMap.put(book3.getId(),book3);
        bookMap.put(book4.getId(),book4);
        bookMap.put(book5.getId(),book5);*/
        //put(book2);
        //put(book3);
        //put(book4);
        //put(book5);
    }

    public Long put(Book book)
    {
        bookMap.put(book.getId(), book);
        return book.getId();
    }


    public Book get(Long id){
        return bookMap.get(id);
    }

    public void remove(Book book)
    {
        bookMap.remove(book.getId());
    }

    @Override
    public String toString()
    {
        return bookMap.toString();
    }

    public Iterator<Book> getBookMapIterator()
    {
        return bookMap.values().iterator();
    }

    public Set<Long> getBookMapKeys()
    {
        return bookMap.keySet();
    }

    public Collection<Book> FindAll(){
        return bookMap.values();
    }

    public HashSet<Book> getBookValues() {
        System.out.println("book="+bookMap.values());
        return new HashSet<Book>(bookMap.values());
    }

    public void setBookCollection(Map<Long, Book> bookMap) {
        this.bookMap = bookMap;
    }

}