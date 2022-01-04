package ac.kntu;

import java.sql.SQLException;

public class Main {
    public static void main(String[] args) {

        DatabaseConnection databaseConnection = new DatabaseConnection();

        try {
            int numr = databaseConnection.rowCount("account");
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }


    }
}
