<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Advanced Calculator</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
            background-color: #f0f0f0;
        }
        .calculator {
            background-color: #fff;
            border-radius: 10px;
            box-shadow: 0 0 20px rgba(0,0,0,0.1);
            padding: 20px;
            width: 300px;
        }
        .display {
            background-color: #222;
            color: #fff;
            font-size: 2em;
            border-radius: 5px;
            padding: 10px;
            text-align: right;
            margin-bottom: 20px;
        }
        .buttons {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 10px;
        }
        .buttons button {
            font-size: 1.5em;
            padding: 20px;
            border: none;
            border-radius: 5px;
            background-color: #e0e0e0;
            cursor: pointer;
            transition: background-color 0.2s;
        }
        .buttons button.operation {
            background-color: #f9a825;
            color: #fff;
        }
        .buttons button.equal {
            background-color: #4caf50;
            color: #fff;
            grid-column: span 2;
        }
        .buttons button:hover {
            background-color: #d4d4d4;
        }
        .buttons button.operation:hover {
            background-color: #f57f17;
        }
        .buttons button.equal:hover {
            background-color: #388e3c;
        }
        .footer {
            margin-top: 40px;
            font-size: 16px;
            color: #555;
        }
        .footer a {
            text-decoration: none;
            color: #007bff;
        }
    </style>
</head>
<body>
    <div class="calculator">
        <div class="display" id="display">0</div>
        <div class="buttons">
            <button onclick="appendNumber('7')">7</button>
            <button onclick="appendNumber('8')">8</button>
            <button onclick="appendNumber('9')">9</button>
            <button class="operation" onclick="setOperation('divide')">/</button>
            <button onclick="appendNumber('4')">4</button>
            <button onclick="appendNumber('5')">5</button>
            <button onclick="appendNumber('6')">6</button>
            <button class="operation" onclick="setOperation('multiply')">*</button>
            <button onclick="appendNumber('1')">1</button>
            <button onclick="appendNumber('2')">2</button>
            <button onclick="appendNumber('3')">3</button>
            <button class="operation" onclick="setOperation('subtract')">-</button>
            <button onclick="appendNumber('0')">0</button>
            <button onclick="clearDisplay()">C</button>
            <button class="equal" onclick="calculate()">=</button>
            <button class="operation" onclick="setOperation('add')">+</button>
        </div>
    </div>
    
    <div class="footer">
        <h1>Designed by [Your Name]</h1>
        <a href="/">Go Back to Homepage</a>
    </div>
    <script>
        let display = document.getElementById('display');
        let firstNumber = '';
        let secondNumber = '';
        let operation = null;
        let shouldResetDisplay = false;

        function appendNumber(number) {
            if (display.textContent === '0' || shouldResetDisplay) {
                display.textContent = number;
                shouldResetDisplay = false;
            } else {
                display.textContent += number;
            }
        }

        function setOperation(op) {
            if (operation !== null) calculate();
            firstNumber = display.textContent;
            operation = op;
            shouldResetDisplay = true;
        }

        function calculate() {
            if (operation === null || shouldResetDisplay) return;
            secondNumber = display.textContent;
            let result = 0;
            switch (operation) {
                case 'add':
                    result = parseFloat(firstNumber) + parseFloat(secondNumber);
                    break;
                case 'subtract':
                    result = parseFloat(firstNumber) - parseFloat(secondNumber);
                    break;
                case 'multiply':
                    result = parseFloat(firstNumber) * parseFloat(secondNumber);
                    break;
                case 'divide':
                    if (parseFloat(secondNumber) !== 0) {
                        result = parseFloat(firstNumber) / parseFloat(secondNumber);
                    } else {
                        alert("Error: Division by zero is not allowed.");
                        clearDisplay();
                        return;
                    }
                    break;
            }
            display.textContent = result;
            operation = null;
        }

        function clearDisplay() {
            display.textContent = '0';
            firstNumber = '';
            secondNumber = '';
            operation = null;
        }
    </script>
</body>
</html>
