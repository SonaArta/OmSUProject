package laureats.laureats.country;

import java.util.Collection;
import java.util.HashSet;
import java.util.LinkedHashMap;
import java.util.Map;

public class CountryCollection {
    Map<Long, Country> countryMap = new LinkedHashMap<>();

    public CountryCollection() {
    }

    public Long put(Country country) {
        countryMap.put(country.getId(), country);
        return country.getId();
    }

    public void add(Country country) {
        countryMap.put(country.getId(), country);
    }

    public void remove(Country country) {
        countryMap.remove(country.getId());
    }

    public Country get(Long id) {
        return countryMap.get(id);
    }

    @Override
    public String toString() {
        return countryMap.toString();
    }

    public Collection<Country> findAll() {
        return countryMap.values();
    }

    //Special for DataBase
    public HashSet<Country> getCountryValues() {
        System.out.println("Country=" + countryMap.values());
        return new HashSet<Country>(countryMap.values());
    }

    public void setCountryCollection(Map<Long, Country> countryMap) {
        this.countryMap = countryMap;
    }
}