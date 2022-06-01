-- 1. What grades are stored in the database?
SELECT * FROM Grade;

-- 2. What emotions may be associated with a poem?
SELECT * FROM Emotion;

-- 3. How many poems are in the database?
SELECT COUNT(Id) AS PoemCount FROM Poem;

-- 4. Sort authors alphabetically by name. What are the names of the top 76 authors?
SELECT TOP 76 Name 
FROM Author
ORDER BY Name ASC;

SELECT TOP 76 Name 
FROM Author
--ORDER BY Name ASC;

-- 5. Starting with the above query, add the grade of each of the authors.
SELECT TOP 76 a.Name AS Author, g.Name AS Grade
FROM Author a
LEFT JOIN Grade g ON a.GradeId = g.Id
ORDER BY a.Name ASC;


-- 6. Starting with the above query, add the recorded gender of each of the authors.
SELECT TOP 76 a.Name AS Author, g.Name AS Grade, gr.Name AS Gender
FROM Author a
LEFT JOIN Grade g ON a.GradeId = g.Id
LEFT JOIN Gender gr ON a.GenderId = gr.Id
ORDER BY a.Name ASC;

-- 7. What is the total number of words in all poems in the database?
SELECT SUM(WordCount) AS TotalWords FROM Poem;

-- 8. Which poem has the fewest characters?
SELECT TOP 1 CharCount
FROM Poem
ORDER BY CharCount ASC;

-- 9. How many authors are in the third grade?
SELECT COUNT(a.Id) AS NumStudents, g.Name
FROM Author a
LEFT JOIN Grade g ON a.GradeId = g.Id
WHERE g.Name = '3rd Grade'
GROUP BY g.Name;

-- 10. How many total authors are in the first through third grades?
SELECT COUNT(a.Id) AS NumStudents
FROM Author a
LEFT JOIN Grade g ON a.GradeId = g.Id
WHERE g.Name = '3rd Grade' OR g.Name = '2nd Grade' OR g.Name = '1st Grade';

-- 11. What is the total number of poems written by fourth graders?
SELECT g.Name, COUNT(DISTINCT p.Id) AS PoemCount
FROM Poem p
LEFT JOIN Author a ON p.AuthorId = a.Id
LEFT JOIN Grade g ON a.GradeId = g.Id
WHERE g.Name = '4th Grade'
GROUP BY g.Name;

-- 12. How many poems are there per grade?
SELECT g.Name, COUNT(DISTINCT p.Id) AS PoemCount
FROM Poem p
LEFT JOIN Author a ON p.AuthorId = a.Id
LEFT JOIN Grade g ON a.GradeId = g.Id
GROUP BY g.Name
ORDER BY g.Name;

-- 13. How many authors are in each grade? (Order your results by grade starting with 1st Grade)
SELECT g.Name, COUNT(a.Id) AS AuthorCount
FROM Author a
LEFT JOIN Grade g ON a.GradeId = g.Id
GROUP BY g.Name
ORDER BY g.Name;

-- 14. What is the title of the poem that has the most words?
SELECT TOP 10 Title, WordCount
FROM Poem
ORDER BY WordCount DESC;

-- 15. Which author(s) have the most poems? (Remember authors can have the same name.)
SELECT TOP 20 a.Name, COUNT(p.Id) AS PoemCount
FROM Author a
LEFT JOIN Poem p ON a.Id = p.AuthorId
GROUP BY a.Id, a.Name
ORDER BY COUNT(p.Id) DESC;

-- 16. How many poems have an emotion of sadness?
SELECT e.Name, COUNT(p.Id) AS PoemCount
FROM Poem p
LEFT JOIN PoemEmotion pe ON p.Id = pe.PoemId
LEFT JOIN Emotion e ON e.Id = pe.EmotionId
GROUP BY e.Name
HAVING e.Name = 'Sadness';

-- 17. How many poems are not associated with any emotion?
SELECT e.Name, COUNT(p.Id) AS PoemCount
FROM Poem p
LEFT JOIN PoemEmotion pe ON p.Id = pe.PoemId
LEFT JOIN Emotion e ON e.Id = pe.EmotionId
GROUP BY e.Name
HAVING e.Name IS NULL;

-- 18. Which emotion is associated with the least number of poems?
SELECT TOP 1 e.Name, COUNT(p.Id) AS PoemCount
FROM Poem p
LEFT JOIN PoemEmotion pe ON p.Id = pe.PoemId
LEFT JOIN Emotion e ON e.Id = pe.EmotionId
GROUP BY e.Name
HAVING e.Name IS NOT NULL
ORDER BY PoemCount ASC;

-- 19. Which grade has the largest number of poems with an emotion of joy?
SELECT TOP 1 g.Name, e.Name, COUNT(p.Id) AS PoemCount
FROM Poem p
LEFT JOIN PoemEmotion pe ON p.Id = pe.PoemId
LEFT JOIN Emotion e ON e.Id = pe.EmotionId
LEFT JOIN Author a ON a.Id = p.AuthorId
LEFT JOIN Grade g ON g.Id = a.GradeId
GROUP BY g.Name, e.Name
HAVING e.Name IS NOT NULL AND e.Name = 'Joy'
ORDER BY PoemCount DESC;

-- 20. Which gender has the least number of poems with an emotion of fear?
SELECT TOP 1 g.Name, e.Name, COUNT(p.ID) AS PoemCount
FROM Poem p
LEFT JOIN PoemEmotion pe ON p.Id = pe.PoemId
LEFT JOIN Emotion e ON e.Id = pe.EmotionId
LEFT JOIN Author a ON a.Id = p.AuthorId
LEFT JOIN Gender g ON g.Id = a.GenderId
GROUP BY g.Name, e.Name
HAVING e.Name = 'Fear'
ORDER BY PoemCount ASC;