package com.echoloop.studentregistrationapp.servlet;

import com.echoloop.studentregistrationapp.dao.StudentDAO;
import com.echoloop.studentregistrationapp.entity.Student;
import jakarta.inject.Inject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(name = "AddStudentServlet", urlPatterns = {"/add-student"})
public class AddStudentServlet extends HttpServlet {

    @Inject
    private StudentDAO studentDAO;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/add-student.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String course = request.getParameter("course");

        if (name == null || name.trim().isEmpty() ||
            email == null || email.trim().isEmpty() ||
            course == null || course.trim().isEmpty()) {
            request.setAttribute("error", "All fields are required");
            request.getRequestDispatcher("/add-student.jsp").forward(request, response);
            return;
        }

        if (!email.matches("^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+$")) {
            request.setAttribute("error", "Invalid email format");
            request.setAttribute("name", name);
            request.setAttribute("email", email);
            request.setAttribute("course", course);
            request.getRequestDispatcher("/add-student.jsp").forward(request, response);
            return;
        }

        Student student = new Student(name.trim(), email.trim(), course.trim());
        studentDAO.save(student);

        request.setAttribute("success", "Student added successfully");
        request.getRequestDispatcher("/students").forward(request, response);
    }
}
