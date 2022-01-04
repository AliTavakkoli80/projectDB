package ac.kntu;

import java.sql.SQLException;

public class Main {
    public static void main(String[] args) {

        DatabaseConnection databaseConnection = new DatabaseConnection();

        try {
            int numr = databaseConnection.rowCount("account");
            databaseConnection.
            System.out.println(numr);
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }


    }
}
