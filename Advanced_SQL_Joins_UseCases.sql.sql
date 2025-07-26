CREATE DATABASE joins;
USE joins;
show Tables;
-- practise questions --Q1: Write a query to list all employees with their department names. Only include employees who have a department assigned.
Q1: Write a query to list all employees with their department names. Only include employees who have a department assigned.
Expected Result: Returns employees that are present in both Employees and Departments.

Q2: Write a query to list all employees and their respective departments, even if some employees don’t have a department assigned.

Expected Result: Returns all employees, even those without a matching department in the Departments table.  

Q3: Write a query to list all departments and the employees working in those departments, even if some departments don’t have employees assigned.

Expected Result: Returns all departments, even those without matching employees in the Employees table.

Q4: Write a query to list all projects and the names of the employees assigned to those projects. Show projects even if no employee is assigned.

Q5: Write a query to list all employees who are assigned to projects along with their department names and project names.

Expected Result: Show the employee s name, their department, and the project they are working on, but only for those who are assigned a project.

Q6: Write a query to list all projects and the employees assigned to them. If a project has no employee assigned, display the project name with NULL for employee details.

Q7: Write a query to display all departments and employees working in those departments. Include departments even if they have no employees.

Q8: Write a query to find all employees who are not assigned to any projects. Include their department names as well.

Q9: Write a query to display employees with a salary greater than 50,000 who belong to the 'Engineering' department.

Q10: Write a query to display all departments and any employee with a salary greater than 50,000. Show departments even if they don’t have high-salaried employees.

CREATE TABLE Employees (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    department_id INT,
    salary DECIMAL(10, 2)
);

INSERT INTO Employees (emp_id, emp_name, department_id, salary) VALUES
(1, 'John', 101, 50000),
(2, 'Jane', 102, 60000),
(3, 'Alice', 103, 55000),
(4, 'Bob', 101, 45000),
(5, 'Tom', 104, 48000);
SELECT * FROM employees;

CREATE TABLE Departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(50)
);

INSERT INTO Departments (department_id, department_name) VALUES
(101, 'HR'),
(102, 'Finance'),
(103, 'Engineering'),
(105, 'Marketing');
SELECT * FROM Departments;
CREATE TABLE Projects (
    project_id INT PRIMARY KEY,
    project_name VARCHAR(50),
    emp_id INT
);

INSERT INTO Projects (project_id, project_name, emp_id) VALUES
(1, 'Project A', 1),
(2, 'Project B', 2),
(3, 'Project C', 3),
(4, 'Project D', 6);

SELECT e.emp_name,d.department_name FROM employees e INNER JOIN Departments d ON e.department_id = d.department_id;
SELECT e.emp_name,d.department_name FROM employees e LEFT JOIN Departments d ON e.department_id = d.department_id;
SELECT d.department_name,e.emp_name FROM employees e RIGHT JOIN Departments d ON e.department_id = d.department_id;
SELECT p.project_name,e.emp_name FROM Projects p LEFT JOIN employees e ON p.emp_id = e.emp_id;
SELECT e.emp_name,p.project_name FROM employees e LEFT JOIN Projects p ON e.emp_id = p.emp_id;
SELECT e.emp_name,p.project_name,department_name FROM employees e INNER JOIN projects p ON e.emp_id=p.emp_id INNER JOIN 
Departments d ON e.department_id = d.department_id;
SELECT p.project_name,e.emp_name FROM Projects p LEFT JOIN employees e ON p.emp_id=e.emp_id;
SELECT e.emp_name,d.department_name FROM employees e RIGHT JOIN Departments d ON e.department_id=d.department_id;
SELECT e.emp_name,p.project_name,d.department_name FROM employees e LEFT JOIN Projects p ON e.emp_id=p.emp_id 
LEFT JOIN Departments d ON e.department_id = d.department_id WHERE project_id IS NULL;
SELECT e.emp_name,d.department_name FROM employees e INNER JOIN Departments d ON e.department_id = d.department_id 
WHERE salary>50000 AND department_name='Engineering';
SELECT d.department_name,e.emp_name,e.salary FROM Departments d LEFT JOIN employees e ON d.department_id=e.department_id WHERE salary>50000 OR salary IS NULL;

-- Practice Questions
Find Series by Director:

Question 1: Retrieve all series titles along with their directors names. Ensure that only series with directors are included.
Series Without Ratings:

Question 2: List all series that do not have a rating (i.e., no entry in the Ratings table). Display the series title and released year.

Directors Without Series:

Question 3: Show all directors who have not directed any series. Include their names and countries.

Top Rated Series:

Question 4: Find the titles of all series with an IMDb rating of 8.5 or higher along with their director names.
Series with Ratings but No Gross:

