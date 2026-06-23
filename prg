<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Visual Window Refresher</title>
    <style>
        body { font-family: 'Segoe UI', sans-serif; margin: 15px; background-color: #0e1117; color: #c9d1d9; }
        .container { width: 100%; max-width: 360px; background: #161b22; padding: 15px; border-radius: 8px; border: 1px solid #30363d; box-sizing: border-box; }
        h2 { margin-top: 0; color: #ffffff; text-align: center; font-size: 1.4rem; }
        label { display: block; margin-bottom: 6px; font-weight: bold; color: #58a6ff; font-size: 13px; }
        input, button { width: 100%; padding: 10px; margin-bottom: 15px; border-radius: 6px; border: 1px solid #30363d; box-sizing: border-box; font-size: 13px; }
        input { background: #0d1117; color: #c9d1d9; }
        button { background: #238636; color: white; border: none; font-weight: bold; cursor: pointer; }
        button.stop { background: #da3637; }
        #log { background: #010409; color: #ffffff; padding: 10px; border-radius: 6px; border: 1px solid #30363d; height: 160px; overflow-y: auto; font-family: monospace; font-size: 11px; }
    </style>
</head>
<body>

<div class="container">
    <h2>Teleperformance</h2>
    
    <label for="urlInput">Target URL:</label>
    <input type="url" id="urlInput" value="" placeholder="tpbackoffice">

    <label for="timeInput">Refresh (Seconds):</label>
    <input type="number" id="timeInput" value="20" min="5">

    <button id="actionBtn" onclick="toggleWindowEngine()">Start</button>

    <label>Live Tracker Log:</label>
    <div id="log">Waiting to launch window...</div>
</div>

<script>
    let loopTracker = null;
    let targetWindow = null;

    function addLog(text) {
        const consoleLog = document.getElementById('log');
        const timestamp = new Date().toLocaleTimeString();
        consoleLog.innerHTML += `<div>[${timestamp}] ${text}</div>`;
        consoleLog.scrollTop = consoleLog.scrollHeight;
    }

    function refreshTargetWindow() {
        const targetUrl = document.getElementById('urlInput').value;

        if (!targetWindow || targetWindow.closed) {
            addLog("Window was closed. retrying...");
            targetWindow = window.open(targetUrl, "RefresherTargetWindow");
        } else {
            addLog(`Reloading `);
            targetWindow.location.href = targetUrl;
        }
    }

    function toggleWindowEngine() {
        const btn = document.getElementById('actionBtn');
        const seconds = parseInt(document.getElementById('timeInput').value);
        const targetUrl = document.getElementById('urlInput').value;

        if (loopTracker) {
            clearInterval(loopTracker);
            loopTracker = null;
            btn.innerText = "Start";
            btn.className = "";
            addLog("Refresher stopped.");
        } else {
            addLog(`Launching window ${seconds}s.`);
            
            targetWindow = window.open(targetUrl, "RefresherTargetWindow");
            
            if (!targetWindow) {
                alert("❌ Pop-up Blocked! Please click the pop-up blocked icon on your browser address bar and select 'Always allow pop-ups from ://google.com'.");
                addLog("❌ Error: Script origin blocked window spawn.");
                return;
            }

            loopTracker = setInterval(refreshTargetWindow, seconds * 1000);
            btn.innerText = "Stop";
            btn.className = "stop";
        }
    }
</script>

</body>
</html>
