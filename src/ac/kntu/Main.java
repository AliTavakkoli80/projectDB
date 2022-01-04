package ac.kntu;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class Main {
    public static void main(String[] args) {
        String SQL = "SELECT * FROM account";

        DatabaseConnection databaseConnection = new DatabaseConnection();
        try (Connection conn = databaseConnection.connect();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(SQL)) {
            System.out.println(rs);

        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
    }
}