Question 5: Retrieve series that have a rating but no gross income recorded. Display the series title and IMDb rating.
Average Ratings by Director:

Question 6: Calculate the average IMDb rating for each director and show the directors name along with the average rating.
Genres with No Series:

Question 7: Assuming you have a genres table (not provided here), find all genres that do not have any series associated with them.
High Gross Series:

Question 8: List series that have gross income of over 700,000 along with their directors.
All Series with Null Ratings:

Question 9: Display all series that have a NULL value for their metascore along with their titles.
Directors with At Least One Series:

Question 10: Find all directors who have directed at least one series. Show their names and the number of series they directed.;
-- Join Type
-- Create Series Table
CREATE TABLE Series (
    Series_ID INT PRIMARY KEY,
    Series_Title VARCHAR(100),
    Genre VARCHAR(50),
    Released_Year INT,
    Director_ID INT
);
-- Insert data into Series Table
INSERT INTO Series (Series_ID, Series_Title, Genre, Released_Year, Director_ID) VALUES
(1, 'The Crown', 'Drama', 2016, 1),
(2, 'Stranger Things', 'Sci-Fi', 2016, 2),
(3, 'The Queen\'s Gambit', 'Drama', 2020, 1),
(4, 'Breaking Bad', 'Crime', 2008, 3),
(5, 'The Witcher', 'Fantasy', 2019, 4),
(6, 'Money Heist', 'Action', 2017, 5);
INSERT INTO Series (Series_ID, Series_Title, Genre, Released_Year, Director_ID) VALUES
(7, 'Unrated Series', 'Comedy', 2021, 1); -- This series will not be in Ratings.


-- Create Directors Table
CREATE TABLE Directors (
    Director_ID INT PRIMARY KEY,
    Director_Name VARCHAR(100),
    Country VARCHAR(50)
);
-- Insert data into Directors Table
INSERT INTO Directors (Director_ID, Director_Name, Country) VALUES
(1, 'Peter Morgan', 'UK'),
(2, 'The Duffer Brothers', 'USA'),
(3, 'Vince Gilligan', 'USA'),
(4, 'Lauren Schmidt', 'USA'),
(5, 'Álex Pina', 'Spain');
INSERT INTO Directors (Director_ID, Director_Name, Country) VALUES
(6, 'New Director', 'USA'); -- This director has no series associated.


-- Create Ratings Table
CREATE TABLE Ratings (
    Series_ID INT,
    IMDb_Rating DECIMAL(3, 1),
    Metascore INT,
    No_of_Votes INT,
    Gross INT,
    FOREIGN KEY (Series_ID) REFERENCES Series(Series_ID)
);
-- Insert data into Ratings Table
INSERT INTO Ratings (Series_ID, IMDb_Rating, Metascore, No_of_Votes, Gross) VALUES
(1, 8.7, 87, 20000, 1000000),
(2, 8.8, 75, 15000, 800000),
(3, 8.6, 92, 18000, 900000),
(4, 9.5, 95, 30000, 1200000),
(5, 8.2, 80, 12000, 700000),
(6, 8.3, NULL, 11000, 600000);
INSERT INTO Ratings (Series_ID, IMDb_Rating, Metascore, No_of_Votes, Gross) VALUES
(7, 9.0, 90, 15000, NULL); -- New entry for "Unrated Series" with no gross


-- Create Genres Table
CREATE TABLE Genres (
    Genre_ID INT PRIMARY KEY,
    Genre_Name VARCHAR(50)
);
-- Insert data into Genres Table
INSERT INTO Genres (Genre_ID, Genre_Name) VALUES
(1, 'Drama'),
(2, 'Sci-Fi'),
(3, 'Crime'),
(4, 'Fantasy'),
(5, 'Action');
INSERT INTO Genres ( Genre_ID,Genre_Name) VALUES
(6, 'Comedy'),       -- Associated with "Unrated Series"
(7, 'Mystery'),      -- Not associated with any series
(8, 'Romance');      -- Not associated with any series

SELECT S.Series_Title,D.Director_Name FROM Series S INNER JOIN Directors D ON S.Director_id=D.Director_id;

SELECT S.Series_Title,S.Released_Year,R.IMDb_Rating FROM Series S LEFT JOIN Ratings R ON S.Series_id=R.Series_id
WHERE IMDb_Rating IS NULL;

SELECT D.Director_name,D.Country,S.Series_Title FROM Directors D LEFT JOIN Series S ON D.Director_id=S.Director_id 
WHERE Series_Title IS NULL; 

SELECT S.Series_Title,R.IMDB_Rating,D.Director_name FROM Series S LEFT JOIN Ratings R ON S.Series_id=R.Series_id 
INNER JOIN Directors D  ON S.Director_id=D.Director_id WHERE IMDB_Rating>=8.5;

