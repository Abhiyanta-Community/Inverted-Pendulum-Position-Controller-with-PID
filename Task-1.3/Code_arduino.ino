double kp = 100;
double ki = 10;
double kd = 30;

int in1 = 9; 
int in2 = 8;
int ConA = 10;
 
unsigned long currentTime, previousTime;
double elapsedTime;
double error,speed1;
double lastError;
double input_pot, output, setPoint,in;
double cumError, rateError,ERR;
int count=0;
int A=50;
double angle;
 
void setup(){
        Serial.begin(9600);
        setPoint = 2.38;                         
}    
 
void loop(){
        in = analogRead(A0);               
        input_pot = in * (5.0 / 1023.0);
        ERR = setPoint - input_pot;
        angle = (-62.5)*(input_pot)+136.875;
        Serial.print(angle);
        Serial.print(output);
        Serial.print(" ");
        Serial.println(A);
        output = computePID(input_pot);
        if(output>0)
        {
         
          TurnMotorA(output);                                                     
        }
        else if(output<0)
        {  
          
          TurnMotorA2(output);
        }
        else
         {
           TurnOFFA();
        }
        delay(10);
        count++;
        if(count==9)
        {
          count=0;
          A=-A;
        }
 
}
 
double computePID(double inp){     
        currentTime = millis();               
        elapsedTime = (double)(currentTime - previousTime);        
        error = setPoint - inp;                               
        cumError += error * elapsedTime;                
        rateError = (error - lastError)/elapsedTime;   
        double out = kp*error + ki*cumError + kd*rateError;                
        lastError = error;                               
        previousTime = currentTime;                       
        return out;                                         
}

void TurnMotorA(double out1) //We create a function which control the direction and speed
{ 
  digitalWrite(in1, LOW); 
  digitalWrite(in2, HIGH);
  double out2 = out1*(1023.0 / 255.0);
  speed1 = out2*0.2492668622; 
  analogWrite(ConA,speed1);
}

void TurnMotorA2(double out2) //We create a function which control the direction and speed
{ 
  digitalWrite(in1, HIGH); 
  digitalWrite(in2, LOW);
  double out3 = out2*(1023.0 / 255.0);
  speed1 = out3*0.2492668622; 
  analogWrite(ConA,speed1);
}

void TurnOFFA()
{
  digitalWrite(in1, LOW);
  digitalWrite(in2, LOW);
  analogWrite(ConA,0);
}
