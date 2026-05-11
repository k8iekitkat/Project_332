app.get("/api/professor-classes", async (req, res) => {
    const { ssn } = req.query;

    try {
        const [rows] = await pool.query(`
            SELECT 
                c.title,
                s.classroom,
                s.meeting_days,
                s.begin_time,
                s.end_time
            FROM Sections s
            JOIN Course c ON s.course_num = c.course_num
            WHERE s.ssn = ?
        `, [ssn]);

        res.json(rows);
    } catch (err) {
        console.error(err);
        res.status(500).json({ error: "Database query failed" });
    }
});

app.get("/api/grade-counts", async (req, res) => {
    const { courseNum, sectionNum } = req.query;

    try {
        const [rows] = await pool.query(`
            SELECT 
                grade,
                COUNT(*) AS student_count
            FROM Enrollment
            WHERE course_num = ? AND section_num = ?
            GROUP BY grade
        `, [courseNum, sectionNum]);

        res.json(rows);
    } catch (err) {
        console.error(err);
        res.status(500).json({ error: "Database query failed" });
    }
});

app.get("/api/course-sections", async (req, res) => {
    const { courseNum } = req.query;

    try {
        const [rows] = await pool.query(`
            SELECT 
                s.section_num,
                s.classroom,
                s.meeting_days,
                s.begin_time,
                s.end_time,
                COUNT(e.cwid) AS enrolled_students
            FROM Sections s
            LEFT JOIN Enrollment e 
                ON s.course_num = e.course_num 
                AND s.section_num = e.section_num
            WHERE s.course_num = ?
            GROUP BY 
                s.section_num,
                s.classroom,
                s.meeting_days,
                s.begin_time,
                s.end_time
        `, [courseNum]);

        res.json(rows);
    } catch (err) {
        console.error(err);
        res.status(500).json({ error: "Database query failed" });
    }
});

app.get("/api/student-courses", async (req, res) => {
    const { cwid } = req.query;

    try {
        const [rows] = await pool.query(`
            SELECT 
                c.course_num,
                c.title,
                e.section_num,
                e.grade
            FROM Enrollment e
            JOIN Course c ON e.course_num = c.course_num
            WHERE e.cwid = ?
        `, [cwid]);

        res.json(rows);
    } catch (err) {
        console.error(err);
        res.status(500).json({ error: "Database query failed" });
    }
});