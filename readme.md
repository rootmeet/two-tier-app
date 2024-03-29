# Flask App with MySQL Docker Setup
This is a simple Flask app that interacts with a MySQL database. The app allows users to submit messages, which are then stored in the database and displayed on the frontend.

## Prerequisites
Before you begin, make sure you have the following installed:

<ul>
<li>Docker</li>
<li>Git (optional, for cloning the repository)</li>
</ul>

## Setup
Clone this repository (if you haven't already):
```
git clone https://github.com/rootmeet/two-tier-app.git
```
Navigate to the project directory:

```
cd your-repo-name
```
Create a .env file in the project directory to store your MySQL environment variables:

```
touch .env
```
Open the .env file and add your MySQL configuration:

```
MYSQL_HOST=mysql
MYSQL_USER=your_username
MYSQL_PASSWORD=your_password
MYSQL_DB=your_database
```
## Usage
<ol><li>Start the containers using Docker Compose:</li>

```
docker-compose up --build
```
<li>Access the Flask app in your web browser:</li>

<ul><li>Frontend: http://localhost</li>
<li>Backend: http://localhost:5000</li></ul><br />
<li>Create the messages table in your MySQL database:</li>

<ul><li>Use a MySQL client or tool (e.g., phpMyAdmin) to execute the following SQL commands:</li></ul>

```
CREATE TABLE messages (
    id INT AUTO_INCREMENT PRIMARY KEY,
    message TEXT
);
```
<li>Interact with the app:</li>

<ul><li>Visit http://localhost to see the frontend. You can submit new messages using the form.</li>
<li>Visit http://localhost:5000/insert_sql to insert a message directly into the messages table via an SQL query.</li></ul>
</ol>

## Cleaning Up
To stop and remove the Docker containers, press Ctrl+C in the terminal where the containers are running, or use the following command:

```
docker-compose down
```
## To run this two-tier application using without docker-compose
<ul>
<li>First create a docker image from Dockerfile</li>

```
docker build -t flaskapp .
```
<li>Now, make sure that you have created a network using following command</li>

```
docker network create twotier

```
<li>Attach both the containers in the same network, so that they can communicate with each other</li>
</ul>
i) MySQL container

```
docker run -d --name mysql -v mysql-data:/var/lib/mysql -v ./message.sql:/docker-entrypoint-initdb.d/message.sql --network=twotier -e MYSQL_DATABASE=mydb -e MYSQL_USER=root -e MYSQL_ROOT_PASSWORD="admin" -p 3360:3360 mysql:5.7
```
ii) Backend container

```
docker run -d --name flaskapp -v mysql-data:/var/lib/mysql -v ./message.sql:/docker-entrypoint-initdb.d/message.sql --network=twotier -e MYSQL_HOST=mysql -e MYSQL_USER=root -e MYSQL_PASSWORD=admin -e MYSQL_DB=mydb -p 5000:5000 flaskapp:latest
```
## Notes
<ul><li>Make sure to replace placeholders (e.g., your_username, your_password, your_database) with your actual MySQL configuration.</li>

<li>This is a basic setup for demonstration purposes. In a production environment, you should follow best practices for security and performance.</li>

<li>Be cautious when executing SQL queries directly. Validate and sanitize user inputs to prevent vulnerabilities like SQL injection.</li>

<li>If you encounter issues, check Docker logs and error messages for troubleshooting.</li></ul>