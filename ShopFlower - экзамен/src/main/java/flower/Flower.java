package flower;

import country.Country;

public class Flower {
    private Long id = -1L;
    private String name;
    private String price;
    protected TypeFlower typeFlower;
    protected Country country;

    public Flower() {
        name = "";
        price = "";
        typeFlower = null;
        country = null;
    }

    public Flower(Flower flower) {
        this.name = flower.name;
        this.price = flower.price;
        this.typeFlower = flower.typeFlower;
        this.country = flower.country;
    }

    public Flower(String name, String price, TypeFlower typeFlower, Country country) {
        this.name = name;
        this.price = price;
        this.typeFlower = typeFlower;
        this.country = country;
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

    public String getPrice() {
        return price;
    }

    public void setPrice(String price) {
        this.price = price;
    }

    public TypeFlower getTypeFlower() {
        return typeFlower;
    }

    public void setTypeFlower(TypeFlower typeFlower) {
        this.typeFlower = typeFlower;
    }

    public Country getCountry() {
        return country;
    }

    public void setCountry(Country country) {
        this.country = country;
    }

    @Override
    public String toString() {
        return "Flower{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", price='" + price + '\'' +
                ", typeFlower=" + typeFlower +
                ", country=" + country +
                '}';
    }
}