SELECT S.Series_Title,R.IMDB_Rating FROM Series S INNER JOIN Ratings R ON S.Series_id=R.Series_id WHERE Gross IS NULL;

SELECT D.Director_name,R.IMDB_Rating,AVG(R.IMDB_Rating) AS 'Average_Ratings' FROM Directors D INNER JOIN Series S 
ON D.Director_id=S.Director_id INNER JOIN Ratings R ON S.Series_id=R.Series_id GROUP BY D.Director_id;

SELECT S.Series_Title,G.Genre_Name FROM Series S RIGHT JOIN Genres G ON S.Series_id =G.Genre_id WHERE Series_Title IS NULL;

SELECT S.Series_Title,R.Gross,D.Director_name FROM Series S JOIN Ratings R ON S.Series_id = R.Series_id INNER JOIN Directors D ON
S.Director_id = D.Director_id  WHERE Gross >=700000;

SELECT S.Series_Title,R.Metascore FROM Series S LEFT JOIN Ratings R ON S.Series_id = R.Series_id WHERE Metascore IS NULL;

SELECT D.Director_name,S.Series_Title,COUNT(S.Series_Title) AS 'no_of_series' FROM Directors D INNER JOIN Series S 
ON D.Director_id = S.Director_id GROUP BY Director_name HAVING no_of_series>=1;

SELECT S.Series_Title,R.Metascore FROM Series S LEFT JOIN Ratings R ON S.Series_id = R.Series_id WHERE Metascore IS NULL;

-- Tricky SQL Questions
Question 1: All Directors and Their Series

Task: Retrieve a list of all directors and their associated series. Include directors who have not directed any series. Display the director name and series title. If a director has no series, show NULL for the series title.

Question 2: Series without Ratings

Task: Find all series that have not received any ratings. Display the series title and genre. Make sure to include genres even if there are no series linked to them.

Question 3: Total Votes by Genre

Task: Calculate the total number of votes received by series, grouped by genre. Display the genre name and total votes. If a genre has no associated series, display the genre name with a total of 0 votes.

Question 4: Directors with Average Ratings

Task: For each director, find the average IMDb rating of their series. Include directors who have not directed any series, and display their name with an average rating of NULL.

Question 5: Highest Rated Series in Each Genre

Task: For each genre, find the highest-rated series. Display the genre name, series title, and IMDb rating. If a genre has no series, display the genre name with NULL for series title and rating.

Question 6: Series Released After a Certain Year

Task: List all series that were released after 2015 along with their directors and ratings. If a series does not have a rating, still include it with NULL for the rating.

Question 7: Directors with No Ratings

Task: Find all directors and the number of series they have directed with a NULL Metascore. Display the director name and the count of series. If a director has no series with a NULL Metascore, show 0;

SELECT D.Director_name,S.Series_Title FROM Directors D LEFT JOIN Series S ON D.Director_id =S.Director_id ;

SELECT S.Series_Title,R.IMDB_Rating,G.Genre_name FROM Series S LEFT JOIN Ratings R ON S.Series_id = R.Series_id 
LEFT JOIN Genres G ON S.Series_id = G.Genre_id WHERE IMDB_Rating IS NULL;

SELECT G.Genre_name,coalesce(sum(R.No_of_Votes),0) AS 'Total_Votes' FROM Genres G LEFT JOIN Series S 
ON G.Genre_id = S.Series_id LEFT JOIN Ratings R ON S.Series_id=R.Series_id GROUP BY Genre_name;

SELECT D.Director_name,COALesce(AVG(R.IMDB_Rating),0) AS 'Average_Rating' FROM Directors D LEFT JOIN Series S ON D.Director_id= S.Director_id
LEFT JOIN Ratings R ON S.Series_id = R.Series_id GROUP BY Director_name;

SELECT G.Genre_name,coalesce(S.Series_Title,'0'),coalesce(R.IMDB_Rating,'NULL'),coalesce(MAX(R.IMDB_Rating),'NULL') AS 'Highest_Rated' 
FROM Genres G LEFT JOIN Series S ON G.Genre_id=S.Series_id LEFT JOIN Ratings R ON S.Series_id=R.Series_id GROUP BY G.Genre_name;

SELECT S.Series_Title,D.Director_name,coalesce(R.IMDB_Rating,'NULL') FROM Directors D join Series S ON D.Director_id=S.Director_id
INNER JOIN Ratings R ON S.Series_id = R.Series_id WHERE Released_Year>2015;

SELECT D.Director_name,coalesce(count(Series_Title),0) AS 'Total_No_Of_Series' FROM Directors D LEFT JOIN Series S ON 
D.Director_id = S.Director_id LEFT JOIN Ratings R ON S.Series_id=R.Series_id WHERE Metascore IS  NULL group by Director_name;

