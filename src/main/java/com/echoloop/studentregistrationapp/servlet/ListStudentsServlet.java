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
import java.util.List;

@WebServlet(name = "ListStudentsServlet", urlPatterns = {"/students"})
public class ListStudentsServlet extends HttpServlet {

    @Inject
    private StudentDAO studentDAO;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Student> students = studentDAO.findAll();
        request.setAttribute("students", students);
        request.getRequestDispatcher("/students.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
