package cz.uhk.fim.dbs2dataflow.service;

import org.springframework.stereotype.Service;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Types;

@Service
public class CelkovaSpotrebaService {
    /*public float getCelkovaSpotreba(int tovarnaID){
        //Registering the Driver
        DriverManager.registerDriver(new com.mysql.jdbc.Driver());
        //Getting the connection
        String mysqlUrl = "jdbc:mysql://localhost/mydatabase";
        Connection con = DriverManager.getConnection(mysqlUrl, "root", "password");
        System.out.println("Connection established......");
        //Preparing a CallableStatement to call a function
        CallableStatement cstmt = con.prepareCall("{? = call getDob(?)}");
        //Registering the out parameter of the function (return type)
        cstmt.registerOutParameter(1, Types.FLOAT);
        //Setting the input parameters of the function
        cstmt.setString(2, "Amit");
        //Executing the statement
        cstmt.execute();
        System.out.print("Date of birth: "+cstmt.getDate(1));
    }*/
}