-- Easy Level (1-15) 
1.Retrieve all movie titles and their corresponding genres.
2.List all the directors along with the titles of the movies they directed.
3.Find the IMDb rating and metascore for each movie.
4.Display all actors along with the movies they acted in.
5.Get the list of movies along with their release year and the name of their director.
6.Show the names of all movies with their genres and directors.
7.Retrieve all the movies along with their IMDb rating and no. of votes.
8.Get the list of all actors who acted in the movie “Inception.”
9.Retrieve a list of all movies released in 2019 along with their directors.
10.Display all genres along with the titles of movies in each genre.
11.List all actors who have acted in more than one movie.
12.Retrieve the movie title and the corresponding director for all movies that have a metascore above 85.
13.Get the name of the director and the total number of movies they have directed.
14.Find all movies released after 2015 with their genres and IMDb ratings.
15.List all movies directed by Christopher Nolan with their release years.
Medium Level (16-35)
16.Retrieve a list of movies and the names of the actors in them. Also, show the movie’s IMDb rating.
17.Find all movies along with their directors and the genres they belong to.
18.Get a list of movies that have an IMDb rating greater than 8.5 but less than 9, along with their actors.
19.List all movies that belong to the “Action” genre and have a metascore of at least 80.
20.Show the names of all directors who directed a movie with a rating higher than 9.0.
21.Find all actors who acted in movies released before 2010.
22.Retrieve a list of movies and the total number of votes they received, grouped by their genres.
23.Get all movies and their corresponding actors for the genre “Sci-Fi.”
24.Find the top 3 highest-rated movies in each genre along with their directors.
25.List all movies that have more than 1 actor along with their genres and IMDb rating.
26.Retrieve a list of actors who have acted in movies directed by Christopher Nolan.
27.Find all directors who have not directed any movie.
28.Retrieve the director’s name and the number of movies they have directed in the genre “Drama.”
29.Display all movies with their ratings, even if the movies don’t have an IMDb rating.
30.Find the names of all actors who acted in at least 2 movies that belong to different genres.
31.Show the list of movies that have the same genre as "Parasite" along with their directors.
32.Retrieve the title of the highest-rated movie in each genre.
33.Get the list of all actors and the number of movies they have acted in.
34.Find all movies released between 2005 and 2015 and the total number of votes each movie received.
35.Get the list of actors who acted in both “Inception” and “The Dark Knight.”
Hard Level (36-50)
36.Retrieve the name of the director who directed the most movies, along with the count of their movies.
37.Find the names of actors who have worked with more than one director.
38.Get a list of all movies with their genres and IMDb ratings, including genres that don’t have any movies.
39.Find the actor who has acted in the most movies, along with the count of their movies.
40.Retrieve the name of the actor and the number of movies they acted in for each genre.
41.Get the names of actors who acted in a movie with an IMDb rating greater than 8.5 but have not acted in any movie with a rating below 8.0.
42.List all directors who have directed at least 2 movies in different genres.
43.Find the total number of votes for movies directed by each director, even if the director has no movie.
44.Display the names of all actors who have not worked with a specific director (e.g., Quentin Tarantino).
45.Get the list of actors who have acted in a movie that received a metascore higher than 90.
46.Retrieve the names of all directors who directed movies in multiple genres.
47.Find the director who directed the highest-rated movie in the genre “Crime.”
48.List all movies that have more than 5 actors and their corresponding genres.
49.Retrieve the names of directors who have directed both “Action” and “Drama” movies.
50.Find the actor who has worked with the most number of directors;

CREATE DATABASE ALLJOINS;
USE ALLJOINS;
-- Create Movies Table
CREATE TABLE Movies (
    Movie_ID INT PRIMARY KEY,
    Movie_Title VARCHAR(255),
    Genre_ID INT,
    Director_ID INT,
    Release_Year INT,
    CONSTRAINT FOREIGN KEY (Genre_ID) REFERENCES Genres(Genre_ID),
    CONSTRAINT FOREIGN KEY (Director_ID) REFERENCES Directors(Director_ID)
);
INSERT INTO Movies (Movie_ID, Movie_Title, Genre_ID, Director_ID, Release_Year) VALUES
(1, 'Inception', 1, 1, 2010),
(2, 'Interstellar', 1, 1, 2014),
(3, 'Dunkirk', 2, 1, 2017),
(4, 'Pulp Fiction', 3, 2, 1994),
(5, 'The Dark Knight', 1, 1, 2008),
(6, 'Kill Bill', 4, 2, 2003),
(7, 'Parasite', 5, 3, 2019),
(8, '1917', 2, 4, 2019);

