# Web Programming Project

This project is a web application with a frontend and backend, using a MySQL database. Follow the steps below to set up and run the project locally.

## Prerequisites
- **XAMPP**: Installed with Apache and MySQL modules.
- **Node.js**: Installed for running the frontend.
- **Git**: Installed for cloning repositories.
- **MySQL**: Configured and running via XAMPP.

## Setup Instructions

1. **Create and Prepare Frontend Folder**
   - Create an empty folder to store the project source code.
   - Inside this folder, create a subfolder for the frontend code (e.g., `frontend`).
   - Open a Command Prompt (cmd) in the frontend folder and clone the frontend repository:
     ```
     git clone https://github.com/minhtoan-nmt/Web-Programming-Project.git
     ```

2. **Configure XAMPP Webroot**
   - Open the XAMPP webroot folder (default: `C:/xampp/htdocs/`).
   - (Optional) Change the default webroot to a new folder where the backend code will reside by updating the XAMPP configuration (`httpd.conf` file).
   - Create a new folder for the backend code if needed.

3. **Clone Backend Repository**
   - Open a Command Prompt (cmd) in the new webroot folder (or `htdocs` if unchanged).
   - Clone the backend repository:
     ```
     git clone https://github.com/minhtoan-nmt/web_backend.git
     ```

4. **Import Database**
   - Start XAMPP and ensure the MySQL module is running.
   - Open phpMyAdmin or use a MySQL client to import the database files:
     - Import `ecommerce.sql` and `ltw.sql` into MySQL.

5. **Run the Frontend**
   - Navigate to the frontend folder (`Web-Programming-Project`) in the Command Prompt.
   - Install dependencies:
     ```
     npm i
     ```
   - Start the development server:
     ```
     npm run dev
     ```

6. **Access the Application**
   - Open a browser and navigate to:
     ```
     http://localhost:3000
     ```

## Notes
- Ensure XAMPP's Apache and MySQL services are running before accessing the application.
- If the backend folder is not in the default XAMPP webroot, ensure the new webroot path is correctly configured in XAMPP.
- Verify that the database connection settings in the backend match your MySQL configuration.

## Troubleshooting
- If `npm i` fails, ensure Node.js is installed and try deleting the `node_modules` folder and `package-lock.json` file, then run `npm i` again.
- If the application does not load at `http://localhost:3000`, check if the frontend server is running and the port is not in use.
- For database issues, confirm that `ecommerce.sql` and `ltw.sql` were imported successfully and the backend configuration points to the correct database.
