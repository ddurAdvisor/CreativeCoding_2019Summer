## DAY5_WorkShop

### 项目分享-游戏设计：奔跑的火柴人

奔跑的火柴人是一款与声音互动的跑酷游戏。应用简单易上手的Processing可视化编程，结合可搭配各种硬件的Arduino开发板，玩家可以通过声音传感器控制游戏中的火柴人向上跳起跨越一个个障碍。火柴人碰触到障碍则游戏结束。

- Arduino程序设计检测声音，检测到了声音则向Processing发送信号。

- Processing程序设计游戏场景分为火柴人、背景和障碍3个部分，这3个部分同时启动。在火柴人奔跑的过程中，背景和障碍都会移动。火柴人跳起跃过障碍物时，游戏继续进行；当火柴人撞到障碍的时候，游戏结束。把游戏分成3个独立的类进行设计。1）火柴人类，动作包括跑、跳、停。在跑的时候需要一个跑动的动画，绘画起来非常烦琐。可以通过贴图的方式来完成，用一个图片数组载入一些图片。然后图片不断地切换，达到火柴人动起来的效果。2）背景类，背景要一直随着火柴人的奔跑而不断地变换。但不可能通过一张无限长的图片来达到背景不断变换的效果，可以找一张头尾相接的图片一直循环来达到相似的效果。3）障碍类，与背景类需要处理的问题相似，不断地循环生成障碍。

按照接线表连接传感器的S端与Arduino对应引脚


声音传感器的作用相当于一个麦克风，可用于接收声波，能感应到声音的振幅。声音传感器模块共有4个引脚，从上到下分别是模拟输出口A0、地线GND、电源VCC和数字输出口D0。其中模拟输出口A0可实时输出麦克风的电压信号，数字输出口D0在声音强度到达某个阈值（即灵敏度，可通过调节电位器来改变）时，才输出高低电平信号。


1. 火柴人上升、下降
火柴人上升、下降火柴人的上升和下降要有重力感，可以通过设置速度和加速度来解决。按一下UP键，火柴人会在几个循环内自动上升到一个高度再下降回来。可以通过设置一个理想高度的变量，再通过几次连续的判断来实现。

```
if (y != goalheight)
{    if (y < goalheight)
{        y+=speed;        speed-=a;    }
 else if (y > goalheight)
{        y-=speed;        speed-=a;    }} 
else
{    goalheight = 340;    speed =24;    if (y ==340) lock = false;
}

```

预设火柴人游戏中的地面高度是340像素，通过等差数列算好上升一定距离（本实例设置的是上升120像素）时的速度和加速度。火柴人在某一时刻的实时高度没有达到理想高度，就会不断向理想高度靠近。当火柴人达到理想高度后，再把原理想高度变量中的值改成地面高度的值，即340像素。

2. 障碍生成算法
每隔128毫秒检测一次是否生成障碍，如果和上一个障碍的距离超过350像素，即可生成障碍。生成的障碍越过屏幕左端后，标记为越界。可以设置20个障碍循环使用，某个障碍一旦越界，它会再次从右边出现，作为新的障碍循环使用。

3. 动态背景算法想让背景不停地移动，可以找一张头尾无缝相接的图片，让图片循环反复出现，从而达到背景不停变换的效果。利用求余操作，设置有两张图片的图片数组。前面的图一旦越界立即补到后面去，这样游戏背景得以一直变换。界面设计界面大小为900像素×600像素，奔跑的火柴人在不停变换的群山环绕的背景下奔跑，一个个的绿色小蘑菇障碍从右面过来。左上角是提示符。当玩家使用键盘时，提示符会显示serialoff，表示串口关；当使用串口时，提示符会显示serial on，表示此时可以通过声音传感器来控制火柴人的跳跃。

4　游戏使用说明
默认使用键盘的方向键的UP键来控制火柴人的跳跃。若需要用声音传感器来控制火柴人跳跃，可以按o键进行蓝牙连接，连接成功后，就可以用声音来控制火柴人了。
火柴人碰触到障碍物则游戏结束，此时需重启程序来重新开始。界
面左上角有serial off和serial on的文字显示，用于提示是否与Arduino板的声音传感器相连接。

- 程序代码-Arduino部分：

```

        int sensorpin=A5;        //定义使用A5端口来与传感器交互数据
        int sensorvalue;
        void setup()
        {
            Serial.begin(9600);                //打开串口，比特率为9600
        }
        void loop()
        {
            sensorvalue=analogRead(sensorpin); //读数据
            if (sensorvalue>27) {
        Serial.print(sensorvalue,DEC); //如果数据大于27，则发送数据到Processing
                delay(100);
            }
        }

```

