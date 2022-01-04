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

            while (rs.next()) {
                System.out.println(rs.getString("account_number") + "\t"
                        + rs.getString("userphone_number") + "\t"
                        + rs.getString("shaba_number") + "\t"
                        + rs.getString("balance"));

            }

        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }

    }
}
