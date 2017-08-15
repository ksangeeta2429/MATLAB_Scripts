// note that after you see the EHFL on the lcd of emote, then click enter in the command window and input the port number and the filename 
// (there are 15 seconds between the EHFL showing on the lcd, and the starting of real exfiltration, and this 15 seconds can be used to type in the command window)


using System;
using Microsoft.SPOT;
using System.IO.Ports;
using Microsoft.SPOT;
using Microsoft.SPOT.Hardware;
using System.Threading;
using System.Text;

namespace Exfiltrator
{
    public class Program
    {
        public static bool sdSuccessFlag = false;

        public static OutputPort sdRead = new OutputPort(Samraksh.SPOT.Hardware.EmoteDotNow.Pins.GPIO_J12_PIN3, false);
        public static OutputPort conversion = new OutputPort(Samraksh.SPOT.Hardware.EmoteDotNow.Pins.GPIO_J12_PIN4, false);
        public static OutputPort usartSend = new OutputPort(Samraksh.SPOT.Hardware.EmoteDotNow.Pins.GPIO_J12_PIN5, false);

        public static SerialPort serialPort;

        public static void mySdCallback(Samraksh.SPOT.Hardware.DeviceStatus status)
        {
            //Debug.Print("Recieved SD Callback\n");

            sdSuccessFlag = true;
        }

        public static void Main()
        {

            UInt16[] m_sendBuffer = new UInt16[256];
            byte[] m_serialBuffer = new byte[512];

            Samraksh.SPOT.Hardware.EmoteDotNow.SD.SDCallBackType sdResultCallBack = mySdCallback;

            //OutputPort error = new OutputPort(Samraksh.SPOT.Hardware.EmoteDotNow.Pins.GPIO_J12_PIN3, false);

            Samraksh.SPOT.Hardware.EmoteDotNow.SD mysd = new Samraksh.SPOT.Hardware.EmoteDotNow.SD(sdResultCallBack);

            if (!Samraksh.SPOT.Hardware.EmoteDotNow.SD.Initialize())
            {
                Debug.Print("SD Card Initialization failed \n");
                throw new Exception();
            }

            Debug.EnableGCMessages(false);

            Thread.Sleep(1000); //5000

            Samraksh.SPOT.Hardware.EmoteDotNow.EmoteLCD lcd;

            lcd = new Samraksh.SPOT.Hardware.EmoteDotNow.EmoteLCD();

            lcd.Initialize();

            lcd.Clear();

            lcd.Write(Samraksh.SPOT.Hardware.EmoteDotNow.LCD.CHAR_E, Samraksh.SPOT.Hardware.EmoteDotNow.LCD.CHAR_X, Samraksh.SPOT.Hardware.EmoteDotNow.LCD.CHAR_F, Samraksh.SPOT.Hardware.EmoteDotNow.LCD.CHAR_L);

            UInt16 counter = 0;

            UInt32 readBytes = 0;

            bool readDone = false;
            
            serialPort = new SerialPort("COM1");
            serialPort.BaudRate = 115200;
            serialPort.Parity = System.IO.Ports.Parity.None;
            serialPort.StopBits = StopBits.One;
            serialPort.DataBits = 8;
            serialPort.Handshake = Handshake.None;

           // serialPort.DataReceived += new SerialDataReceivedEventHandler(SerialPortHandler);

            //serialPort.Open();

            //Samraksh.SPOT.Hardware.EmoteDotNow.NOR.Initialize();

            lcd.Write(Samraksh.SPOT.Hardware.EmoteDotNow.LCD.CHAR_E, Samraksh.SPOT.Hardware.EmoteDotNow.LCD.CHAR_X, Samraksh.SPOT.Hardware.EmoteDotNow.LCD.CHAR_F, Samraksh.SPOT.Hardware.EmoteDotNow.LCD.CHAR_L);

            Thread.Sleep(3000); //15000

            string output = "";

            while (true)
            {
                //Debug.Print("Read : " + readBytes.ToString() + "\n");

                output = "Data";

                lcd.Clear();

                lcd.Write(Samraksh.SPOT.Hardware.EmoteDotNow.LCD.CHAR_E, Samraksh.SPOT.Hardware.EmoteDotNow.LCD.CHAR_X, Samraksh.SPOT.Hardware.EmoteDotNow.LCD.CHAR_F, Samraksh.SPOT.Hardware.EmoteDotNow.LCD.CHAR_L);

                //Thread.Sleep(15000);
                
                
                if (!Samraksh.SPOT.Hardware.EmoteDotNow.SD.Read(m_serialBuffer, 0, 512))
                {
                    //Debug.Print("SD Read failed\n");
                    //return false;
                    sdRead.Write(true);
                    sdRead.Write(false);
                }
                

                for (int i = 0; i < 64; i=i+4)
                {
                    if ((m_serialBuffer[i] == 0x0c) && (m_serialBuffer[i + 1] == 0x0c) && (m_serialBuffer[i + 2] == 0x0c) && (m_serialBuffer[i + 3] == 0x0c))
                        readDone = true;
                }

                if (readDone == true)
                    break;

                /*
                conversion.Write(true);
                for (UInt16 i = 0; i < m_serialBuffer.Length; i++)
                {
                    output += m_serialBuffer[i].ToString() + ",";
                }
                conversion.Write(false);
                */

                usartSend.Write(true);
                //Debug.Print(output.ToString());
                serialPort.Write(m_serialBuffer, 0, 512);
                usartSend.Write(false);

                //Debug.Print("\n");

                output = "";
                

                readBytes += 512;

                Thread.Sleep(25);
                
            }

            lcd.Clear();

            lcd.Write(Samraksh.SPOT.Hardware.EmoteDotNow.LCD.CHAR_D, Samraksh.SPOT.Hardware.EmoteDotNow.LCD.CHAR_D, Samraksh.SPOT.Hardware.EmoteDotNow.LCD.CHAR_D, Samraksh.SPOT.Hardware.EmoteDotNow.LCD.CHAR_D);
            //Debug.Print("Read is complete \n");
        }

        static void SerialPortHandler(object sender, SerialDataReceivedEventArgs e)
        {
            byte[] m_recvBuffer = new byte[100];
            SerialPort serialPort = (SerialPort)sender;

            int numBytes = serialPort.BytesToRead;
            serialPort.Read(m_recvBuffer, 0, numBytes);
            serialPort.Write(m_recvBuffer, 0, numBytes);
            serialPort.Flush();

        }

    }
}
