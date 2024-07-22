package omsu.lib_omsu.books;

import omsu.lib_omsu.author.AuthorCollection;
import omsu.lib_omsu.label.*;

import java.util.Collection;
import java.util.Objects;

public class Book
{
    private Long id = -1L;
    private String name;
    private String isbn;
    private AuthorCollection authorCollection;
    private LabelCollection labelCollection;

    public Book() {
        name = "";
        isbn = "";
        authorCollection = null;
        labelCollection = null;
    }
    public Book(String name, String isbn,
                AuthorCollection authorCollection, LabelCollection labelCollection)
    {
        this.name = name;
        this.isbn = isbn;
        this.authorCollection = authorCollection;
        this.labelCollection = labelCollection;
    }

    public Book(String name, String isbn, Collection<String> authorCollection, Collection<String> labelCollection) {
        this.name = name;
        this.isbn = isbn;
        this.authorCollection = (AuthorCollection) authorCollection;
        this.labelCollection = (LabelCollection) labelCollection;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public AuthorCollection getAuthorCollection() {
        return authorCollection;
    }

    public void setAuthorCollection(AuthorCollection authorCollection) {
        this.authorCollection = authorCollection;
    }

    public LabelCollection getLabelCollection() {
        return labelCollection;
    }

    public void setLabelCollection(LabelCollection labelCollection) {
        this.labelCollection = labelCollection;
    }

    public String getIsbn() {
        return isbn;
    }

    public void setIsbn(String isbn) {
        this.isbn = isbn;
    }

    public void setBook(Book book){
        this.id = book.getId();
        this.name = book.getName();
        this.isbn = book.getIsbn();
        this.authorCollection = book.getAuthorCollection();
        this.labelCollection = book.getLabelCollection();
    }

    @Override
    public String toString() {
        return "Book{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", authorCollection=" + authorCollection +
                ", labelCollection=" + labelCollection +
                ", isbn=" + isbn +
                '}';
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Book book = (Book) o;
        return id.equals(book.id) && name.equals(book.name) && isbn.equals(book.isbn) && authorCollection.equals(book.authorCollection) && labelCollection.equals(book.labelCollection);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id, name, isbn, authorCollection, labelCollection);
    }
}
