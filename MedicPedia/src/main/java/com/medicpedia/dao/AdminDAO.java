package com.medicpedia.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.medicpedia.util.DBConnection;

public class AdminDAO {
    public boolean validateAdmin(String username, String password) {
        boolean isValid = false;
        String query = "SELECT * FROM admin_users WHERE username = ? AND password_hash = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(query)) {
             
            ps.setString(1, username);
            ps.setString(2, password);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    isValid = true;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return isValid;
    }
}
