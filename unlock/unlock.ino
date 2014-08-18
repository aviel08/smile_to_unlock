 #include <Servo.h> 
 
 char val; // Data received from the serial port
 int servoPin = 9; // Set the pin to digital I/O 13
 Servo servo;  
 int angle = 0;   // servo position in degrees 

 void setup() {
   servo.attach(servoPin); 
   pinMode(servoPin, OUTPUT);
   Serial.begin(9600); // Start serial communication at 9600 bps
 }

 void loop() {
   if (Serial.available()) 
   { // If data is available to read,
     val = Serial.read(); // read it and store it in val
   }
   if (val == '1') 
   { // If 1 was received
   
   servo.write(0);  // Turn Servo back to center position (90 degrees)
   delay(10);                 
  } 
   
   if (val == '0') 

                        
   servo.write(180); // Turn Servo Right to 135 degrees
   delay(10);                 
  }  
   



