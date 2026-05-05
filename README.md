# Student Registration App

A modern Jakarta EE web application for managing student registrations with a sleek, responsive UI.

![Java](https://img.shields.io/badge/Java-21-blue)
![Jakarta EE](https://img.shields.io/badge/Jakarta%20EE-11-orange)
![Maven](https://img.shields.io/badge/Maven-3.9-green)
![GlassFish](https://img.shields.io/badge/GlassFish-8.0-red)

## Features

- **Add Students**: Register new students with name, email, and course
- **View All Students**: Browse complete student registry in a modern data table
- **Delete Students**: Remove students with confirmation dialog
- **Input Validation**: Email format validation and required field checks
- **Responsive UI**: Modern gradient design with smooth animations

## Technology Stack

| Layer | Technology |
|-------|------------|
| Backend | Jakarta EE 11 (Servlets, CDI, JPA) |
| Persistence | EclipseLink JPA with JTA transactions |
| Database | MySQL (via GlassFish JDBC Connection Pool) |
| Frontend | JSP with modern CSS |
| Build Tool | Maven 3.9 |
| Server | Eclipse GlassFish 8.0 |

## Project Structure

```
StudentRegistrationApp/
├── src/
│   └── main/
│       ├── java/
│       │   └── com/echoloop/studentregistrationapp/
│       │       ├── dao/
│       │       │   └── StudentDAO.java          # Data access with CDI
│       │       ├── entity/
│       │       │   └── Student.java             # JPA entity
│       │       └── servlet/
│       │           ├── AddStudentServlet.java   # Add student endpoint
│       │           ├── DeleteStudentServlet.java # Delete student endpoint
│       │           ├── HomeServlet.java         # Home page router
│       │           └── ListStudentsServlet.java # List students endpoint
│       ├── resources/
│       │   └── META-INF/
│       │       ├── beans.xml                   # CDI configuration
│       │       └── persistence.xml             # JPA configuration
│       └── webapp/
│           ├── index.jsp                       # Home page
│           ├── add-student.jsp                 # Add student form
│           ├── students.jsp                    # Student list
│           └── WEB-INF/
│               └── web.xml                      # Web configuration
├── target/                                     # Build output
├── deploy.ps1                                  # Deployment script
├── pom.xml                                     # Maven configuration
├── project-guide.md                           # Project documentation
└── README.md                                   # This file
```

## Database Setup

### 1. Create MySQL Database

```sql
CREATE DATABASE students;

CREATE TABLE students.students (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    course VARCHAR(255) NOT NULL
);
```

### 2. Configure GlassFish JDBC Connection Pool

1. Open GlassFish Admin Console: `http://localhost:4848`
2. Navigate to: **Resources → JDBC → JDBC Connection Pools**
3. Click **New** and configure:
   - **Pool Name**: `StudentRegistration`
   - **Resource Type**: `javax.sql.DataSource`
   - **Database Driver Vendor**: `MySQL`

4. Add these properties to the pool:
   | Property | Value |
   |----------|-------|
   | `url` | `jdbc:mysql://localhost:3306/students?serverTimezone=UTC` |
   | `user` | `students_admin` |
   | `password` | `Password#123` |
   | `databaseName` | `students` |
   | `serverName` | `localhost` |
   | `portNumber` | `3306` |
   | `useSSL` | `false` |

5. Save and ping to test the connection

### 3. Configure JDBC Resource

1. Navigate to: **Resources → JDBC → JDBC Resources**
2. Click **New**:
   - **JNDI Name**: `jdbc/StudentsPool`
   - **Pool Name**: `StudentRegistration`

### 4. persistence.xml Configuration

The `persistence.xml` is already configured to use `jdbc/StudentsPool`:

| Setting | Value |
|---------|-------|
| **Persistence Unit** | `students` |
| **Transaction Type** | `JTA` |
| **JPA Provider** | `org.eclipse.persistence.jpa.PersistenceProvider` |
| **Data Source** | `jdbc/StudentsPool` |
| **Entity Class** | `com.echoloop.studentregistrationapp.entity.Student` |
| **Schema Generation** | `drop-and-create` (recreates tables on deploy) |
| **Logging Level** | `FINE` (shows SQL queries) |
| **Log Parameters** | `true` (shows query parameters) |

## Building and Running

### Prerequisites

- Java 21 JDK
- Maven 3.9+
- Eclipse GlassFish 8.0
- MySQL 8.0+

### Build

```bash
mvn clean package
```

### Deploy to GlassFish

**Option 1: Using deploy script**
```powershell
# Update deploy.ps1 with your paths, then run:
.\deploy.ps1
```

**Option 2: Manual deployment**
```bash
cd $GLASSFISH_HOME/bin
asadmin deploy target/StudentsRegistration.war
```

**Option 3: Admin Console**
1. Open `http://localhost:4848`
2. Navigate to **Applications**
3. Click **Deploy**
4. Select `target/StudentsRegistration.war`

### Access the Application

Once deployed, access the app at:

```
http://localhost:8080/StudentsRegistration/
```

## URL Mapping

| URL | Description |
|-----|-------------|
| `/` or `/home` | Home page |
| `/add-student` | Add student form (GET) / Submit (POST) |
| `/students` | List all students |
| `/delete-student?id=X` | Delete student by ID |

## Development Notes

### CDI Configuration
The app uses Jakarta CDI for dependency injection:
- `StudentDAO` is annotated with `@ApplicationScoped`
- EntityManager is injected via `@PersistenceContext`
- Servlets receive DAO instances via `@Inject`

### Transaction Management
JTA container-managed transactions are used:
- `save()` and `deleteById()` methods are annotated with `@Transactional`
- No manual transaction handling required

### JPA Schema Generation
Set `jakarta.persistence.schema-generation.database.action` in `persistence.xml`:
- `drop-and-create` - Recreates tables on deployment (development)
- `create` - Creates if not exists
- `none` - No schema changes (production)

## Troubleshooting

### 404 Error
- Verify deployment: `asadmin list-applications`
- Check correct URL: `http://localhost:8080/StudentsRegistration/`
- Ensure GlassFish server is running: `asadmin start-domain`

### 405 Method Not Allowed
- Servlet may be missing `doPost` or `doGet` methods
- Check that forwarded requests have matching methods

### Database Connection Issues
- Verify JDBC pool is pinging successfully
- Check MySQL credentials and connectivity
- Review `server.log` for detailed error messages

### CDI Injection Failures
- Ensure `beans.xml` exists in `WEB-INF` or `META-INF`
- Verify `persistence.xml` has correct unit name
- Check that GlassFish CDI (Weld) is enabled

## License

This project is for educational purposes.

---

Built with ❤️ using Jakarta EE and Eclipse GlassFish
