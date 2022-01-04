package Model;

public class Bus {
    private int bus_id;
    private int bus_capacity;
    private boolean is_vip;

    public Bus(int bus_id, int bus_capacity, boolean is_vip) {
        this.bus_id = bus_id;
        this.bus_capacity = bus_capacity;
        this.is_vip = is_vip;
    }

    public int getBus_id() {
        return bus_id;
    }

    public void setBus_id(int bus_id) {
        this.bus_id = bus_id;
    }

    public int getBus_capacity() {
        return bus_capacity;
    }

    public void setBus_capacity(int bus_capacity) {
        this.bus_capacity = bus_capacity;
    }

    public boolean isIs_vip() {
        return is_vip;
    }

    public void setIs_vip(boolean is_vip) {
        this.is_vip = is_vip;
    }
}
