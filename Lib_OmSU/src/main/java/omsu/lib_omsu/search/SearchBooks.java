package omsu.lib_omsu.search;

import omsu.lib_omsu.books.BookCollection;

public class SearchBooks {

    String stringSearch;

    String nameBook;
    String yearBook;
    String authorBook;
    String labelBook;
    String isbnBook;
    String invNumberBook;

    BookCollection resultSearch;

    public SearchBooks(String stringSearch, String nameBook, String yearBook, String authorBook, String labelBook, String isbnBook, String invNumberBook, BookCollection resultSearch){
        this.stringSearch = stringSearch;
        this.nameBook = nameBook;
        this.yearBook = yearBook;
        this.isbnBook = isbnBook;
        this.authorBook = authorBook;
        this.labelBook = labelBook;
        this.invNumberBook = invNumberBook;
        this.resultSearch = resultSearch;
    }

    public SearchBooks(String stringSearch){
        this.stringSearch = stringSearch;
        this.nameBook = " ";
        this.yearBook = " ";
        this.isbnBook = " ";
        this.authorBook = " ";
        this.labelBook = " ";
        this.invNumberBook = " ";
        this.resultSearch = null;
    }

    public SearchBooks(){
        this.stringSearch = " ";
        this.nameBook = " ";
        this.yearBook = " ";
        this.isbnBook = " ";
        this.authorBook = " ";
        this.labelBook = " ";
        this.invNumberBook = " ";
        this.resultSearch = null;
    }

    public String getStringSearch() {
        return stringSearch;
    }

    public void setStringSearch(String stringSearch) {
        this.stringSearch = stringSearch;
    }

    public String getNameBook() {
        return nameBook;
    }

    public void setNameBook(String nameBook) {
        this.nameBook = nameBook;
    }

    public String getYearBook() {
        return yearBook;
    }

    public void setYearBook(String yearBook) {
        this.yearBook = yearBook;
    }

    public String getAuthorBook() {
        return authorBook;
    }

    public void setAuthorBook(String authorBook) {
        this.authorBook = authorBook;
    }

    public String getLabelBook() {
        return labelBook;
    }

    public void setLabelBook(String labelBook) {
        this.labelBook = labelBook;
    }

    public String getIsbnBook() {
        return isbnBook;
    }

    public void setIsbnBook(String isbnBook) {
        this.isbnBook = isbnBook;
    }

    public String getInvNumberBook() {
        return invNumberBook;
    }

    public void setInvNumberBook(String invNumberBook) {
        this.invNumberBook = invNumberBook;
    }

    public BookCollection getResultSearch() {
        return resultSearch;
    }

    public void setResultSearch(BookCollection resultSearch) {
        this.resultSearch = resultSearch;
    }
}
