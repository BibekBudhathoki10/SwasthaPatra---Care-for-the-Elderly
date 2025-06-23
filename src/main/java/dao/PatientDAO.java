package dao;

import model.Patient;
import util.DatabaseUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class PatientDAO {

    public Patient findById(int patientId) {
        String sql = "SELECT * FROM patients WHERE patient_id = ? AND is_active = TRUE";
        
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, patientId);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                return mapResultSetToPatient(rs);
            }
        } catch (SQLException e) {
            System.err.println("Error finding patient by ID: " + e.getMessage());
        }
        return null;
    }

    public Patient findByCitizenId(String citizenId) {
        String sql = "SELECT * FROM patients WHERE citizen_id = ? AND is_active = TRUE";
        
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, citizenId);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                return mapResultSetToPatient(rs);
            }
        } catch (SQLException e) {
            System.err.println("Error finding patient by citizen ID: " + e.getMessage());
        }
        return null;
    }

    public boolean save(Patient patient) {
        String sql = "INSERT INTO patients (citizen_id, first_name, last_name, date_of_birth, gender, address, ward_no, phone, emergency_contact_name, emergency_contact_phone, blood_group, height, weight, qr_code, is_active) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            
            stmt.setString(1, patient.getCitizenId());
            stmt.setString(2, patient.getFirstName());
            stmt.setString(3, patient.getLastName());
            stmt.setDate(4, patient.getDateOfBirth());
            stmt.setString(5, patient.getGender());
            stmt.setString(6, patient.getAddress());
            stmt.setInt(7, patient.getWardNo());
            stmt.setString(8, patient.getPhone());
            stmt.setString(9, patient.getEmergencyContactName());
            stmt.setString(10, patient.getEmergencyContactPhone());
            stmt.setString(11, patient.getBloodGroup());
            stmt.setBigDecimal(12, patient.getHeight());
            stmt.setBigDecimal(13, patient.getWeight());
            stmt.setString(14, patient.getQrCode());
            stmt.setBoolean(15, patient.isActive());
            
            int rowsAffected = stmt.executeUpdate();
            
            if (rowsAffected > 0) {
                ResultSet generatedKeys = stmt.getGeneratedKeys();
                if (generatedKeys.next()) {
                    patient.setPatientId(generatedKeys.getInt(1));
                }
                return true;
            }
        } catch (SQLException e) {
            System.err.println("Error saving patient: " + e.getMessage());
        }
        return false;
    }

    public boolean update(Patient patient) {
        String sql = "UPDATE patients SET citizen_id = ?, first_name = ?, last_name = ?, date_of_birth = ?, gender = ?, address = ?, ward_no = ?, phone = ?, emergency_contact_name = ?, emergency_contact_phone = ?, blood_group = ?, height = ?, weight = ?, qr_code = ?, is_active = ? WHERE patient_id = ?";
        
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, patient.getCitizenId());
            stmt.setString(2, patient.getFirstName());
            stmt.setString(3, patient.getLastName());
            stmt.setDate(4, patient.getDateOfBirth());
            stmt.setString(5, patient.getGender());
            stmt.setString(6, patient.getAddress());
            stmt.setInt(7, patient.getWardNo());
            stmt.setString(8, patient.getPhone());
            stmt.setString(9, patient.getEmergencyContactName());
            stmt.setString(10, patient.getEmergencyContactPhone());
            stmt.setString(11, patient.getBloodGroup());
            stmt.setBigDecimal(12, patient.getHeight());
            stmt.setBigDecimal(13, patient.getWeight());
            stmt.setString(14, patient.getQrCode());
            stmt.setBoolean(15, patient.isActive());
            stmt.setInt(16, patient.getPatientId());
            
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error updating patient: " + e.getMessage());
        }
        return false;
    }

    public List<Patient> findAll() {
        List<Patient> patients = new ArrayList<>();
        String sql = "SELECT * FROM patients WHERE is_active = TRUE ORDER BY created_at DESC";
        
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            
            while (rs.next()) {
                patients.add(mapResultSetToPatient(rs));
            }
        } catch (SQLException e) {
            System.err.println("Error finding all patients: " + e.getMessage());
        }
        return patients;
    }

    public List<Patient> searchPatients(String searchTerm) {
        List<Patient> patients = new ArrayList<>();
        String sql = "SELECT * FROM patients WHERE is_active = TRUE AND (first_name LIKE ? OR last_name LIKE ? OR citizen_id LIKE ?) ORDER BY first_name, last_name";
        
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            String searchPattern = "%" + searchTerm + "%";
            stmt.setString(1, searchPattern);
            stmt.setString(2, searchPattern);
            stmt.setString(3, searchPattern);
            
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                patients.add(mapResultSetToPatient(rs));
            }
        } catch (SQLException e) {
            System.err.println("Error searching patients: " + e.getMessage());
        }
        return patients;
    }

    public List<Patient> findByWard(int wardNo) {
        List<Patient> patients = new ArrayList<>();
        String sql = "SELECT * FROM patients WHERE ward_no = ? AND is_active = TRUE ORDER BY first_name, last_name";
        
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, wardNo);
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                patients.add(mapResultSetToPatient(rs));
            }
        } catch (SQLException e) {
            System.err.println("Error finding patients by ward: " + e.getMessage());
        }
        return patients;
    }

    public boolean delete(int patientId) {
        String sql = "UPDATE patients SET is_active = FALSE WHERE patient_id = ?";
        
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, patientId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error deleting patient: " + e.getMessage());
        }
        return false;
    }

    public int getTotalPatients() {
        String sql = "SELECT COUNT(*) FROM patients WHERE is_active = TRUE";
        
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            System.err.println("Error getting total patients count: " + e.getMessage());
        }
        return 0;
    }

    private Patient mapResultSetToPatient(ResultSet rs) throws SQLException {
        Patient patient = new Patient();
        patient.setPatientId(rs.getInt("patient_id"));
        patient.setCitizenId(rs.getString("citizen_id"));
        patient.setFirstName(rs.getString("first_name"));
        patient.setLastName(rs.getString("last_name"));
        patient.setDateOfBirth(rs.getDate("date_of_birth"));
        patient.setGender(rs.getString("gender"));
        patient.setAddress(rs.getString("address"));
        patient.setWardNo(rs.getInt("ward_no"));
        patient.setPhone(rs.getString("phone"));
        patient.setEmergencyContactName(rs.getString("emergency_contact_name"));
        patient.setEmergencyContactPhone(rs.getString("emergency_contact_phone"));
        patient.setBloodGroup(rs.getString("blood_group"));
        patient.setHeight(rs.getBigDecimal("height"));
        patient.setWeight(rs.getBigDecimal("weight"));
        patient.setQrCode(rs.getString("qr_code"));
        patient.setRegistrationDate(rs.getDate("registration_date"));
        patient.setActive(rs.getBoolean("is_active"));
        patient.setCreatedAt(rs.getTimestamp("created_at"));
        patient.setUpdatedAt(rs.getTimestamp("updated_at"));
        return patient;
    }
}
