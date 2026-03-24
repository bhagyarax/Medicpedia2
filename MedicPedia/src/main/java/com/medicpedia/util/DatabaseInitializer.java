package com.medicpedia.util;

import java.io.BufferedReader;
import java.io.FileReader;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Statement;
import java.io.File;

public class DatabaseInitializer {

    // Database credentials
    private static final String URL_NO_DB = "jdbc:mysql://localhost:3306/";
    private static final String DB_NAME = "medicpedia";
    private static final String URL_DB = "jdbc:mysql://localhost:3306/" + DB_NAME;
    private static final String USER = "root";
    private static final String PASSWORD = "sakshree";

    public static void main(String[] args) {
        System.out.println("🚀 Starting Database Initialization...");

        try {
            // Step 1: Create Database if not exists
            createDatabase();

            // Step 2: Create Table and Insert Data
            runSqlScript("insert_100_medicines.sql");

            // Step 3: Create Admin Table
            initAdminTable();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private static void createDatabase() {
        try (Connection conn = DriverManager.getConnection(URL_NO_DB, USER, PASSWORD);
             Statement stmt = conn.createStatement()) {
            
            System.out.println("Checking if database '" + DB_NAME + "' exists...");
            String sql = "CREATE DATABASE IF NOT EXISTS " + DB_NAME;
            stmt.executeUpdate(sql);
            System.out.println("✅ Database '" + DB_NAME + "' ready.");

        } catch (Exception e) {
            System.err.println("❌ Error creating database: " + e.getMessage());
            e.printStackTrace();
        }
    }

    private static void initAdminTable() {
        try (Connection conn = DriverManager.getConnection(URL_DB, USER, PASSWORD);
             Statement stmt = conn.createStatement()) {
            
            String createAdminTableSQL = "CREATE TABLE IF NOT EXISTS admin_users (" +
                    "admin_id INT AUTO_INCREMENT PRIMARY KEY, " +
                    "username VARCHAR(50) UNIQUE NOT NULL, " +
                    "password_hash VARCHAR(255) NOT NULL, " +
                    "role VARCHAR(20) DEFAULT 'admin'" +
                    ")";
            stmt.executeUpdate(createAdminTableSQL);
            System.out.println("✅ Table 'admin_users' ready.");
            
            // Check if admin exists
            java.sql.ResultSet rs = stmt.executeQuery("SELECT COUNT(*) FROM admin_users");
            if (rs.next() && rs.getInt(1) == 0) {
                String insertAdmin = "INSERT INTO admin_users (username, password_hash) VALUES ('admin', 'admin123')";
                stmt.executeUpdate(insertAdmin);
                System.out.println("✅ Default admin user created (admin / admin123).");
            }
        } catch (Exception e) {
            System.err.println("❌ Error creating admin table: " + e.getMessage());
            e.printStackTrace();
        }
    }

    private static void runSqlScript(String scriptFileName) {
        // Since we are running from project root or bin, we need to find the file
        // Default location in this project seems to be project root: c:\Users\bhagy\eclipse-workspace\MedicPedia\
        File scriptFile = new File(scriptFileName);
        
        if (!scriptFile.exists()) {
             // Try common locations if not found in root
             scriptFile = new File("src/main/webapp/" + scriptFileName);
             if (!scriptFile.exists()) {
                 scriptFile = new File("WebContent/" + scriptFileName); // older eclipse structure
             }
        }
        
        if (!scriptFile.exists()) {
            System.err.println("❌ SQL Script file not found: " + scriptFileName);
            System.err.println("Current Directory: " + System.getProperty("user.dir"));
            return;
        }

        System.out.println("Reading SQL script from: " + scriptFile.getAbsolutePath());

        try (Connection conn = DriverManager.getConnection(URL_DB, USER, PASSWORD);
             Statement stmt = conn.createStatement();
             BufferedReader br = new BufferedReader(new FileReader(scriptFile))) {
            
            // This simple parser handles the INSERT statements which might span multiple lines
            // But for simple scripts, we can read the whole file and split by semicolon?
            // "insert_100_medicines.sql" contains Creates? No, just inserts and USE.
            // Let's create the table first just in case.
            
            // Create Table Logic (Hardcoded to ensure it works even if SQL script is just INSERTs)
            String createTableSQL = "CREATE TABLE IF NOT EXISTS medicines (" +
                    "id INT AUTO_INCREMENT PRIMARY KEY, " +
                    "name VARCHAR(255) NOT NULL, " +
                    "image_path VARCHAR(255), " +
                    "uses TEXT, " +
                    "side_effects TEXT, " +
                    "precautions TEXT, " +
                    "min_age INT, " +
                    "max_age INT, " +
                    "pregnancy_warning BOOLEAN, " +
                    "risk_level VARCHAR(50)" +
                    ")";
            stmt.executeUpdate(createTableSQL);
            System.out.println("✅ Table 'medicines' ready.");
            
            // Now run the script. The script has "USE medicpedia" which might fail if we are connected to it? No, it's fine.
            // But executing "USE medicpedia" via JDBC is sometimes ignored or weird. We are already connected to it.
            
            StringBuilder sb = new StringBuilder();
            String line;
            while ((line = br.readLine()) != null) {
                // Skip comments and empty lines
                if (line.trim().startsWith("--") || line.trim().isEmpty()) {
                    continue;
                }
                sb.append(line + "\n");
                
                // Extremely simple SQL splitter: strictly by semicolon
                if (line.trim().endsWith(";")) {
                    String command = sb.toString().trim();
                    try {
                        if (!command.toUpperCase().startsWith("USE")) { // Skip USE command
                             stmt.execute(command);
                        }
                    } catch (Exception e) {
                        System.err.println("Warning executing: " + command.substring(0, Math.min(50, command.length())) + "...");
                        System.err.println(e.getMessage());
                    }
                    sb = new StringBuilder();
                }
            }
            System.out.println("✅ SQL Script executed successfully! Row count: " + getRowCount(stmt));

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    private static int getRowCount(Statement stmt) {
        try {
            java.sql.ResultSet rs = stmt.executeQuery("SELECT COUNT(*) FROM medicines");
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception e) {}
        return 0;
    }
}
