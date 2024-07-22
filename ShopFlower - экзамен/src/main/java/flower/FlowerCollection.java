package flower;

import java.util.Collection;
import java.util.HashSet;
import java.util.LinkedHashMap;
import java.util.Map;

public class FlowerCollection {

    Map<Long, Flower> flowerMap = new LinkedHashMap<>();

    public FlowerCollection() {
        /*TypeGun type1 = new TypeGun(Id.getId(),"Пистолет");
        TypeGun type2 = new TypeGun(Id.getId(),"Холодное оружие");
        Gun gun1 = new Gun("ПМ-9", type1);
        Gun gun2 = new Gun("Сабля", type2);
        Gun gun3 = new Gun("ПМ-9", new TypeGun(Id.getId(),"БЕДА"));
        gunMap.put(gun1.getId(),gun1);
        gunMap.put(gun2.getId(),gun2);
        gunMap.put(gun3.getId(),gun3);*/
    }

    public Long put(Flower flower) {
        flowerMap.put(flower.getId(), flower);
        return flower.getId();
    }

    public void add(Flower flower) {
        flowerMap.put(flower.getId(), flower);
    }

    public void remove(Flower flower) {
        flowerMap.remove(flower.getId());
    }

    public Flower get(Long id) {
        return flowerMap.get(id);
    }

    @Override
    public String toString() {
        return flowerMap.toString();
    }

    public Collection<Flower> findAll() {
        return flowerMap.values();
    }

    //Special for DataBase
    public HashSet<Flower> getFlowerValues() {
        System.out.println("flower" + flowerMap.values());
        return new HashSet<Flower>(flowerMap.values());
    }

    public void setFlowerCollection(Map<Long, Flower> flowerMap) {
        this.flowerMap = flowerMap;
    }
}
