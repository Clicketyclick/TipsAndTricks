# Canon scanners

## How to fix error 5,202,54 from Canon scanners

http://www.lindipendente.eu/wp/en/2017/08/29/correggere-lerrore-520254-degli-scanner-canon/

Often, when you try to scan a document from Windows by using a Canon scanner, you run into the error 5,202,54.

In some cases it is enough to shut down the scanner and restart it to solve the problem; sometimes you need to restart the computer, often a significant waste of time.

There is a faster and more effective solution that I have found after several attempts, that works always.

1. First, open the “Task Manager” by pressing Ctrl-Shift-Esc.
1. Then click on the “Services” tab and look for the stisvc service, that is, “Windows Image Acquisition (WIA)”.
1. Look at the “PID” column and get the id of the related process.
1. Then go to the “Details” tab and look for the process with that id, which will be one out of the svchost.exe processes.
1. Click on that process by the right mouse button and select “End task”.
1. Then go back to the “Services” tab and restart the WIA service by right-clicking on stisvc and selecting “Restart”.

At this point, you can repeat the scan without experimenting the error message in question.
