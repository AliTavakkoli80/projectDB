package Repository;

import java.sql.*;


public class DatabaseConnection {

    private final String url = "jdbc:postgresql://localhost/alibaba";
    private final String user = "postgres";
    private final String password = "ali-1380-";

    private Connection connection;
    private String error;

    public PreparedStatement stmt;
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
    public void query(String query) throws SQLException {
        this.stmt = this.connection.prepareStatement(query,
                ResultSet.TYPE_SCROLL_SENSITIVE,
                ResultSet.CONCUR_UPDATABLE);
    }

    //Execute the Prepared Statement get result set as Array of Objects
    public ResultSet execute() throws SQLException {
        return this.stmt.executeQuery();
    }
    public int executeUp() throws SQLException {
        return this.stmt.executeUpdate();
    }

    //Get Record Row Count
    public int rowCount(String tableName) throws SQLException {
        String countQuery = "SELECT * FROM " + tableName;
        query(countQuery);
        ResultSet rs = execute();
        rs.last();
        return rs.getRow();

    }

    public String getError() {
        return this.error;
    }

    public boolean isDbconnected() {
        return this.dbconnected;
    }
}