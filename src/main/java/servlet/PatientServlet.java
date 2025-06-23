package servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import dao.PatientDAO;
import model.Patient;
import util.SessionUtil;

import java.io.IOException;
import java.sql.Date;
import java.math.BigDecimal;
import java.util.List;

@WebServlet({"/patients", "/patients/new", "/patients/edit", "/patients/view", "/patients/delete"})
public class PatientServlet extends HttpServlet {
    private PatientDAO patientDAO;

    @Override
    public void init() throws ServletException {
        patientDAO = new PatientDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = getAction(request);
        
        switch (action) {
            case "list":
                handleList(request, response);
                break;
            case "new":
                handleNew(request, response);
                break;
            case "edit":
                handleEdit(request, response);
                break;
            case "view":
                handleView(request, response);
                break;
            case "delete":
                handleDelete(request, response);
                break;
            default:
                handleList(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = getAction(request);
        
        switch (action) {
            case "new":
                handleCreate(request, response);
                break;
            case "edit":
                handleUpdate(request, response);
                break;
            default:
                response.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED);
        }
    }

    private String getAction(HttpServletRequest request) {
        String pathInfo = request.getPathInfo();
        if (pathInfo == null || pathInfo.equals("/")) {
            return "list";
        }
        return pathInfo.substring(1); // Remove leading slash
    }

    private void handleList(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String search = request.getParameter("search");
        String ward = request.getParameter("ward");
        
        List<Patient> patients;
        
        if (search != null && !search.trim().isEmpty()) {
            patients = patientDAO.searchPatients(search.trim());
        } else if (ward != null && !ward.trim().isEmpty()) {
            try {
                int wardNo = Integer.parseInt(ward.trim());
                patients = patientDAO.findByWard(wardNo);
            } catch (NumberFormatException e) {
                patients = patientDAO.findAll();
            }
        } else {
            patients = patientDAO.findAll();
        }
        
        request.setAttribute("patients", patients);
        request.setAttribute("search", search);
        request.setAttribute("ward", ward);
        
        request.getRequestDispatcher("/views/patients/list.jsp").forward(request, response);
    }

    private void handleNew(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.getRequestDispatcher("/views/patients/new.jsp").forward(request, response);
    }

    private void handleEdit(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String idParam = request.getParameter("id");
        if (idParam == null) {
            response.sendRedirect(request.getContextPath() + "/patients");
            return;
        }
        
        try {
            int patientId = Integer.parseInt(idParam);
            Patient patient = patientDAO.findById(patientId);
            
            if (patient == null) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Patient not found");
                return;
            }
            
            request.setAttribute("patient", patient);
            request.getRequestDispatcher("/views/patients/edit.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid patient ID");
        }
    }

    private void handleView(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String idParam = request.getParameter("id");
        if (idParam == null) {
            response.sendRedirect(request.getContextPath() + "/patients");
            return;
        }
        
        try {
            int patientId = Integer.parseInt(idParam);
            Patient patient = patientDAO.findById(patientId);
            
            if (patient == null) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Patient not found");
                return;
            }
            
            request.setAttribute("patient", patient);
            request.getRequestDispatcher("/views/patients/view.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid patient ID");
        }
    }

    private void handleCreate(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            Patient patient = createPatientFromRequest(request);
            
            if (patientDAO.save(patient)) {
                response.sendRedirect(request.getContextPath() + "/patients?success=created");
            } else {
                request.setAttribute("error", "Failed to create patient");
                request.getRequestDispatcher("/views/patients/new.jsp").forward(request, response);
            }
        } catch (Exception e) {
            request.setAttribute("error", "Error creating patient: " + e.getMessage());
            request.getRequestDispatcher("/views/patients/new.jsp").forward(request, response);
        }
    }

    private void handleUpdate(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String idParam = request.getParameter("id");
        if (idParam == null) {
            response.sendRedirect(request.getContextPath() + "/patients");
            return;
        }
        
        try {
            int patientId = Integer.parseInt(idParam);
            Patient patient = createPatientFromRequest(request);
            patient.setPatientId(patientId);
            
            if (patientDAO.update(patient)) {
                response.sendRedirect(request.getContextPath() + "/patients?success=updated");
            } else {
                request.setAttribute("error", "Failed to update patient");
                request.setAttribute("patient", patient);
                request.getRequestDispatcher("/views/patients/edit.jsp").forward(request, response);
            }
        } catch (Exception e) {
            request.setAttribute("error", "Error updating patient: " + e.getMessage());
            request.getRequestDispatcher("/views/patients/edit.jsp").forward(request, response);
        }
    }

    private void handleDelete(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String idParam = request.getParameter("id");
        if (idParam == null) {
            response.sendRedirect(request.getContextPath() + "/patients");
            return;
        }
        
        try {
            int patientId = Integer.parseInt(idParam);
            
            if (patientDAO.delete(patientId)) {
                response.sendRedirect(request.getContextPath() + "/patients?success=deleted");
            } else {
                response.sendRedirect(request.getContextPath() + "/patients?error=delete_failed");
            }
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid patient ID");
        }
    }

    private Patient createPatientFromRequest(HttpServletRequest request) throws Exception {
        Patient patient = new Patient();
        
        patient.setCitizenId(request.getParameter("citizenId"));
        patient.setFirstName(request.getParameter("firstName"));
        patient.setLastName(request.getParameter("lastName"));
        
        String dobStr = request.getParameter("dateOfBirth");
        if (dobStr != null && !dobStr.trim().isEmpty()) {
            patient.setDateOfBirth(Date.valueOf(dobStr));
        }
        
        patient.setGender(request.getParameter("gender"));
        patient.setAddress(request.getParameter("address"));
        
        String wardStr = request.getParameter("wardNo");
        if (wardStr != null && !wardStr.trim().isEmpty()) {
            patient.setWardNo(Integer.parseInt(wardStr));
        }
        
        patient.setPhone(request.getParameter("phone"));
        patient.setEmergencyContactName(request.getParameter("emergencyContactName"));
        patient.setEmergencyContactPhone(request.getParameter("emergencyContactPhone"));
        patient.setBloodGroup(request.getParameter("bloodGroup"));
        
        String heightStr = request.getParameter("height");
        if (heightStr != null && !heightStr.trim().isEmpty()) {
            patient.setHeight(new BigDecimal(heightStr));
        }
        
        String weightStr = request.getParameter("weight");
        if (weightStr != null && !weightStr.trim().isEmpty()) {
            patient.setWeight(new BigDecimal(weightStr));
        }
        
        patient.setQrCode(request.getParameter("qrCode"));
        
        return patient;
    }
}
