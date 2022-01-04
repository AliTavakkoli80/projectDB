package Repository;

import Model.AirPlane;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collection;

public class Main {
    public static void main(String[] args) {

        DAOAirplane daoAirplane = new DAOAirplane();
        AirPlane airPlane = new AirPlane(1200,210,1212);

        AirPlane airPlane1 = new AirPlane(1201,210,1212);
        AirPlane airPlane2 = new AirPlane(1202,210,1212);
        AirPlane airPlane3 = new AirPlane(1203,210,1212);

        Collection<AirPlane> airPlanes = new ArrayList<>();
        airPlanes.add(airPlane1);
        airPlanes.add(airPlane2);
        airPlanes.add(airPlane3);
        Collection<Integer> ids = new ArrayList<>();
        ids.add(airPlane1.getId());
        ids.add(airPlane2.getId());
        ids.add(airPlane3.getId());
//        System.out.println(ids.toString());
        try {
            //findall test
            System.out.println(daoAirplane.findAll().toString());
            //add test
            daoAirplane.add(airPlane);
            System.out.println(daoAirplane.findAll().toString());
            //delete by id test
            daoAirplane.deleteByID(1200);
            System.out.println(daoAirplane.findAll().toString());
            //add all test
            daoAirplane.addAll(airPlanes);
            System.out.println(daoAirplane.findAll().toString());
            //find by ids test
            System.out.println(daoAirplane.findByIDs(ids).toString());
            //delete by ids test
            daoAirplane.deleteByIDs(ids);
            System.out.println(daoAirplane.findAll().toString());
            //update test
            daoAirplane.add(airPlane);
            AirPlane airPlane4 = new AirPlane(1200,2,1);
            daoAirplane.update(airPlane4);
            System.out.println(daoAirplane.findAll().toString());
            //end
            daoAirplane.deleteByID(1200);
            System.out.println(daoAirplane.findAll().toString());

        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }


    }
}
