<?php
session_start();
include('includes/dbconn.php');

// Check if user is logged in
if (strlen($_SESSION['vpmsaid']) == 0) {
    header('location:logout.php');
} else {
    if (isset($_GET['id'])) {
        $id = intval($_GET['id']);

        // Prepare and call the stored procedure
        if ($stmt = $con->prepare("CALL DeleteVehicle(?)")) {
            $stmt->bind_param('i', $id);
            $stmt->execute();

            if ($stmt->affected_rows > 0) {
                $msg = "Vehicle record deleted successfully.";
            } else {
                $msg = "No vehicle found with the provided ID or deletion failed.";
            }

            $stmt->close();
        } else {
            $msg = "Failed to prepare the SQL statement.";
        }

        // Redirect to the main page after deletion
        header('Location: out-vehicles.php');
        exit;
    }
}
?>