# Student Registration Web Application Guide

## Overview

This is a Jakarta EE web application for managing student registrations. It provides basic CRUD operations for student records using JPA for database persistence and Servlets with JSP for the frontend.

---

## Requirements

- **Student Entity**: Store student information with fields for ID, name, email, and course.
- **JPA Integration**: Use Jakarta Persistence API (JPA) for all database interactions.
- **Core Functionality**:
  - Add new students
  - View all registered students
  - Delete existing students
- **Frontend Technology**: Servlets + JSP (or JSF) for rendering pages and handling requests.
- **Validation**: Implement basic validation including email format checking and required field validation.

---

## Application Pages

### Home Page

The landing page of the application that provides navigation to the core features.

**Components:**
- Application description text
- **Add Student** button → links to `add-student.jsp`
- **View All Students** button → links to `students.jsp`

---

### Add Student Page

A form page for registering new students with client-side and server-side validation.

**Fields:**
| Field | Type | Validation |
|-------|------|------------|
| ID | Auto-generated | System-assigned on creation |
| Name | Text input | Required |
| Email | Text input | Required, must be valid email format |
| Course | Text input | Required |

**Workflow:**
1. User fills out the form
2. Validation is applied to ensure data integrity
3. Form submission is handled by a Servlet
4. `StudentDAO.save()` persists the student to the database
5. User is redirected to the Students list or receives confirmation

---

### Students Page

Displays all registered students in a tabular format with management options.

**Components:**
- Data table with columns:
  - ID
  - Name
  - Email
  - Course
  - Delete Icon (action button)

**Workflow:**
1. Page loads by calling `StudentDAO.findAll()` to retrieve all records
2. Table is rendered dynamically with student data
3. Each row includes a delete icon/link
4. Clicking delete triggers `StudentDAO.deleteById()` for the selected student
5. Table refreshes to reflect the updated list

---

## Data Structures

### Entity: Student

The core domain object representing a student in the system.

| Attribute | Type | Description |
|-----------|------|-------------|
| ID | Integer | Unique identifier (primary key, auto-generated) |
| Name | String | Student's full name |
| Email | String | Student's email address |
| Course | String | Enrolled course name |

### Data Access Object (DAO): StudentDAO

Handles all persistence operations for Student entities.

**Methods:**
- `save(Student student)` - Persists a new student to the database
- `findAll()` - Retrieves all students as a `List<Student>`
- `deleteById(Integer id)` - Removes a student by their ID

### Collections for Data Handling

- **List<Student>** - Used for displaying all students in tabular views
- **HashMap<Integer, Student>** - Optional structure for quick lookup of students by ID

---

## Application Workflow

### Adding a Student

```
┌─────────────┐     ┌─────────────────┐     ┌──────────────────┐
│  Home Page  │────▶│  Add Student    │────▶│  Form Submission │
│             │     │  Page (JSP)     │     │  (Servlet)       │
└─────────────┘     └─────────────────┘     └──────────────────┘
                                                      │
                                                      ▼
                                               ┌──────────────┐
                                               │ StudentDAO   │
                                               │ .save()      │
                                               └──────────────┘
                                                      │
                                                      ▼
                                               ┌──────────────┐
                                               │  Database    │
                                               │  (via JPA)   │
                                               └──────────────┘
```

### Viewing All Students

```
┌─────────────┐     ┌──────────────────┐     ┌────────────────┐
│  Home Page  │────▶│  Students Page   │────▶│ StudentDAO     │
│             │     │  (JSP)           │     │ .findAll()     │
└─────────────┘     └──────────────────┘     └────────────────┘
                                                      │
                                                      ▼
                                               ┌──────────────┐
                                               │  Database    │
                                               │  (via JPA)   │
                                               └──────────────┘
                                                      │
                                                      ▼
                                               ┌──────────────┐
                                               │  List<Student│
                                               │  rendered as │
                                               │  HTML Table  │
                                               └──────────────┘
```

### Deleting a Student

```
┌──────────────────┐     ┌──────────────────┐     ┌──────────────┐
│  Students Page   │────▶│  Delete Request │────▶│ StudentDAO   │
│  (Click Delete)  │     │  (Servlet)        │     │ .deleteById()│
└──────────────────┘     └──────────────────┘     └──────────────┘
                                                          │
                                                          ▼
                                                   ┌──────────────┐
                                                   │  Database    │
                                                   │  (via JPA)   │
                                                   └──────────────┘
                                                          │
                                                          ▼
                                                   ┌──────────────┐
                                                   │  Page Refresh│
                                                   │  (Updated    │
                                                   │   Table)     │
                                                   └──────────────┘
```

---

## Technology Stack

| Layer | Technology |
|-------|------------|
| Backend | Jakarta EE (Servlets) |
| Persistence | JPA (Jakarta Persistence API) |
| Frontend | JSP / JSF |
| Database | Configurable (via JPA provider) |
| Build Tool | Maven |

---

## Project Structure

```
StudentRegistrationApp/
├── src/
│   └── main/
│       ├── java/
│       │   └── com/echoloop/studentregistrationapp/
│       │       ├── entity/
│       │       │   └── Student.java
│       │       ├── dao/
│       │       │   └── StudentDAO.java
│       │       └── servlet/
│       │           ├── AddStudentServlet.java
│       │           ├── DeleteStudentServlet.java
│       │           └── ViewStudentsServlet.java
│       ├── resources/
│       │   └── META-INF/
│       │       └── persistence.xml
│       └── webapp/
│           ├── index.jsp (Home Page)
│           ├── add-student.jsp
│           ├── students.jsp
│           └── WEB-INF/
│               └── web.xml
├── pom.xml
└── project-guide.md (this file)
```

---

## Validation Rules

### Client-Side Validation
- All fields (except ID) must be filled before submission
- Email field should use HTML5 `type="email"` for basic format checking

### Server-Side Validation
- Name: Required, minimum 2 characters
- Email: Required, must match standard email regex pattern
- Course: Required, minimum 2 characters
- Display appropriate error messages for validation failures

---

## Notes

- ID is auto-generated by the persistence layer (typically using `@GeneratedValue` strategy)
- Database connection settings are configured in `persistence.xml`
- The application uses standard Jakarta EE patterns for maintainability
- Consider adding edit functionality as a future enhancement