- 程序代码-Processing部分：

```

        import processing.serial.*;           //引入Processing的端口处理库函数
        Serial myPort;                        //定义端口
        Littleman pan;                        //火柴人
        Blob blob;                            //障碍
        Back background;                      //背景
        boolean heightflag = false;
        String over;
        boolean serialFlag;

        void setup()
        {
            size(900, 600);
            smooth();
            pan = new Littleman(30, 340);
            blob = new Blob(50, 460);
            background=new Back(0, 0);
            over = new String("game is over”);
        }


        void draw()22        {

            background(255);
            blob.change();                    //障碍展示
            background.display();             //背景展示
            pan.display();                    //火柴人变化

            blob.display();                   //障碍展示
            distance();                       //测量与障碍间的距离
            pan.run();                        //火柴人奔跑
            blob.run();                       //障碍移动
            background.run();                 //背景移动
            serialDisplay();
        }


        void keyPressed()
        {
            if (keyCode == UP && !serialFlag) {

                if (!pan.lock) {
                    pan.setjump(220);
                    pan.lock=true;
                }
            }
            if (key == 'o') {
                try {
                    openSerial();                        //打开端口
                } catch (Exception e) {
                    println("open failed”);
                }
            }
        }


        void openSerial()
        {
            myPort = new Serial(this, Serial.list()[0], 9600);
            serialFlag = true;
        }
        void serialDisplay()
        {
            if (serialFlag) {
                if (myPort.available() > 0) {
                    pan.setjump(220);
                    pan.lock=true;
                }
            }
            if (serialFlag) {
                textSize(20);                        //设置文字大小
                text("serial: open", 200, 50);       //打印串口状态
                fill(255, 102, 153);                 //设置字体颜色
            } else {
                textSize(20);
                text("serial: off", 200, 50);
                fill(255, 0, 0);
            }
        }
        void keyReleased()
        {
            pan.state = 0;
        }
        void distance()
        {
            for (int i = 0; i < 20; i++) {
                if ((pow(230-blob.obstacle[i], 2)+pow(pan.y-40+160-
                    460, 2)
                    ) < pow(25, 2)) {
                    noLoop();
                    textSize(60);
                    text("game is over      T_T", 200, 300);
                   fill(255, 102, 153);
                }
            }
```

火柴人类LittleMan实现火柴人的动作，并记录状态等数据。
```

        class Littleman
         {
            int state;                //状态
            final int x;              //x坐标
            int y;                    //y坐标
            int goalheight;           //理想高度
            int speed;                //速度

            int a;                    //加速度
            boolean lock;             //跳起锁定
            PImage[] photo;
            Littleman(int x, int y) {
                photo = new PImage[17];
                for (int i = 4; i< 21; i++) {
                    String a = “IMG000"+i+".png";
                    println(a);
                    photo[i-4] = loadImage(a);
                }
                state=0;
                this.x = x;
                this.y = y;
                goalheight = 300;
                speed = 12;
                a = 1;
            }
            void run() {
                state =++state%16+1;
            }
            void stop() {
                state = 0;
            }
            void setjump(int x) {
                goalheight=x;
            }
            void display() {
                if (y != goalheight) {
                    if (y < goalheight) {

                    y+=speed;                //如果小于理想高度，则速度减小，增加高度
                        speed-=a;
                    } else if (y > goalheight) {
                        y-=speed;            //如果大于理想高度，速度减小，减小高度
                        speed-=a;
                    }
                } else {
                    goalheight = 340;
                    speed =24;
                    if (y ==340) lock = false;
                }
                image(photo[state], x, y);
            }
```




### 2018年课程作业分享

- [不倒翁型智能交互花盆 顾冰姿 ](https://github.com/pudding2769/CreativeCoding_2018Summer/tree/master/Roly-Poly%20Smart%20Interactive%20Pot%20%20by%20%20PingTzu%20Ku)

- [BE QUICKER小游戏 史书圆 ](https://github.com/ssy764225231/final-program.git)

- [听觉反馈超声波雷达在助盲方面可行性探究 周天宇 ](https://github.com/zhoutianyu14/Finalproject2018summer-Creativecoding)

### 2017年课程作业分享

- [以海洋为主题的引导式放松程序 朱歆宇 ](https://github.com/joyce1998215/joyce98215/tree/master/Final%20project)


- [FITree 孙音如](https://github.com/rachlight97/rachlight97/tree/master/Final%20Program)


- [“小宇宙”计数器（计数+选座+预留） 陈子楠](https://github.com/c1cccc/Final-Project)


- [摸摸哒时钟-夜间触控时钟 杨敏桦](https://github.com/WEIYI7/arduino-homework.git)