-- Create Directors Table
CREATE TABLE Directors (
    Director_ID INT PRIMARY KEY,
    Director_Name VARCHAR(255)
);
INSERT INTO Directors (Director_ID, Director_Name) VALUES
(1, 'Christopher Nolan'),
(2, 'Quentin Tarantino'),
(3, 'Bong Joon-ho'),
(4, 'Sam Mendes');

-- Create Genres Table
CREATE TABLE Genres (
    Genre_ID INT PRIMARY KEY,
    Genre_Name VARCHAR(255)
);
INSERT INTO Genres (Genre_ID, Genre_Name) VALUES
(1, 'Sci-Fi'),
(2, 'War'),
(3, 'Crime'),
(4, 'Action'),
(5, 'Drama');

-- Create Ratings Table
CREATE TABLE Ratings (
    Rating_ID INT PRIMARY KEY,
    Movie_ID INT,
    IMDb_Rating DECIMAL(3, 1),
    Metascore INT,
    No_of_Votes INT,
    FOREIGN KEY (Movie_ID) REFERENCES Movies(Movie_ID)
);
INSERT INTO Ratings (Rating_ID, Movie_ID, IMDb_Rating, Metascore, No_of_Votes) VALUES
(1, 1, 8.8, 87, 2000000),
(2, 2, 8.6, 84, 1500000),
(3, 3, 7.9, 78, 1200000),
(4, 4, 8.9, 94, 1800000),
(5, 5, 9.0, 82, 2200000),
(6, 6, 8.1, 85, 1100000),
(7, 7, 8.6, 96, 3000000),
(8, 8, 8.4, 81, 1400000);

-- Create Actors Table
CREATE TABLE Actors (
    Actor_ID INT PRIMARY KEY,
    Actor_Name VARCHAR(255)
);
INSERT INTO Actors (Actor_ID, Actor_Name) VALUES
(1, 'Leonardo DiCaprio'),
(2, 'Brad Pitt'),
(3, 'Margot Robbie'),
(4, 'Cillian Murphy'),
(5, 'Tom Hardy'),
(6, 'Song Kang-ho'),
(7, 'George MacKay');

-- Create Movie_Actors Table (Relationship table)
CREATE TABLE Movie_Actors (
    Movie_ID INT,
    Actor_ID INT,
    FOREIGN KEY (Movie_ID) REFERENCES Movies(Movie_ID),
    FOREIGN KEY (Actor_ID) REFERENCES Actors(Actor_ID)
);
INSERT INTO Movie_Actors (Movie_ID, Actor_ID) VALUES
(1, 1), -- Inception: Leonardo DiCaprio
(1, 4), -- Inception: Cillian Murphy
(2, 1), -- Interstellar: Leonardo DiCaprio
(2, 5), -- Interstellar: Tom Hardy
(3, 4), -- Dunkirk: Cillian Murphy
(3, 5), -- Dunkirk: Tom Hardy
(4, 2), -- Pulp Fiction: Brad Pitt
(4, 3), -- Pulp Fiction: Margot Robbie
(5, 1), -- The Dark Knight: Leonardo DiCaprio
(5, 5), -- The Dark Knight: Tom Hardy
(6, 2), -- Kill Bill: Brad Pitt
(7, 6), -- Parasite: Song Kang-ho
(8, 7); -- 1917: George MacKay

SELECT M.Movie_Title,G.Genre_name FROM Movies M LEFT JOIN Genres G ON M.Movie_id = G.Genre_id;

SELECT D.Director_name,M.Movie_Title FROM Directors D LEFT JOIN Movies M ON D.Director_id=M.Director_id;

SELECT M.Movie_Title,R.IMDb_Rating,R.Metascore FROM Movies M LEFT JOIN Ratings R ON M.Movie_id=R.Movie_id;

SELECT A.Actor_name,M.Movie_Title FROM Actors A LEFT JOIN Movies M ON A.Actor_id=M.Movie_id;

SELECT A.Actor_name,M.Movie_Title FROM Movie_Actors MM INNER JOIN  Movies M ON MM.Movie_id=M.Movie_id INNER JOIN Actors A ON MM.Actor_id=A.Actor_id;

SELECT M.Movie_Title,M.Release_Year,D.Director_name FROM Movies M LEFT JOIN Directors D ON M.Director_id=D.Director_id;

SELECT M.Movie_Title,G.Genre_name,D.Director_name FROM Movies M INNER JOIN Genres G ON M.Movie_id=G.Genre_id 
INNER JOIN Directors D ON M.Director_id=D.Director_id;

SELECT M.Movie_Title,R.IMDB_Rating,R.No_of_Votes FROM Movies M INNER JOIN Ratings R ON M.Movie_id=R.Movie_id;

SELECT A.Actor_name,M.Movie_Title,MM.Actor_id FROM Movies M INNER JOIN Movie_Actors MM ON M.Movie_id=MM.Movie_id
INNER JOIN Actors A ON MM.Actor_id = A.Actor_id WHERE M.Movie_Title='Inception';

