package omsu.lib_omsu.author;

import omsu.lib_omsu.label.Label;
import omsu.lib_omsu.users.User;

import java.util.*;

public class AuthorCollection
{
    private Map<Long, Author> authorMap = new LinkedHashMap<>();

    public AuthorCollection()
    {
        /*Author author1 = new Author("Asp Spreng");
        Author author2 = new Author("Pit Hammann");
        Author author3 = new Author("墨香铜臭");
        authorMap.put(author1.getId(),author1);
        authorMap.put(author2.getId(),author2);
        authorMap.put(author3.getId(),author3);*/
    }

    public Long put(Author author)
    {
        authorMap.put(author.getId(), author);
        return author.getId();
    }
    public void remove(Author author)
    {
        authorMap.remove(author.getId());
    }

    @Override
    public String toString()
    {
        return authorMap.toString();
    }

    public Iterator<Author> getAuthorMapIterator()
    {
        return authorMap.values().iterator();
    }

    public Set<Long> getAuthorMapKeys()
    {
        return authorMap.keySet();
    }

    public Collection<Author> findAll(){
        return authorMap.values();
    }
    public Author get(Long id){
        return authorMap.get(id);
    }

    public HashSet<Author> getAuthorValues() {
        System.out.println("Author="+authorMap.values());
        return new HashSet<Author>(authorMap.values());
    }

    public void setAuthorCollection(Map<Long, Author> authorMap) {
        this.authorMap = authorMap;
    }
}