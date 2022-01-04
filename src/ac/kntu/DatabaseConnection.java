package ac.kntu;

import java.sql.*;


public class DatabaseConnection {

    private final String url = "jdbc:postgresql://localhost/alibaba";
    private final String user = "postgres";
    private final String password = "ali-1380-";

    private Connection connection;
    private String error;
    private PreparedStatement stmt;
    private boolean dbconnected;

    public DatabaseConnection() {
        this.error = "";
        try {
            this.connection = DriverManager.getConnection(url, user, password);
            System.out.println("Connected to the PostgreSQL server successfully.");
            this.dbconnected = true;
        } catch (SQLException e) {
            System.out.println(e.getMessage());
            this.error += e.getMessage();
            this.dbconnected = false;
        }

    }

    //Prepare Statement with Query
    public void query(String query)
    {
        try {
            this.stmt = this.connection.prepareStatement(query);
        } catch (SQLException e) {
            System.out.println(e.getMessage());
            this.error += e.getMessage();
            this.dbconnected = false;
        }
    }


}