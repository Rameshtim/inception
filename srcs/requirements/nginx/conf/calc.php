<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Basic Calculator</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            background-color: #f0f0f0;
            margin: 0;
        }
        .calculator {
            background-color: #fff;
            padding: 20px 30px;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            text-align: center;
        }
        .calculator h1 {
            margin-bottom: 20px;
            color: #333;
        }
        .calculator input[type="number"] {
            width: calc(50% - 20px);
            padding: 10px;
            margin: 10px 5px;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 16px;
        }
        .calculator select {
            padding: 10px;
            margin: 10px 5px;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 16px;
        }
        .calculator button {
            padding: 10px 20px;
            margin: 20px 5px;
            border: none;
            border-radius: 5px;
            background-color: #007BFF;
            color: #fff;
            font-size: 16px;
            cursor: pointer;
            transition: background-color 0.3s;
        }
        .calculator button:hover {
            background-color: #0056b3;
        }
        .result {
            margin-top: 20px;
            font-size: 24px;
            font-weight: bold;
            color: #333;
        }
    </style>
</head>
<body>
    <div class="calculator">
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
                        echo "<p class='result' style='color: red;'>Error: Division by zero is not allowed.</p>";
                        exit;
                    }
                    break;
                default:
                    echo "<p class='result' style='color: red;'>Invalid operation.</p>";
                    exit;
            }

            echo "<p class='result'>Result: $result</p>";
        }
        ?>
    </div>
</body>
</html>
