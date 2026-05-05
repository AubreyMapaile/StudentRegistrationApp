package com.echoloop.studentregistrationapp.servlet;

import com.echoloop.studentregistrationapp.dao.StudentDAO;
import jakarta.inject.Inject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(name = "DeleteStudentServlet", urlPatterns = {"/delete-student"})
public class DeleteStudentServlet extends HttpServlet {

    @Inject
    private StudentDAO studentDAO;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idParam = request.getParameter("id");
        if (idParam != null && !idParam.isEmpty()) {
            try {
                int id = Integer.parseInt(idParam);
                studentDAO.deleteById(id);
            } catch (NumberFormatException e) {
                request.setAttribute("error", "Invalid student ID");
            }
        }
        response.sendRedirect(request.getContextPath() + "/students");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
