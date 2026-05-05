<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Add Student</title>
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
            display: flex;
            align-items: center;
            justify-content: center;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            padding: 20px;
        }

        .card {
            background: white;
            border-radius: 24px;
            padding: 48px;
            max-width: 440px;
            width: 100%;
            box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.25);
        }

        .header {
            margin-bottom: 32px;
        }

        .back-link {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            color: #667eea;
            text-decoration: none;
            font-size: 14px;
            font-weight: 500;
            margin-bottom: 16px;
            transition: color 0.2s;
        }

        .back-link:hover {
            color: #764ba2;
        }

        h1 {
            font-size: 28px;
            font-weight: 700;
            color: #1a202c;
            letter-spacing: -0.5px;
        }

        .subtitle {
            color: #718096;
            font-size: 14px;
            margin-top: 6px;
        }

        .error {
            background: #fed7d7;
            color: #c53030;
            padding: 12px 16px;
            border-radius: 10px;
            margin-bottom: 24px;
            font-size: 14px;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .form-group {
            margin-bottom: 20px;
        }

        label {
            display: block;
            font-size: 13px;
            font-weight: 600;
            color: #4a5568;
            margin-bottom: 8px;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        input[type="text"], input[type="email"] {
            width: 100%;
            padding: 14px 16px;
            font-size: 15px;
            border: 2px solid #e2e8f0;
            border-radius: 12px;
            font-family: inherit;
            transition: all 0.2s;
            background: #fafafa;
        }

        input[type="text"]:focus, input[type="email"]:focus {
            outline: none;
            border-color: #667eea;
            background: white;
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
        }

        input::placeholder {
            color: #a0aec0;
        }

        .btn-group {
            display: flex;
            gap: 12px;
            margin-top: 28px;
        }

        .btn {
            flex: 1;
            padding: 14px 24px;
            font-size: 15px;
            font-weight: 600;
            border: none;
            border-radius: 12px;
            cursor: pointer;
            text-decoration: none;
            text-align: center;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
        }

        .btn-primary {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            box-shadow: 0 4px 14px rgba(102, 126, 234, 0.4);
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(102, 126, 234, 0.5);
        }

        .btn-secondary {
            background: #edf2f7;
            color: #4a5568;
        }

        .btn-secondary:hover {
            background: #e2e8f0;
            transform: translateY(-2px);
        }

        .btn:active {
            transform: translateY(0);
        }
    </style>
</head>
<body>
<div class="card">
    <div class="header">
        <a href="<%= request.getContextPath() %>/" class="back-link">
            <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M19 12H5M12 19l-7-7 7-7"/></svg>
            Back to Home
        </a>
        <h1>Add New Student</h1>
        <p class="subtitle">Enter the student details below</p>
    </div>

    <% if (request.getAttribute("error") != null) { %>
        <div class="error">
            <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="12" cy="12" r="10"></circle><line x1="15" y1="9" x2="9" y2="15"></line><line x1="9" y1="9" x2="15" y2="15"></line></svg>
            <%= request.getAttribute("error") %>
        </div>
    <% } %>

    <form action="<%= request.getContextPath() %>/add-student" method="post">
        <div class="form-group">
            <label for="name">Full Name</label>
            <input type="text" id="name" name="name" placeholder="e.g. John Doe" value="<%= request.getAttribute("name") != null ? request.getAttribute("name") : "" %>" required>
        </div>

        <div class="form-group">
            <label for="email">Email Address</label>
            <input type="email" id="email" name="email" placeholder="e.g. john@example.com" value="<%= request.getAttribute("email") != null ? request.getAttribute("email") : "" %>" required>
        </div>

        <div class="form-group">
            <label for="course">Course</label>
            <input type="text" id="course" name="course" placeholder="e.g. Computer Science" value="<%= request.getAttribute("course") != null ? request.getAttribute("course") : "" %>" required>
        </div>

        <div class="btn-group">
            <button type="submit" class="btn btn-primary">Save Student</button>
            <a href="<%= request.getContextPath() %>/" class="btn btn-secondary">Cancel</a>
        </div>
    </form>
</div>
</body>
</html>
