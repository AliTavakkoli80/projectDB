package Model;

public class AirPlane {
    private int id;
    private int capacity;
    private int max_load;

    public AirPlane(int id, int capacity, int max_load) {
        this.id = id;
        this.capacity = capacity;
        this.max_load = max_load;
    }
    public AirPlane(){
    }


    public int getId() {
        return id;
    }

    public int getCapacity() {
        return capacity;
    }

    public int getMax_load() {
        return max_load;
    }

    public void setId(int id) {
        this.id = id;
    }

    public void setCapacity(int capacity) {
        this.capacity = capacity;
    }

    public void setMax_load(int max_load) {
        this.max_load = max_load;
    }

    @Override
    public String toString() {
        return "AirPlane{" +
                "id=" + id +
                ", capacity=" + capacity +
                ", max_load=" + max_load +
                '}';
    }
}
