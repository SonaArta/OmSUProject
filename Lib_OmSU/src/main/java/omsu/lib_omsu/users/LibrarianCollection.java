package omsu.lib_omsu.users;

import java.util.HashMap;
import java.util.Map;
import java.util.*;


public class LibrarianCollection {
    private Map<Long, Librarian> librarianMap = new LinkedHashMap<>();
    private int librarianAmount;

    public LibrarianCollection() {
        /*Librarian l = new Librarian("Denis", "5220 904566", "+7 908 000 90 80",
                "@denis", "1q2w3e4", "12345");
        librarianMap.put(l.getId(), l);
        l = new Librarian("Alina", "5220 554566", "+7 908 100 90 80",
                "@alina", "1234r5",                 "56789");
        librarianMap.put(l.getId(), l);
        l = new Librarian("Madina", "5220 552266", "+7 950 100 90 80",
                "@madina", "1tt3r5",                 "13569");
        librarianMap.put(l.getId(), l);


        if(l instanceof Librarian) {}
        if(l.getClass().getSimpleName().equals("Reader")){}*/
    }

    public Long put(Librarian librarian){
        librarianMap.put(librarian.getId(), librarian);
        return librarian.getId();
    }
    public void remove(Librarian librarian){
        librarianMap.remove(librarian.getId());
    }

    @Override
    public String toString(){
        return librarianMap.toString();
    }

    public Iterator<Librarian> getLibrarianMapIterator(){
        return librarianMap.values().iterator();
    }

    public Set<Long> getLibrarianMapKeys(){
        return librarianMap.keySet();
    }

    public Set<Librarian> findAll(String pattern){
        Set<Librarian> librarianSet = new HashSet<>();
        for (Librarian l : librarianMap.values()){
            if ((l.getName()!=null && l.getName().equals(pattern)) ||
                    (l.getLogin()!=null && l.getLogin().equals(pattern))||
                    (l.getPhoneNumber()!=null && l.getPhoneNumber().equals(pattern)) ||
                    (l.getTabelNumber()!=null && l.getTabelNumber().equals(pattern)) ||
                    (l.getPassport()!=null && l.getPassport().equals(pattern))) {
                librarianSet.add(l);
            }
        }
        return librarianSet;
    }

    public HashSet<Librarian> getLibValues() {
        System.out.println("librarian="+librarianMap.values());
        return new HashSet<Librarian>(librarianMap.values());
    }

    public void setLibCollection(Map<Long, Librarian> librarianMap) {
        this.librarianMap = librarianMap;
    }

}



