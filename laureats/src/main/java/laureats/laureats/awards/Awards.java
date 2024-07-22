package laureats.laureats.awards;

import laureats.laureats.fields.Field;

public class Awards {
    private Long id = -1L;
    private String year;
    protected Field field;

    public Awards() {
        year = "";
        field = null;
    }

    public Awards(Awards awards) {
        this.year = awards.year;
        this.field = awards.field;
    }

    public Awards(String year, Field field) {
        this.year = year;
        this.field = field;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getYear() {
        return year;
    }

    public void setYear(String year) {
        this.year = year;
    }

    public Field getField() {
        return field;
    }

    public void setField(Field field) {
        this.field = field;
    }

    @Override
    public String toString() {
        return "Awards{" + "id=" + id + ", year='" + year + '\'' + ", field=" + field + '}';
    }
}
