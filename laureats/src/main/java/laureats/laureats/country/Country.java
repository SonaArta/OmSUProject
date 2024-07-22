package laureats.laureats.country;


public class Country {
    private Long id = -1L;
    private String countryName = "";

    public Country() {
        countryName = "";
    }

    public Country(String countryName) {
        this.countryName = countryName;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getCountryName() {
        return countryName;
    }

    public void setCountryName(String countryName) {
        this.countryName = countryName;
    }

    @Override
    public String toString() {
        return "Country{" + "id=" + id + ", countryName='" + countryName + '\'' + '}';
    }
}
