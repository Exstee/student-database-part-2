#!/bin/bash

# Script to insert data from courses.csv and students.csv into the 'students' database

# Define the PSQL command with connection parameters
PSQL="psql -X --username=freecodecamp --dbname=students --no-align --tuples-only -c"

# Clear out existing data from relevant tables
echo $($PSQL "TRUNCATE students, majors, courses, majors_courses")

# Process courses.csv to insert course and major data
cat courses.csv | while IFS="," read MAJOR COURSE
do
  # Skip header line
  if [[ $MAJOR != "major" ]]; then
    # Retrieve major_id for the given major
    MAJOR_ID=$($PSQL "SELECT major_id FROM majors WHERE major='$MAJOR'")

    # If major doesn't exist, insert it
    if [[ -z $MAJOR_ID ]]; then
      INSERT_MAJOR_RESULT=$($PSQL "INSERT INTO majors(major) VALUES('$MAJOR')")
      if [[ $INSERT_MAJOR_RESULT == "INSERT 0 1" ]]; then
        echo "Inserted into majors, $MAJOR"
      fi

      # Retrieve new major_id
      MAJOR_ID=$($PSQL "SELECT major_id FROM majors WHERE major='$MAJOR'")
    fi

    # Retrieve course_id for the given course
    COURSE_ID=$($PSQL "SELECT course_id FROM courses WHERE course='$COURSE'")

    # If course doesn't exist, insert it
    if [[ -z $COURSE_ID ]]; then
      INSERT_COURSE_RESULT=$($PSQL "INSERT INTO courses(course) VALUES('$COURSE')")
      if [[ $INSERT_COURSE_RESULT == "INSERT 0 1" ]]; then
        echo "Inserted into courses, $COURSE"
      fi

      # Retrieve new course_id
      COURSE_ID=$($PSQL "SELECT course_id FROM courses WHERE course='$COURSE'")
    fi

    # Insert relationship between major and course into majors_courses table
    INSERT_MAJORS_COURSES_RESULT=$($PSQL "INSERT INTO majors_courses(major_id, course_id) VALUES($MAJOR_ID, $COURSE_ID)")
    if [[ $INSERT_MAJORS_COURSES_RESULT == "INSERT 0 1" ]]; then
      echo "Inserted into majors_courses, $MAJOR : $COURSE"
    fi
  fi
done

# Process students.csv to insert student data
cat students.csv | while IFS="," read FIRST LAST MAJOR GPA
do
  # Skip header line
  if [[ $FIRST != "first_name" ]]; then
    # Retrieve major_id for the student's major
    MAJOR_ID=$($PSQL "SELECT major_id FROM majors WHERE major='$MAJOR'")

    # If major doesn't exist, set major_id to null
    if [[ -z $MAJOR_ID ]]; then
      MAJOR_ID=null
    fi

    # Insert student record into students table
    INSERT_STUDENT_RESULT=$($PSQL "INSERT INTO students(first_name, last_name, major_id, gpa) VALUES('$FIRST', '$LAST', $MAJOR_ID, $GPA)")
    if [[ $INSERT_STUDENT_RESULT == "INSERT 0 1" ]]; then
      echo "Inserted into students, $FIRST $LAST"
    fi
  fi
done
