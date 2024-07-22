package laureats.laureats.awards;

import java.util.Collection;
import java.util.HashSet;
import java.util.LinkedHashMap;
import java.util.Map;

public class AwardsCollection {
    Map<Long, Awards> awardsMap = new LinkedHashMap<>();

    public AwardsCollection() {
    }

    public Long put(Awards awards) {
        awardsMap.put(awards.getId(), awards);
        return awards.getId();
    }

    public void add(Awards awards) {
        awardsMap.put(awards.getId(), awards);
    }

    public void remove(Awards awards) {
        awardsMap.remove(awards.getId());
    }

    public Awards get(Long id) {
        return awardsMap.get(id);
    }

    @Override
    public String toString() {
        return awardsMap.toString();
    }

    public Collection<Awards> findAll() {
        return awardsMap.values();
    }


    //для БД
    public HashSet<Awards> getAwardsValues() {
        System.out.println("gun" + awardsMap.values());
        return new HashSet<Awards>(awardsMap.values());
    }

    public void setGunCollection(Map<Long, Awards> gunMap) {
        this.awardsMap = gunMap;
    }

}
