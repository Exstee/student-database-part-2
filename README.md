# Student Database Part 2

## Overview
**Student Database Part 2** is a relational database project designed to manage student information, including their majors, courses, and academic performance (GPA). Built with PostgreSQL, this repository includes SQL schema definitions, sample data in CSV format, and Bash scripts to automate database setup and querying. It serves as an educational tool for learning database design, SQL queries, and scripting.

## Features
- **Relational Schema**: Tables for students, majors, courses, and a junction table (`majors_courses`) to link majors with their required courses.
- **Sample Data**: Preloaded CSV files with student records and course-major mappings.
- **Automation Scripts**:
  - `insert_data.sh`: Populates the database from CSV files.
  - `info.sh`: Displays various insights via predefined SQL queries.
- **Technologies Used**: PostgreSQL, SQL, Bash scripting.

## Repository Contents
- **`courses.csv`**: CSV file mapping majors to courses (e.g., "Database Administration,SQL").
- **`students.csv`**: CSV file with student data (first name, last name, major, GPA).
- **`info.sh`**: Bash script to query and display student database insights.
- **`students.sql`**: SQL dump file to create and populate the database schema.
- **`insert_data.sh`**: Bash script to import data from CSV files into the database.

## Prerequisites
To run this project locally, ensure you have:
- [PostgreSQL](https://www.postgresql.org/download/) installed (version 12.6 or compatible).
- A terminal with Bash (e.g., Linux, macOS, or WSL on Windows).
- `psql` command-line tool (included with PostgreSQL).
- Basic knowledge of SQL and command-line operations.

## Installation
1. **Clone the Repository**:
   ```bash
   git clone https://github.com/Exstee/student-database-part-2.git
   cd student-database-part-2
   ```

2. **Set Up PostgreSQL User**:
   - Ensure a `freecodecamp` user exists with appropriate permissions:
     ```bash
     sudo -u postgres psql -c "CREATE USER freecodecamp WITH PASSWORD 'your_password';"
     sudo -u postgres psql -c "ALTER USER freecodecamp WITH SUPERUSER;"
     ```

3. **Create and Populate the Database**:
   - Use the SQL dump file to set up the database:
     ```bash
     psql -U postgres -f students.sql
     ```
   - This creates the `students` database, defines tables, and inserts initial data.

4. **(Optional) Import CSV Data**:
   - If you want to reset and use the CSV files instead:
     ```bash
     bash insert_data.sh
     ```
   - This truncates existing data and imports from `courses.csv` and `students.csv`.

## Usage
- **Run Queries with `info.sh`**:
  Execute the script to see various database insights:
  ```bash
  bash info.sh
  ```
  Outputs include:
  - Students with a 4.0 GPA.
  - Courses starting before 'D' alphabetically.
  - Average GPA, major statistics, and more (see script for full list).

- **Manual Queries**:
  Connect to the database and run your own SQL:
  ```bash
  psql -U freecodecamp -d students
  ```
  Example:
  ```sql
  SELECT first_name, last_name, gpa FROM students WHERE gpa > 3.5;
  ```

## Database Schema
- **`students`**: Stores student info (student_id, first_name, last_name, major_id, gpa).
- **`majors`**: Lists available majors (major_id, major).
- **`courses`**: Lists available courses (course_id, course).
- **`majors_courses`**: Junction table linking majors to courses (major_id, course_id).

### Relationships
- `students.major_id` → `majors.major_id` (foreign key).
- `majors_courses.major_id` → `majors.major_id` (foreign key).
- `majors_courses.course_id` → `courses.course_id` (foreign key).

## Sample Data
- **Students**: 31 records with names, majors (some null), and GPAs (e.g., "Casares Hijo, Game Design, 4.0").
- **Majors**: 7 majors (e.g., "Database Administration", "Web Development").
- **Courses**: 17 unique courses (e.g., "SQL", "Machine Learning").

## Contributing
Contributions are welcome! To contribute:
1. Fork the repository.
2. Create a branch (`git checkout -b feature/your-feature`).
3. Commit changes (`git commit -m "Add your feature"`).
4. Push to your branch (`git push origin feature/your-feature`).
5. Open a pull request.

Ideas for improvement:
- Add more complex SQL queries in `info.sh`.
- Include data validation in `insert_data.sh`.
- Expand sample data with additional fields (e.g., enrollment date).

## Acknowledgments
- Built as part of a learning journey, possibly inspired by [FreeCodeCamp's Relational Database Course](https://www.freecodecamp.org/learn/relational-database/).

## License
This project is licensed under the **MIT License**. See the [LICENSE](LICENSE) file for details.

---
