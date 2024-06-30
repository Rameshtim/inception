<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Basic Calculator</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            text-align: center;
            margin-top: 50px;
        }
        input[type="number"] {
            width: 100px;
            padding: 5px;
            margin: 5px;
        }
        select {
            padding: 5px;
            margin: 5px;
        }
        button {
            padding: 10px 20px;
            margin: 10px;
        }
        .result {
            margin-top: 20px;
            font-size: 20px;
            font-weight: bold;
        }
    </style>
</head>
<body>
    <h1>Basic Calculator</h1>
    <form method="post">
        <input type="number" name="num1" placeholder="First Number" required>
        <select name="operation" required>
            <option value="add">+</option>
            <option value="subtract">-</option>
            <option value="multiply">*</option>
            <option value="divide">/</option>
        </select>
        <input type="number" name="num2" placeholder="Second Number" required>
        <br>
        <button type="submit">Calculate</button>
    </form>

    <?php
    if ($_SERVER["REQUEST_METHOD"] == "POST") {
        $num1 = $_POST['num1'];
        $num2 = $_POST['num2'];
        $operation = $_POST['operation'];
        $result = 0;

        switch ($operation) {
            case "add":
                $result = $num1 + $num2;
                break;
            case "subtract":
                $result = $num1 - $num2;
                break;
            case "multiply":
                $result = $num1 * $num2;
                break;
            case "divide":
                if ($num2 != 0) {
                    $result = $num1 / $num2;
                } else {
                    echo "<p class='result'>Error: Division by zero is not allowed.</p>";
                    exit;
                }
                break;
            default:
                echo "<p class='result'>Invalid operation.</p>";
                exit;
        }

        echo "<p class='result'>Result: $result</p>";
    }
    ?>
</body>
</html>
