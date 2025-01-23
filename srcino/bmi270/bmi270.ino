#include <Wire.h>
#include "SparkFun_BMI270_Arduino_Library.h"

// Create a new sensor object
BMI270 imu;
unsigned long millisOld, dt;

// I2C address selection
uint8_t i2cAddress = BMI2_I2C_PRIM_ADDR; // 0x68
//uint8_t i2cAddress = BMI2_I2C_SEC_ADDR; // 0x69

void setup()
{
    // Start serial
    Serial.begin(115200);
    // Serial.println("BMI270 Example 1 - Basic Readings I2C");

    // Initialize the I2C library
    Wire.begin();

    // Check if sensor is connected and initialize
    // Address is optional (defaults to 0x68)
    while(imu.beginI2C(i2cAddress) != BMI2_OK)
    {
        // Not connected, inform user
        Serial.println("Error: BMI270 not connected, check wiring and I2C address!");

        // Wait a bit to see if connection is established
        delay(1000);
    }

    millisOld = millis();
}

void loop()
{
    // Get measurements from the sensor. This must be called before accessing
    // the sensor data, otherwise it will never update
    imu.getSensorData();

    // output decimal places
    uint8_t prec = 6;

    // time duration in milliseconds
    dt = millis() - millisOld;
    millisOld = millisOld + dt;

    // Print time duration in sec
    // Serial.print(dt / 1000.0, prec);
    // Serial.print(",");

    // Print acceleration data
    Serial.print(imu.data.accelX, prec);
    Serial.print(",");
    Serial.print(imu.data.accelY, prec);
    Serial.print(",");
    Serial.print(imu.data.accelZ, prec);
    Serial.print(",");

    // Print rotation data
    Serial.print(imu.data.gyroX, prec);
    Serial.print(",");
    Serial.print(imu.data.gyroY, prec);
    Serial.print(",");
    Serial.println(imu.data.gyroZ, prec);

    // Print 50x per second
    delay(20);
}