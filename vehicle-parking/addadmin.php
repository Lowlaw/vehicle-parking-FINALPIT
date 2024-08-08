<?php
session_start();
error_reporting(E_ALL);
ini_set('display_errors', 1);
include('includes/dbconn.php');

// Function to add a new admin
function addAdmin($con) {
    if ($_SERVER["REQUEST_METHOD"] == "POST") {
        // Retrieve form data
        $adminName = $_POST['AdminName'];
        $userName = $_POST['UserName'];
        $mobileNumber = $_POST['MobileNumber'];
        $securityCode = $_POST['Security_Code'];
        $email = $_POST['Email'];
        $password = md5($_POST['Password']); // Hash the password with md5()

        // Debugging: Output form data
        echo "AdminName: $adminName<br>";
        echo "UserName: $userName<br>";
        echo "MobileNumber: $mobileNumber<br>";
        echo "Security_Code: $securityCode<br>";
        echo "Email: $email<br>";
        echo "Password: $password<br>";

        // Define the procedure call and parameters
        $sql = 'CALL AddAdmin(?, ?, ?, ?, ?, ?)';

        // Prepare the statement
        if ($stmt = mysqli_prepare($con, $sql)) {
            // Bind parameters
            mysqli_stmt_bind_param($stmt, 'ssisss', $adminName, $userName, $mobileNumber, $securityCode, $email, $password);

            // Execute the statement
            if (mysqli_stmt_execute($stmt)) {
                echo "Admin added successfully.";
            } else {
                echo "Execute failed: " . mysqli_stmt_error($stmt);
            }

            // Close the statement
            mysqli_stmt_close($stmt);
        } else {
            echo "Prepare failed: " . mysqli_error($con);
        }
    }
}

// Add admin
addAdmin($con);

// Close the database connection
mysqli_close($con);
?>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Add Admin</title>
    <link href="css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container">
        <h2>Add a New Admin</h2>
        <form method="POST">
            <div class="form-group">
                <label for="AdminName">Admin Name:</label>
                <input class="form-control" id="AdminName" name="AdminName" type="text" required>
            </div>
            <div class="form-group">
                <label for="UserName">User Name:</label>
                <input class="form-control" id="UserName" name="UserName" type="text" required>
            </div>
            <div class="form-group">
                <label for="MobileNumber">Mobile Number:</label>
                <input class="form-control" id="MobileNumber" name="MobileNumber" type="text" required>
            </div>
            <div class="form-group">
                <label for="Security_Code">Security Code:</label>
                <input class="form-control" id="Security_Code" name="Security_Code" type="text" required>
            </div>
            <div class="form-group">
                <label for="Email">Email:</label>
                <input class="form-control" id="Email" name="Email" type="email" required>
            </div>
            <div class="form-group">
                <label for="Password">Password:</label>
                <input class="form-control" id="Password" name="Password" type="password" required>
            </div>
            <button class="btn btn-success" type="submit">Add Admin</button>
        </form>
    </div>
    <script src="js/jquery-1.11.1.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
</body>
</html>