SELECT M.Movie_Title,D.Director_name FROM Movies M INNER JOIN Directors D ON M.Director_id=D.Director_id WHERE Release_Year=2019;

SELECT G.Genre_name,M.Movie_Title FROM Genres G LEFT JOIN Movies M ON G.Genre_id=M.Genre_id ;

SELECT A.Actor_name,count(M.Movie_Title) AS 'NO_OF_MOVIES' FROM Movies M INNER JOIN Movie_Actors MM ON M.Movie_id=MM.Movie_id
INNER JOIN Actors A ON MM.Actor_id = A.Actor_id GROUP BY Actor_name HAVING NO_OF_MOVIES>1;

SELECT M.Movie_Title,D.Director_name FROM Movies M INNER JOIN Directors D ON M.Director_id=D.Director_id
INNER JOIN Ratings R ON M.Movie_id=R.Movie_id WHERE Metascore>85;

SELECT D.Director_name,COUNT(M.Movie_Title) AS 'TotAL_No_Of_Movies' FROM Directors D LEFT JOIN Movies M ON D.Director_id=M.Director_id
GROUP BY Director_name;

SELECT M.Movie_Title,G.Genre_name,R.IMDB_Rating FROM Movies M inner JOIN Genres G ON M.Genre_id=G.Genre_id 
inner JOIN Ratings R ON M.Movie_id=R.Movie_id WHERE Release_Year>2015;

SELECT M.Movie_Title,Release_Year,D.Director_name FROM Movies M INNER JOIN Directors D ON M.Director_id=D.Director_id
WHERE Director_name='Christopher Nolan';

SELECT M.Movie_Title,A.Actor_name,R.IMDB_Rating FROM Movies M INNER JOIN Movie_Actors MA ON M.Movie_id=MA.Movie_id INNER JOIN
Actors A ON MA.Actor_id=A.Actor_id INNER JOIN Ratings R ON M.Movie_ID =R.Movie_id;

SELECT M.Movie_Title,D.Director_name,G.Genre_name FROM Movies M LEFT JOIN Directors D ON M.Director_id=D.Director_id
LEFT JOIN Genres G ON M.Genre_id=G.Genre_id;

SELECT M.Movie_Title,R.IMDB_Rating,A.Actor_name FROM Movies M  JOIN Ratings R ON M.Movie_id=R.Movie_id  JOIN Movie_Actors MA
ON M.Movie_id =MA.Movie_id  JOIN Actors A ON A.Actor_id=MA.Actor_id WHERE IMDB_Rating>8.5 AND IMDB_Rating<9 ;

SELECT M.Movie_Title,G.Genre_name,R.Metascore FROM Movies M INNER JOIN Genres G ON M.Genre_id=G.Genre_id INNER JOIN Ratings
R ON M.Movie_id =R.Movie_id WHERE Metascore>=8 AND Genre_name='Action';

SELECT D.Director_name FROM Movies M INNER JOIN Directors D ON M.Director_id=D.Director_id INNER JOIN Ratings R ON M.Movie_id=R.Movie_id
WHERE IMDB_Rating>9;

SELECT A.Actor_name FROM Movies M INNER JOIN Movie_Actors MA ON M.Movie_id =MA.Movie_id INNER JOIN Actors A ON MA.Actor_id=A.Actor_id
WHERE Release_Year<2010 GROUP BY Actor_name;

SELECT G.Genre_name,COALESCE(SUM(R.No_of_Votes),0) AS 'Total_Votes' FROM Movies M INNER JOIN Ratings R ON M.Movie_id=R.Movie_id
INNER JOIN Genres G ON M.Genre_id=G.Genre_id GROUP BY Genre_name;

SELECT M.Movie_Title,A.Actor_name,G.Genre_name FROM Movies M INNER JOIN Movie_Actors MA ON M.Movie_id=MA.Movie_id INNER JOIN
Genres G ON M.Genre_id=G.Genre_id INNER JOIN Actors A ON MA.Actor_id=A.Actor_id WHERE Genre_name='Sci-Fi';

WITH RankedMovies AS (
    SELECT G.Genre_name, 
           M.Movie_Title, 
           D.Director_name, 
           R.IMDB_Rating,
           ROW_NUMBER() OVER (PARTITION BY G.Genre_name ORDER BY R.IMDB_Rating DESC) AS RANKK
FROM Movies M LEFT JOIN Directors D ON M.Director_id=D.Director_id
LEFT JOIN Ratings R ON M.Movie_id=R.Movie_id LEFT JOIN Genres G ON M.Genre_id=G.Genre_id)
SELECT Genre_name, Movie_Title, Director_name,IMDB_Rating
FROM RankedMovies
WHERE RANKK <= 3
ORDER BY Genre_name, RANKK;

