# DAY3_WorkShop
## 实验一：程序PWM控制LED亮度[呼吸灯]
实验电路：

![arduino-day3-3-The-experimental-circuit](https://github.com/Tangchen329/ArduinoCourse/blob/master/chapter3/image/arduino-day3-3-The-experimental-circuit.png)

因为是PWM试验，所以LED的数字接口一定要选用带#号标识的数字口，只有带#号的数字输出口才具有硬件PWM输出功能。
实际电路：

![arduino-day3-4-The-experimental-circuit](https://github.com/Tangchen329/ArduinoCourse/blob/master/chapter3/image/arduino-day3-4-The-experimental-circuit.png)
- 程序代码：
- 作用:通过循环语句控制PWM来达到呼吸灯效果

```
*/
 
void setup ()
{
  pinMode(11,OUTPUT);
}
 
void loop()
{
  for (int a=0; a<=255;a++)                //循环语句，控制PWM亮度的增加
  {
	analogWrite(11,a);
	delay(8);                             //当前亮度级别维持的时间,单位毫秒            
  }
	for (int a=255; a>=0;a--)             //循环语句，控制PWM亮度减小
  {
	analogWrite(11,a);
	delay(8);                             //当前亮度的维持的时间,单位毫秒  
  }
  delay(800);                             //完成一个循环后等待的时间,单位毫秒
}

```


- 拓展：用程序做出多个呼吸灯
- 课后练习：同时使用2组LED，1组为三色交替呼吸灯，1组为三色交替亮度递增，凸显两者的区别对比

- 扩展实验：三个电位器控制RGB灯

实验电路：

![arduino-day3-5-The-experimental-circuitpng](https://github.com/Tangchen329/ArduinoCourse/blob/master/chapter3/image/arduino-day3-5-The-experimental-circuitpng.png)

程序代码：

```
//变量声明
int ledPin1 = 9;
int ledPin2 = 10;
int ledPin3 = 11;//RGB灯的三个接脚分别接到9、10、11pwm处
int switchPin1 = 0;
int switchPin2 = 1;
int switchPin3 = 2;//三个电位计分别接入analog0,、1、2处
int value1;
int value2;
int value3;//定义三个变量用于控制灯泡变化

void setup() {
pinMode(ledPin1, OUTPUT);
pinMode(ledPin2, OUTPUT);
pinMode(ledPin3, OUTPUT);
pinMode(switchPin1, INPUT);
pinMode(switchPin2, INPUT);
pinMode(switchPin3, INPUT);
Serial.begin(9600);
}

void loop() {
value1 = analogRead(0);//读取模拟接口0的值
int v1 = map(value1,0,1023,0,255);//map缩放函数将模拟值0—1023缩放为0—255
value2 = analogRead(1);//读取模拟接口1的值
int v2 = map(value2,0,1023,0,255);
value3 = analogRead(2);//读取模拟接口2的值
int v3 = map(value3,0,1023,0,255);
Serial.println(v1,DEC);
analogWrite(ledPin1, v1);
analogWrite(ledPin2, v2);
analogWrite(ledPin3, v3);//将模拟值赋给LED
}

```


## 实验二：用蜂鸣器模拟警报器
今天我们做的是用蜂鸣器来做一个防控警报类似的报警器。
- 实验电路：

![arduino-day4-1-The-experimental-circuit](https://github.com/Tangchen329/ArduinoCourse/blob/master/chapter4/image/arduino-day4-1-The-experimental-circuit.png)

- 实际电路：

![arduino-day4-2-The-experimental-circuit](https://github.com/Tangchen329/ArduinoCourse/blob/master/chapter4/image/arduino-day4-2-The-experimental-circuit.png)

- 元器件：导线、蜂鸣器

程序代码：

```
作用:使用tone（）函数产生声音，模拟防控警报的响声
 
*/
void setup()
{
}
 
void loop()
{
for(int i=200;i<=800;i++)                    //用循环的方式将频率从200HZ 增加到800HZ
{
  pinMode(4,OUTPUT);
  tone(4,i);                            //在四号端口输出频率
 delay(5);                              //该频率维持5毫秒   
}
delay(4000);                            //最高频率下维持4秒钟
for(int i=800;i>=200;i--)
{
  pinMode(4,OUTPUT);
  tone(4,i);
 delay(10);
}
}

```

- 拓展：做出各种报警效果






- 扩展实验：Arduino超声波测距模块控制蜂鸣器

## 实验电路：

![arduino-day4-6-The-experimental-circuit](https://github.com/Tangchen329/ArduinoCourse/blob/master/chapter4/image/arduino-day4-6-The-experimental-circuit.png)

- 程序代码：

```
const int TrigPin = 2; 
const int EchoPin = 3; 
float cm; 
void setup() 
{ 
Serial.begin(9600); 
pinMode(TrigPin, OUTPUT); 
pinMode(EchoPin, INPUT); 
pinMode(8,OUTPUT);
} 
void loop() 
{ 
digitalWrite(8, LOW);

digitalWrite(TrigPin, LOW); //低高低电平发一个短时间脉冲去TrigPin 
delayMicroseconds(2); 
digitalWrite(TrigPin, HIGH); 
delayMicroseconds(10); 
digitalWrite(TrigPin, LOW); 

cm = pulseIn(EchoPin, HIGH) / 58.8; //将回波时间换算成cm 
cm = (int(cm * 100.0)) / 100.0; //保留两位小数 
if (cm>=2 && cm<=10)
digitalWrite(8, HIGH);
} 
```

- 目前暂无超声传感器
