package flower;

public class TypeFlower {
    private Long id = -1L;
    private String typeName = "";

    public TypeFlower() {
        typeName = "";
    }

    public TypeFlower(String typeName) {
        this.typeName = typeName;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getTypeName() {
        return typeName;
    }

    public void setTypeName(String typeName) {
        this.typeName = typeName;
    }

    @Override
    public String toString() {
        return "TypeFlower{" + "id=" + id + ", typeName='" + typeName + '\'' + '}';
    }
}