SELECT M.Movie_Title,G.Genre_name,IMDB_Rating,COUNT(A.Actor_name) AS 'Total_no_of_Actor'  FROM Movies M LEFT JOIN Movie_Actors MA
ON M.Movie_id=MA.Movie_id LEFT JOIN Actors A ON MA.Actor_id=A.Actor_id LEFT JOIN Ratings R ON M.Movie_id=R.Movie_id LEFT JOIN Genres G
ON M.Genre_id=G.Genre_id GROUP BY Movie_Title HAVING Total_no_of_Actor>1;

SELECT A.Actor_name,D.Director_name FROM Movies M INNER JOIN Directors D ON M.Director_id=D.Director_id INNER JOIN Movie_Actors MA ON
M.Movie_id=MA.Movie_id INNER JOIN Actors A ON MA.Actor_id=A.Actor_id WHERE Director_name='Christopher Nolan' GROUP BY Actor_name;

SELECT D.Director_name FROM Movies M RIGHT JOIN Directors D ON 
M.Director_id=D.Director_id WHERE Movie_Title IS NULL;

SELECT D.Director_name,G.Genre_name,COUNT(Movie_Title) AS 'Total_no_of_Movies' FROM Directors D INNER JOIN Movies M ON 
D.Director_id=M.Director_id
INNER JOIN Genres G ON M.Genre_id=G.Genre_id GROUP BY Director_name HAVING Genre_name='Drama';

SELECT M.Movie_Title,R.IMDB_Rating FROM Movies M LEFT JOIN Ratings R ON M.Movie_id=R.Movie_id;

SELECT A.Actor_name FROM Movies M JOIN Movie_Actors MA ON M.Movie_id=MA.Movie_id JOIN Actors A ON MA.Actor_id=A.Actor_id
JOIN Genres G ON M.Genre_id=G.Genre_id GROUP BY Actor_name HAVING COUNT(DISTINCT(Genre_name))>=2;

SELECT M.Movie_Title,D.Director_name,G.Genre_name FROM Movies M JOIN Directors D ON M.Director_id=D.Director_id JOIN Genres G ON 
M.Genre_id=G.Genre_id WHERE Genre_name=(SELECT Genre_name FROM Movies M JOIN Genres G ON M.Genre_id=G.Genre_id WHERE M.Movie_Title='Parasite'); 

SELECT G.Genre_name,M.Movie_Title,MAX(R.IMDB_Rating) AS 'Highest_Rating' FROM Movies M JOIN Genres G ON M.Genre_id=G.Genre_id JOIN 
Ratings R ON M.Movie_id=R.Movie_id GROUP BY Genre_name;

SELECT A.Actor_name,COUNT(M.Movie_Title) AS 'total_no_of-movies' FROM Actors A LEFT JOIN Movie_Actors MA ON A.Actor_id=MA.Actor_id LEFT JOIN 
Movies M ON MA.Movie_id=M.Movie_id GROUP BY Actor_name; 

SELECT M.Movie_Title,R.No_of_Votes FROM Movies M LEFT JOIN Ratings R ON M.Movie_id=R.Movie_id WHERE Release_Year>=2005 AND Release_Year<=2015;

SELECT A.Actor_name FROM Movies M JOIN Movie_Actors MA ON M.Movie_id=MA.Movie_id JOIN Actors A ON MA.Actor_id=A.Actor_id
WHERE Movie_Title IN ('Inception','The Dark Knight') GROUP BY Actor_name HAVING COUNT(DISTINCT Movie_Title)=2;

SELECT D.Director_name,COUNT(M.Movie_Title) AS 'total_no_of_movies' FROM Movies M JOIN Directors D ON M.Director_id=D.Director_id
GROUP BY Director_name ORDER BY total_no_of_movies DESC LIMIT 1;

SELECT A.Actor_name,COUNT(D.Director_name) AS 'total_no_of_director' FROM Actors A JOIN Movie_Actors MA ON A.Actor_id=MA.Actor_id
JOIN Movies M ON MA.Movie_id=M.Movie_id JOIN Directors D ON M.Movie_id=D.Director_id GROUP BY Actor_name HAVING total_no_of_director>1;

SELECT M.Movie_Title,R.IMDB_Rating,G.Genre_name FROM Movies M LEFT JOIN Ratings R ON M.Movie_id=R.Movie_id RIGHT JOIN Genres G 
ON M.Genre_id=G.Genre_id;

SELECT A.Actor_name,COUNT(M.Movie_Title) AS 'total_no_of_movies' FROM Movies M LEFT JOIN Movie_Actors MA ON M.Movie_id=MA.Movie_id
JOIN Actors A ON MA.Actor_id=A.Actor_id GROUP BY Actor_name ORDER BY total_no_of_movies DESC LIMIT 1;

