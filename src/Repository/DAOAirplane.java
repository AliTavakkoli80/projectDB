package Repository;

import Model.AirPlane;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

public class DAOAirplane implements Repo<AirPlane, Integer> {

    private DatabaseConnection db;

    public DAOAirplane() {
        db = new DatabaseConnection();
    }

    @Override
    public AirPlane findById(Integer integer) throws SQLException {
        AirPlane airPlane = new AirPlane();
        this.db.query("SELECT * From airplane WHERE id = ?");
        db.stmt.setInt(1, integer);
        generateAirplane(airPlane);
        return airPlane;
    }

    @Override
    public List<AirPlane> findByIDs(Collection<Integer> integers) throws SQLException {
        List<AirPlane> airPlanes = new ArrayList<AirPlane>();
        for (int integer : integers) {
            AirPlane airPlane = new AirPlane();
            this.db.query("SELECT * FROM airplane WHERE ID = " + integer);
            generateAirplane(airPlane);
            airPlanes.add(airPlane);
        }
        return airPlanes;
    }

    private void generateAirplane(AirPlane airPlane) throws SQLException {
        ResultSet rs = this.db.execute();
        rs.next();
        int id = rs.getInt("id");
        int capacity = rs.getInt("capacity");
        int max_load = rs.getInt("max_load");
        airPlane.setId(id);
        airPlane.setCapacity(capacity);
        airPlane.setMax_load(max_load);
    }

    @Override
    public List<AirPlane> findAll() throws SQLException {
        List<AirPlane> airPlanes = new ArrayList<AirPlane>();
        this.db.query("SELECT * FROM airplane");
        ResultSet rs = this.db.execute();
        while (rs.next()) {
            AirPlane airPlane = new AirPlane();
            int id = rs.getInt("id");
            int capacity = rs.getInt("capacity");
            int max_load = rs.getInt("max_load");
            airPlane.setId(id);
            airPlane.setCapacity(capacity);
            airPlane.setMax_load(max_load);
            airPlanes.add(airPlane);
        }
        return airPlanes;
    }

    @Override
    public Boolean deleteByID(Integer integer) throws SQLException {
        this.db.query("DELETE FROM airplane WHERE id = ?");
        db.stmt.setInt(1, integer);
        int numRowAff = this.db.executeUp();
        return numRowAff == 1;
    }

    @Override
    public Boolean deleteByIDs(Collection<Integer> integers) throws SQLException {
        int numRowAff = 0;
        for (int id : integers) {
            this.db.query("DELETE FROM airplane WHERE id = " + id);
            this.db.executeUp();
            numRowAff++;
        }
        return numRowAff == integers.size();
    }

    @Override
    public Boolean add(AirPlane E) throws SQLException {
        this.db.query("INSERT INTO airplane (id, capacity, max_load) VALUES(?,?,?) ");
        db.stmt.setInt(1, E.getId());
        db.stmt.setInt(2, E.getCapacity());
        db.stmt.setInt(3, E.getMax_load());
        int numRowAff = db.executeUp();
        return numRowAff == 1;
    }

    @Override
    public Boolean addAll(Collection<AirPlane> airPlanes) throws SQLException {
        int numRowAff = 0;
        for (AirPlane airPlane : airPlanes) {
            this.db.query("INSERT INTO airplane (id, capacity, max_load) VALUES(?,?,?) ");
            db.stmt.setInt(1, airPlane.getId());
            db.stmt.setInt(2, airPlane.getCapacity());
            db.stmt.setInt(3, airPlane.getMax_load());
            numRowAff += db.executeUp();
        }
        return numRowAff == airPlanes.size();
    }

    @Override
    public Boolean update(AirPlane E) throws SQLException {
        this.db.query("UPDATE airplane SET capacity = ? , max_load = ? WHERE id = ?");
        db.stmt.setInt(1, E.getCapacity());
        db.stmt.setInt(2, E.getMax_load());
        db.stmt.setInt(3, E.getId());
        int numRowAff = db.executeUp();
        return numRowAff == 1;
    }

}
