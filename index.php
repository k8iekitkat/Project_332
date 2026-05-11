<?php
// index.php
// Update these for the department server account.
$host = "localhost";
$user = "YOUR_DB_USERNAME";
$pass = "YOUR_DB_PASSWORD";
$db   = "YOUR_DB_NAME";

$conn = new mysqli($host, $user, $pass, $db);

if ($conn->connect_error) {
    die("Database connection failed: " . htmlspecialchars($conn->connect_error));
}

function h($value) {
    return htmlspecialchars((string)$value, ENT_QUOTES, 'UTF-8');
}

function renderTable($result) {
    if (!$result || $result->num_rows === 0) {
        echo "<p>No results found.</p>";
        return;
    }

    echo "<table border='1' cellpadding='6' cellspacing='0'>";
    echo "<tr>";
    while ($field = $result->fetch_field()) {
        echo "<th>" . h($field->name) . "</th>";
    }
    echo "</tr>";

    while ($row = $result->fetch_assoc()) {
        echo "<tr>";
        foreach ($row as $value) {
            echo "<td>" . h($value) . "</td>";
        }
        echo "</tr>";
    }

    echo "</table>";
}
?>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>University Database System</title>
</head>
<body>
    <h1>University Database System</h1>

    <h2>Professor Interface</h2>

    <h3>1. Find classes taught by professor SSN</h3>
    <form method="get">
        <input type="hidden" name="action" value="professor_classes">
        <label>Professor SSN:</label>
        <input type="text" name="ssn" required placeholder="111-22-33">
        <button type="submit">Search</button>
    </form>

    <h3>2. Count grades by course and section</h3>
    <form method="get">
        <input type="hidden" name="action" value="grade_count">
        <label>Course Number:</label>
        <input type="number" name="course_num" required placeholder="101">
        <label>Section Number:</label>
        <input type="number" name="section_num" required placeholder="1">
        <button type="submit">Search</button>
    </form>

    <hr>

    <h2>Student Interface</h2>

    <h3>3. List sections for a course</h3>
    <form method="get">
        <input type="hidden" name="action" value="course_sections">
        <label>Course Number:</label>
        <input type="number" name="course_num" required placeholder="101">
        <button type="submit">Search</button>
    </form>

    <h3>4. List courses and grades for a student</h3>
    <form method="get">
        <input type="hidden" name="action" value="student_grades">
        <label>Student CWID:</label>
        <input type="number" name="cwid" required placeholder="1001">
        <button type="submit">Search</button>
    </form>

    <hr>

    <h2>Results</h2>

<?php
$action = $_GET["action"] ?? "";

if ($action === "professor_classes") {
    $ssn = $_GET["ssn"] ?? "";

    $sql = "
        SELECT 
            c.title AS course_title,
            s.classroom,
            s.meet_days,
            TIME_FORMAT(s.start_time, '%h:%i %p') AS start_time,
            TIME_FORMAT(s.end_time, '%h:%i %p') AS end_time
        FROM Sections s
        JOIN Course c ON s.course_num = c.course_num
        WHERE s.ssn = ?
        ORDER BY c.course_num, s.section_num
    ";

    $stmt = $conn->prepare($sql);
    $stmt->bind_param("s", $ssn);
    $stmt->execute();
    renderTable($stmt->get_result());
    $stmt->close();
}

elseif ($action === "grade_count") {
    $course_num = (int)($_GET["course_num"] ?? 0);
    $section_num = (int)($_GET["section_num"] ?? 0);

    $sql = "
        SELECT 
            grade,
            COUNT(*) AS student_count
        FROM Enrollment_records
        WHERE course_num = ?
          AND section_num = ?
        GROUP BY grade
        ORDER BY grade
    ";

    $stmt = $conn->prepare($sql);
    $stmt->bind_param("ii", $course_num, $section_num);
    $stmt->execute();
    renderTable($stmt->get_result());
    $stmt->close();
}

elseif ($action === "course_sections") {
    $course_num = (int)($_GET["course_num"] ?? 0);

    $sql = "
        SELECT 
            s.section_num,
            s.classroom,
            s.meet_days,
            TIME_FORMAT(s.start_time, '%h:%i %p') AS start_time,
            TIME_FORMAT(s.end_time, '%h:%i %p') AS end_time,
            COUNT(e.cwid) AS enrolled_students
        FROM Sections s
        LEFT JOIN Enrollment_records e
            ON s.course_num = e.course_num
           AND s.section_num = e.section_num
        WHERE s.course_num = ?
        GROUP BY 
            s.course_num,
            s.section_num,
            s.classroom,
            s.meet_days,
            s.start_time,
            s.end_time
        ORDER BY s.section_num
    ";

    $stmt = $conn->prepare($sql);
    $stmt->bind_param("i", $course_num);
    $stmt->execute();
    renderTable($stmt->get_result());
    $stmt->close();
}

elseif ($action === "student_grades") {
    $cwid = (int)($_GET["cwid"] ?? 0);

    $sql = "
        SELECT 
            c.course_num,
            c.title AS course_title,
            e.section_num,
            e.grade
        FROM Enrollment_records e
        JOIN Course c ON e.course_num = c.course_num
        WHERE e.cwid = ?
        ORDER BY c.course_num, e.section_num
    ";

    $stmt = $conn->prepare($sql);
    $stmt->bind_param("i", $cwid);
    $stmt->execute();
    renderTable($stmt->get_result());
    $stmt->close();
}

else {
    echo "<p>Select a query above.</p>";
}

$conn->close();
?>

</body>
</html>