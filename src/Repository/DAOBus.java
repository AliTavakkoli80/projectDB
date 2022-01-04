package Repository;

import Model.Bus;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

public class DAOBus implements Repo<Bus, Integer> {
    private DatabaseConnection db;

    public DAOBus() {
        db = new DatabaseConnection();
    }

    @Override
    public Bus findById(Integer integer) throws SQLException {
        Bus bus = new Bus();
        this.db.query("SELECT * From bus WHERE id = ?");
        db.stmt.setInt(1, integer);
        generateBus(bus);
        return bus;
    }

    @Override
    public List<Bus> findByIDs(Collection<Integer> integers) throws SQLException {
        List<Bus> buses = new ArrayList<Bus>();
        for (int integer : integers) {
            Bus bus = new Bus();
            this.db.query("SELECT * FROM bus WHERE ID = " + integer);
            generateBus(bus);
            buses.add(bus);
        }
        return buses;
    }

    @Override
    public List<Bus> findAll() throws SQLException {
        List<Bus> buses = new ArrayList<Bus>();
        this.db.query("SELECT * FROM bus");
        ResultSet rs = this.db.execute();
        while (rs.next()) {
            Bus bus = new Bus();
            int id = rs.getInt("bus_id");
            int busCapacity = rs.getInt("bus_capacity");
            boolean isVip = rs.getBoolean("is_vip");
            bus.setBus_id(id);
            bus.setBus_capacity(busCapacity);
            bus.setIs_vip(isVip);
            buses.add(bus);
        }
        return buses;
    }

    @Override
    public Boolean deleteByID(Integer integer) throws SQLException {
        this.db.query("DELETE FROM bus WHERE id = ?");
        db.stmt.setInt(1, integer);
        int numRowAff = this.db.executeUp();
        return numRowAff == 1;
    }

    @Override
    public Boolean deleteByIDs(Collection<Integer> integers) throws SQLException {
        int numRowAff = 0;
        for (int id : integers) {
            this.db.query("DELETE FROM bus WHERE id = " + id);
            this.db.executeUp();
            numRowAff++;
        }
        return numRowAff == integers.size();
    }

    @Override
    public Boolean add(Bus E) throws SQLException {
        this.db.query("INSERT INTO bus (bus_id, bus_capacity, is_vip) VALUES(?,?,?) ");
        db.stmt.setInt(1, E.getBus_id());
        db.stmt.setInt(2, E.getBus_capacity());
        db.stmt.setBoolean(3, E.isIs_vip());
        int numRowAff = db.executeUp();
        return numRowAff == 1;
    }

    @Override
    public Boolean addAll(Collection<Bus> buses) throws SQLException {
        int numRowAff = 0;
        for (Bus airPlane : buses) {
            this.db.query("INSERT INTO bus (bus_id, bus_capacity, is_vip) VALUES(?,?,?) ");
            db.stmt.setInt(1, airPlane.getBus_id());
            db.stmt.setInt(2, airPlane.getBus_capacity());
            db.stmt.setBoolean(3, airPlane.isIs_vip());
            numRowAff += db.executeUp();
        }
        return numRowAff == buses.size();
    }

    @Override
    public Boolean update(Bus E) throws SQLException {
        this.db.query("UPDATE bus SET bus_capacity = ? , is_vip = ? WHERE id = ?");
        db.stmt.setInt(1, E.getBus_capacity());
        db.stmt.setBoolean(2, E.isIs_vip());
        db.stmt.setInt(3, E.getBus_id());
        int numRowAff = db.executeUp();
        return numRowAff == 1;
    }

    private void generateBus(Bus bus) throws SQLException {
        ResultSet rs = this.db.execute();
        rs.next();
        int id = rs.getInt("bus_id");
        int busCapacity = rs.getInt("bus_capacity");
        boolean isVip = rs.getBoolean("is_vip");
        bus.setBus_id(id);
        bus.setBus_capacity(busCapacity);
        bus.setIs_vip(isVip);
    }

}
