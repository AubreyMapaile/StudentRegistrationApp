<%@ page import="java.util.List" %>
<%@ page import="com.echoloop.studentregistrationapp.entity.Student" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>All Students</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Inter', -apple-system, BlinkMacSystemFont, sans-serif;
            min-height: 100vh;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            padding: 40px 20px;
        }

        .container {
            max-width: 900px;
            margin: 0 auto;
        }

        .card {
            background: white;
            border-radius: 24px;
            box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.25);
            overflow: hidden;
        }

        .header {
            padding: 32px 40px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
        }

        .header-content {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .header h1 {
            font-size: 28px;
            font-weight: 700;
            letter-spacing: -0.5px;
        }

        .subtitle {
            font-size: 14px;
            opacity: 0.9;
            margin-top: 4px;
        }

        .btn-add {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            padding: 12px 20px;
            background: white;
            color: #667eea;
            text-decoration: none;
            border-radius: 12px;
            font-size: 14px;
            font-weight: 600;
            transition: all 0.2s;
            box-shadow: 0 4px 12px rgba(0,0,0,0.15);
        }

        .btn-add:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(0,0,0,0.2);
        }

        .content {
            padding: 0;
        }

        .success {
            background: #c6f6d5;
            color: #276749;
            padding: 12px 40px;
            font-size: 14px;
            font-weight: 500;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .error {
            background: #fed7d7;
            color: #c53030;
            padding: 12px 40px;
            font-size: 14px;
            font-weight: 500;
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        thead {
            background: #f7fafc;
        }

        th {
            padding: 16px 24px;
            text-align: left;
            font-size: 12px;
            font-weight: 700;
            color: #4a5568;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        td {
            padding: 20px 24px;
            font-size: 14px;
            color: #2d3748;
            border-bottom: 1px solid #edf2f7;
        }

        tbody tr:hover {
            background: #f7fafc;
        }

        tbody tr:last-child td {
            border-bottom: none;
        }

        .student-name {
            font-weight: 600;
            color: #1a202c;
        }

        .student-email {
            color: #718096;
        }

        .course-badge {
            display: inline-block;
            padding: 6px 12px;
            background: #edf2f7;
            color: #4a5568;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 500;
        }

        .delete-btn {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            width: 36px;
            height: 36px;
            background: #fed7d7;
            color: #c53030;
            border-radius: 10px;
            text-decoration: none;
            transition: all 0.2s;
        }

        .delete-btn:hover {
            background: #fc8181;
            color: white;
            transform: scale(1.05);
        }

        .empty-state {
            padding: 60px 40px;
            text-align: center;
            color: #a0aec0;
        }

        .empty-state svg {
            width: 64px;
            height: 64px;
            margin-bottom: 16px;
            opacity: 0.5;
        }

        .empty-state h3 {
            font-size: 18px;
            color: #4a5568;
            margin-bottom: 8px;
        }

        .footer {
            padding: 24px 40px;
            background: #f7fafc;
            border-top: 1px solid #e2e8f0;
        }

        .btn-back {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            color: #718096;
            text-decoration: none;
            font-size: 14px;
            font-weight: 500;
            transition: color 0.2s;
        }

        .btn-back:hover {
            color: #4a5568;
        }
    </style>
</head>
<body>
<div class="container">
    <div class="card">
        <div class="header">
            <div class="header-content">
                <div>
                    <h1>All Students</h1>
                    <p class="subtitle"><%= ((List<Student>) request.getAttribute("students")) != null ? ((List<Student>) request.getAttribute("students")).size() : 0 %> students registered</p>
                </div>
                <a href="<%= request.getContextPath() %>/add-student" class="btn-add">
                    <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5"><line x1="12" y1="5" x2="12" y2="19"></line><line x1="5" y1="12" x2="19" y2="12"></line></svg>
                    Add Student
                </a>
            </div>
        </div>

        <% if (request.getAttribute("success") != null) { %>
            <div class="success">
                <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><polyline points="20 6 9 17 4 12"></polyline></svg>
                <%= request.getAttribute("success") %>
            </div>
        <% } %>

        <% if (request.getAttribute("error") != null) { %>
            <div class="error"><%= request.getAttribute("error") %></div>
        <% } %>

        <div class="content">
            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Name</th>
                        <th>Email</th>
                        <th>Course</th>
                        <th style="width: 80px;">Action</th>
                    </tr>
                </thead>
                <tbody>
                    <% 
                        List<Student> students = (List<Student>) request.getAttribute("students");
                        if (students != null && !students.isEmpty()) {
                            for (Student student : students) {
                    %>
                        <tr>
                            <td style="color: #718096; font-weight: 500;">#<%= student.getId() %></td>
                            <td class="student-name"><%= student.getName() %></td>
                            <td class="student-email"><%= student.getEmail() %></td>
                            <td><span class="course-badge"><%= student.getCourse() %></span></td>
                            <td>
                                <a href="<%= request.getContextPath() %>/delete-student?id=<%= student.getId() %>"
                                   class="delete-btn"
                                   onclick="return confirm('Are you sure you want to delete this student?');"
                                   title="Delete">
                                    <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><polyline points="3 6 5 6 21 6"></polyline><path d="M19 6v14a2 2 0 0 1-2 2H7a2 2 0 0 1-2-2V6m3 0V4a2 2 0 0 1 2-2h4a2 2 0 0 1 2 2v2"></path></svg>
                                </a>
                            </td>
                        </tr>
                    <% 
                            }
                        } else {
                    %>
                        <tr>
                            <td colspan="5" class="empty-state">
                                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5"><path d="M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2"></path><circle cx="9" cy="7" r="4"></circle><path d="M23 21v-2a4 4 0 0 0-3-3.87"></path><path d="M16 3.13a4 4 0 0 1 0 7.75"></path></svg>
                                <h3>No students found</h3>
                                <p>Add your first student to get started</p>
                            </td>
                        </tr>
                    <% } %>
                </tbody>
            </table>
        </div>

        <div class="footer">
            <a href="<%= request.getContextPath() %>/" class="btn-back">
                <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M19 12H5M12 19l-7-7 7-7"/></svg>
                Back to Home
            </a>
        </div>
    </div>
</div>
</body>
</html>
