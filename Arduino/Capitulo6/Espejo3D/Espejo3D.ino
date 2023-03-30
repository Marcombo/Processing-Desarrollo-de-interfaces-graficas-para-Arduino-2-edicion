#include "MPU6050.h"
#include "Wire.h"
 
int mpuAddress = 0x68;  // Dirección I2C del MPU-6050
MPU6050 mpu(mpuAddress);
 
int ax, ay, az; //valores del acelerómetro en cada eje
int gx, gy, gz; //valores del giroscopio en cada eje
 
float tiempo_actual, tiempo_previo, tiempo_transcurrido;
float acelerometro_angulo_x, acelerometro_angulo_y;
float angulo_x, angulo_y, angulo_z;
float angulo_x_previo, angulo_y_previo, angulo_z_previo;
 
void setup()
{
   Serial.begin(115200);
   Wire.begin();
   mpu.initialize();
}
 
void loop() 
{
   mpu.getAcceleration(&ax, &ay, &az); // Se lee los datos del acelerómetro en cada eje
   mpu.getRotation(&gx, &gy, &gz); // Se lee los datos del giroscopio en cada eje
   filtroKalman(); // Se aplica el filtro kalman a los datos leídos
   Serial.println(String(angulo_x) + "," + String(angulo_y) + "," + String(angulo_z)); //enviamos los ángulos a Processing
   delay(20);
}

void filtroKalman()
{
   tiempo_actual = millis();
   tiempo_transcurrido = (tiempo_actual - tiempo_previo) / 1000.0;
   tiempo_previo = tiempo_actual;
 
   //Se calculan los ángulos con acelerometro
   acelerometro_angulo_x = atan(ay / sqrt(pow(ax, 2) + pow(az, 2)))*(180.0 / 3.14);
   acelerometro_angulo_y = atan(-ax / sqrt(pow(ay, 2) + pow(az, 2)))*(180.0 / 3.14);
 
   //Se calculan los ángulos de rotación con giroscopio para los ejes X e Y utilizando el fitro Kalman
   angulo_x = 0.98*(angulo_x_previo + (gx / 131)*tiempo_transcurrido) + 0.02*acelerometro_angulo_x;
   angulo_y = 0.98*(angulo_y_previo + (gy / 131)*tiempo_transcurrido) + 0.02*acelerometro_angulo_y;
   //Para el eje Z use únicamente el giroscopio sin ningún tipo de filtro
   angulo_z = (gz / 131)*tiempo_transcurrido + angulo_z_previo;
 
   angulo_x_previo = angulo_x;
   angulo_y_previo = angulo_y;
   angulo_z_previo = angulo_z;
}
