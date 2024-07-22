package omsu.lib_omsu.counter;

public class CounterBean {
    private int counter;

    public CounterBean() {
        counter = 0;
    }

    public int getCounter() {
        return ++counter;
    }
}