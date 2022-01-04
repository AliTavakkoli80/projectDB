package ac.kntu;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class Main {
    public static void main(String[] args) {
        DatabaseConnection databaseConnection = new DatabaseConnection();
        Connection conn = databaseConnection.connect();
        PreparedStatement st = conn.prepareStatement("SELECT * FROM mytable");
        ResultSet rs = st.executeQuery();
        while (rs.next())
        {
            System.out.print("Column 1 returned ");
            System.out.println(rs.getString(1));
        }
        rs.close();
        st.close();
    }
}
