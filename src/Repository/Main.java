package Repository;

import java.sql.ResultSet;
import java.sql.SQLException;

public class Main {
    public static void main(String[] args) {

        DatabaseConnection databaseConnection = new DatabaseConnection();

        try {
            int numr = databaseConnection.rowCount("airplane");
            System.out.println(numr);

            databaseConnection.query("INSERT INTO airplane(id,capacity,max_load) VALUES(?,?,?)");
            databaseConnection.stmt.setInt(1, 12);
            databaseConnection.stmt.setInt(2, 5000);
            databaseConnection.stmt.setInt(3, 12000);
            ResultSet rs =databaseConnection.execute();

            while (rs.next()) {
                System.out.println(rs.getString("id") + "\t"
                        + rs.getString("capacity") + "\t"
                        + rs.getString("max_load"));

            }

        } catch (SQLException throwables) {
            System.out.println(databaseConnection.getError());
            ;
        }


    }
}
