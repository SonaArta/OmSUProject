package laureats.laureats.fields;

public class Field {
    private Long id = -1L;
    private String fieldName = "";

    public Field() {
        fieldName = "";
    }

    public Field(String fieldName) {
        this.fieldName = fieldName;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getFieldName() {
        return fieldName;
    }

    public void setFieldName(String fieldName) {
        this.fieldName = fieldName;
    }

    @Override
    public String toString() {
        return "Country{" + "id=" + id + ",fieldName='" + fieldName + '\'' + '}';
    }
}
