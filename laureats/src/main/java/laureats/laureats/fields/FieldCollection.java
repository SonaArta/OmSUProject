package laureats.laureats.fields;

import java.util.Collection;
import java.util.HashSet;
import java.util.LinkedHashMap;
import java.util.Map;

public class FieldCollection {

    Map<Long, Field> fieldMap = new LinkedHashMap<>();

    public FieldCollection() {
    }

    public Long put(Field field) {
        fieldMap.put(field.getId(), field);
        return field.getId();
    }

    public void add(Field field) {
        fieldMap.put(field.getId(), field);
    }

    public void remove(Field field) {
        fieldMap.remove(field.getId());
    }

    public Field get(Long id) {
        return fieldMap.get(id);
    }

    @Override
    public String toString() {
        return fieldMap.toString();
    }

    public Collection<Field> findAll() {
        return fieldMap.values();
    }

    //Special for DataBase
    public HashSet<Field> getFieldValues() {
        System.out.println("Country=" + fieldMap.values());
        return new HashSet<Field>(fieldMap.values());
    }

    public void setFieldCollection(Map<Long, Field> countryMap) {
        this.fieldMap = fieldMap;
    }
}