package com.medicpedia.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import com.medicpedia.model.Medicine;
import com.medicpedia.util.DBConnection;

public class MedicineDAO {

    public boolean addMedicine(Medicine med) {
        String sql = "INSERT INTO medicines (name, image_path, uses, side_effects, precautions, min_age, max_age, pregnancy_warning, risk_level) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, med.getName());
            ps.setString(2, med.getImagePath());
            ps.setString(3, med.getUses());
            ps.setString(4, med.getSideEffects());
            ps.setString(5, med.getPrecautions());
            ps.setInt(6, med.getMinAge());
            ps.setInt(7, med.getMaxAge());
            ps.setBoolean(8, med.isPregnancyWarning());
            ps.setString(9, med.getRiskLevel());
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean updateMedicine(Medicine med) {
        String sql = "UPDATE medicines SET name=?, image_path=?, uses=?, side_effects=?, precautions=?, min_age=?, max_age=?, pregnancy_warning=?, risk_level=? WHERE medicine_id=?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, med.getName());
            ps.setString(2, med.getImagePath());
            ps.setString(3, med.getUses());
            ps.setString(4, med.getSideEffects());
            ps.setString(5, med.getPrecautions());
            ps.setInt(6, med.getMinAge());
            ps.setInt(7, med.getMaxAge());
            ps.setBoolean(8, med.isPregnancyWarning());
            ps.setString(9, med.getRiskLevel());
            ps.setInt(10, med.getId());
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean deleteMedicine(int id) {
        String sql = "DELETE FROM medicines WHERE medicine_id=?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public Medicine getMedicineById(int id) {
        String sql = "SELECT * FROM medicines WHERE medicine_id=?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new Medicine(
                        rs.getInt("medicine_id"),
                        rs.getString("name"),
                        rs.getString("image_path"),
                        rs.getString("uses"),
                        rs.getString("side_effects"),
                        rs.getString("precautions"),
                        rs.getInt("min_age"),
                        rs.getInt("max_age"),
                        rs.getBoolean("pregnancy_warning"),
                        rs.getString("risk_level")
                    );
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
}
