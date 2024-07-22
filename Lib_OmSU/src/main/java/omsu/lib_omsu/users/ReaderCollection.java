package omsu.lib_omsu.users;

//import jdk.internal.access.JavaIOFileDescriptorAccess;

import omsu.lib_omsu.order.OrderCollection;

import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;

import java.util.*;

public class ReaderCollection extends UserCollection{
    Map<Long, Reader> readerMap = new LinkedHashMap<>();
    OrderCollection orderCollection;

    public ReaderCollection() {
       // orderCollection = new OrderCollection();
       /* Reader r = new Reader("Denis", "5220 904566", "+7 908 000 90 80",
                                "@denis", "1q2w3e4", "student",
                                "12345");
        readerMap.put(r.getId(), r);
        r = new Reader("Alina", "5220 554566", "+7 908 100 90 80",
                        "@alina", "1234r5", "student",
                        "56789");
        readerMap.put(r.getId(), r);
        r = new Reader("Valeria", "5220 553366", "+7 950 155 90 80",
                "@valeria", "1ttrtr5", "student",
                "13579");
        r = new Reader("Madina", "5220 552266", "+7 950 100 90 80",
                "@madina", "1tt3r5", "student",
                "13569");
        readerMap.put(r.getId(), r);*/
    }

    public Long put(Reader reader){
        readerMap.put(reader.getId(), reader);
        return reader.getId();
    }
    public void remove(Reader reader){
        readerMap.remove(reader.getId());
    }

    public Reader get(Long id){
        return readerMap.get(id);
    }

    @Override
    public String toString(){
        return readerMap.toString();
    }

    public Iterator<Reader> getReaderMapIterator(){
        return readerMap.values().iterator();
    }

    public Set<Long> getReaderMapKeys(){
        return readerMap.keySet();
    }

    public Set<Reader> findAll(Reader reader, String pattern){
        Set<Reader> readerSet = new HashSet<>();
        /*if (reader != null) {
            Set<User> userSet = new HashSet<User>();
            super.findAll(reader);*/

            for (Reader r : readerMap.values()) {
                if ((r.getName() != null && r.getName().equals(pattern)) ||
                        (r.getLogin() != null && r.getLogin().equals(pattern)) ||
                        (r.getPhoneNumber() != null && r.getPhoneNumber().equals(pattern)) ||
                        (r.getReaderNumber() != null && r.getReaderNumber().equals(pattern)) ||
                        (r.getPassport() != null && r.getPassport().equals(pattern))) {
                    readerSet.add(r);
                }
            }
        //}
        return readerSet;
    }

    public HashSet<Reader> getReaderValues() {
        System.out.println("reader="+readerMap.values());
        return new HashSet<Reader>(readerMap.values());
    }

    public void setReaderCollection(Map<Long, Reader> readerMap) {
        this.readerMap = readerMap;
    }
}
