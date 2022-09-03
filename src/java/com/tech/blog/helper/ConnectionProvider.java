
package com.tech.blog.helper;
import java.sql.*;

public class ConnectionProvider {
    private static  Connection con;
    
    public  static  Connection getConnection(){
    
        try {
            if(con == null){
            
                //driver class loaded
                Class.forName("com.mysql.jdbc.Driver");
                
                //create connection....
               con = DriverManager.getConnection("jdbc:mysql://localhost/techblog", "root", "");
            }
            
        } catch (Exception e) {
        }
    
    return con;
    }
    
    
}
