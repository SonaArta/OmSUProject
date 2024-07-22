package flower;

import java.util.Collection;
import java.util.HashSet;
import java.util.LinkedHashMap;
import java.util.Map;

public class TypeFlowerCollection {
    Map<Long, TypeFlower> typeFlowerMap = new LinkedHashMap<>();

    public TypeFlowerCollection() {
    }

    public Long put(TypeFlower typeFlower) {
        typeFlowerMap.put(typeFlower.getId(), typeFlower);
        return typeFlower.getId();
    }

    public void add(TypeFlower typeFlower) {
        typeFlowerMap.put(typeFlower.getId(), typeFlower);
    }

    public void remove(TypeFlower typeFlower) {
        typeFlowerMap.remove(typeFlower.getId());
    }

    public TypeFlower get(Long id) {
        return typeFlowerMap.get(id);
    }

    @Override
    public String toString() {
        return typeFlowerMap.toString();
    }

    public Collection<TypeFlower> findAll() {
        return typeFlowerMap.values();
    }

    //Special for DataBase
    public HashSet<TypeFlower> getTypeGunValues() {
        System.out.println("typeFlower=" + typeFlowerMap.values());
        return new HashSet<TypeFlower>(typeFlowerMap.values());
    }

    public void setTypeFlowerCollection(Map<Long, TypeFlower> typeFlowerMap) {
        this.typeFlowerMap = typeFlowerMap;
    }
}
