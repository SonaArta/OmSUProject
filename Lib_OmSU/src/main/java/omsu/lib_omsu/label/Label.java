package omsu.lib_omsu.label;

public class Label
{
    private Long id = -1L;
    private String name;

    public Label() {
        name = "";
    }
    public Label(String name)
    {
        this.name = name;
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
}