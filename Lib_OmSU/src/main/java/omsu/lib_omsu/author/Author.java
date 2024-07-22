package omsu.lib_omsu.author;

public class Author
{
    private Long id = -1L;
    private String name;

    public Author() {
        name = "";
    }

    public Author(String name){
        this.name = name;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public void remove(String name) {
    }
}