SELECT G.Genre_name,A.Actor_name,COUNT(M.Movie_Title) AS 'total_no_of_movies' FROM Movies M LEFT JOIN Movie_Actors MA ON 
M.Movie_id=MA.Movie_id JOIN Actors A ON MA.Actor_id=A.Actor_id JOIN Genres G ON M.Genre_id=G.Genre_id GROUP BY Genre_name,Actor_name;

SELECT A.Actor_name,R.IMDB_Rating,M.Movie_Title FROM Movies M JOIN Ratings R ON M.Movie_id=R.Movie_id JOIN Movie_Actors MA ON
 M.Movie_id=MA.Movie_id JOIN Actors A ON MA.Actor_id=A.Actor_id WHERE IMDB_Rating>8.5 AND Actor_name NOT IN (SELECT A.Actor_name 
FROM Movies M JOIN Ratings R ON M.Movie_id=R.Movie_id JOIN Movie_Actors MA ON M.Movie_id=MA.Movie_id JOIN Actors A ON
 MA.Actor_id=A.Actor_id WHERE IMDB_Rating<8) GROUP BY ACtor_name ;
 
 SELECT D.Director_name,COUNT(M.Movie_Title) AS 'total_no_of_movies' FROM Directors D JOIN Movies M ON D.Director_id=M.Director_id 
 group by Director_name HAVING total_no_of_movies>=2;
 
 SELECT D.Director_name,M.Movie_Title,SUM(R.No_of_Votes) as 'total_no_of_votes' FROM Directors D LEFT JOIN Movies M ON D.Director_id=M.Director_id
 LEFT JOIN Ratings R ON M.Movie_id=R.Movie_id GROUP BY Director_name,Movie_Title;
 
 SELECT A.Actor_name FROM Actors A LEFT JOIN Movie_Actors MA ON A.Actor_id=MA.Actor_id JOIN Movies M
 ON MA.Movie_id=M.Movie_id JOIN Directors D ON M.Director_id=D.Director_id WHERE Director_name !='Quentin Tarantino' GROUP  BY Actor_name;
 
 SELECT A.Actor_name FROM Actors A LEFT JOIN Movie_Actors MA ON A.Actor_id=MA.Actor_id JOIN Movies M ON MA.Movie_id
 =M.Movie_id JOIN Ratings R ON M.Movie_id=R.Movie_id WHERE Metascore>90 GROUP BY Actor_name;
 
 SELECT D.Director_name FROM Directors D LEFT JOIN Movies M ON D.Director_id=M.Director_id JOIN
 Genres G ON M.Genre_id=G.Genre_id GROUP BY Director_name HAVING COUNT(DISTINCT G.Genre_id)>1;
 
 SELECT D.Director_name FROM Directors D JOIN Movies M ON D.Director_id=M.Movie_id JOIN Genres G ON M.Genre_id=G.Genre_id JOIN Ratings R 
 ON M.Movie_id=R.Movie_id WHERE G.Genre_name='Crime' GROUP BY Director_name HAVING MAX(R.IMDB_Rating);
 
 SELECT M.Movie_Title,G.Genre_name FROM Movies M JOIN Genres G ON M.Genre_id=G.Genre_id JOIN Movie_Actors MA ON M.Movie_id=MA.Movie_id
 JOIN Actors A ON MA.Actor_id=A.Actor_id GROUP BY Actor_name HAVING COUNT(Actor_name)>5;
 
 SELECT D.Director_name FROM Directors D JOIN Movies M ON D.Director_id=M.Director_id JOIN Genres G ON M.Genre_id=G.Genre_id
 JOIN Movie_Actors MA ON M.Movie_id=MA.Movie_id JOIN Actors A ON MA.Actor_id=A.Actor_id WHERE Genre_name in ('Sci-Fi','War') GROUP BY 
 Director_name HAVING COUNT(DISTINCT Genre_name)=2;
 
 SELECT A.Actor_name,MAX(D.Director_id) AS 'total_no_of_director'  FROM Movie_Actors MA LEFT JOIN Movies M ON MA.Movie_id=M.Movie_id
 JOIN Actors A ON MA.Actor_id=A.Actor_id JOIN Directors D ON M.Director_id=D.Director_id GROUP BY Actor_name 
 ORDER BY total_no_of_director DESC LIMIT 1;
 
 
 -- COMPLETED
 
 
 SELECT * FROM Movies;
 SELECT * FROM Genres;
 SELECT * FROM Movies M LEFT JOIN Genres G ON  M.Genre_ID=G.Genre_ID UNION ALL
 SELECT * FROM Movies M RIGHT JOIN Genres G ON M.Genre_ID=G.Genre_ID;
 
 