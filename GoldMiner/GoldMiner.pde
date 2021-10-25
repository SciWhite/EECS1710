/* Jiaxiang Song 217334954 Project2
This program only use for study purpose
Description
Signal Player Mode: Press left ctrl to get ready( only use one button to interface）
Multiplayer Mode：Press space add 2 players 
                  Press down direction key add 3 players 
                  Press numpad 0 add 4 players
Player1 Hook Control：Left ctrl
Player2 Hook Control：Space
Player3 Hook Control：Down direction key
Player4 Hook Control：Bumpad 0
Time limit: 1 min
Image reference：
https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fimg.tapimg.com%2Fmarket%2Fimages%2F41a58301065c7cf10d3dcba7ee23c82f.png&refer=http%3A%2F%2Fimg.tapimg.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1637658418&t=f35531601797d3f80f76e4519d6ddf4f
https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fpic1.zhimg.com%2F50%2Fv2-70d7d3377bf1cf550d2298c3daa5eee4_hd.jpg&refer=http%3A%2F%2Fpic1.zhimg.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1637717633&t=d20ca4332dd2d6d8e599f47adb576272
https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fs11.sinaimg.cn%2Fbmiddle%2F4b93307an788c1ab8c7fa%26690&refer=http%3A%2F%2Fs11.sinaimg.cn&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1637719833&t=315b93ca50f61d3197e63f81062c3f3b
*/
int started = 0;
int startTime = 0;

String endMessage;

PImage backImg;

PFont font;
int fontSize = 48;
int enemiesKilled = 0;

ArrayList<Miner> miners;
ArrayList<Thing> things;

void setup()
{
  size(800, 600, P2D);
  
  font = createFont("Arial", fontSize);
  textFont(font, fontSize);

  backImg = loadImage("back.png");
  backImg.resize(800, 600);
  imageMode(CENTER);
  surface.setTitle("GoldMiner");
  
  miners = new ArrayList<Miner>();
  things = new ArrayList<Thing>();
}

float distance(PVector pos1, PVector pos2) {
  return sqrt((pos1.x - pos2.x) * (pos1.x - pos2.x) + (pos1.y - pos2.y) * (pos1.y - pos2.y));
}

void draw()
{
  background(127);
  image(backImg, 400, 300);
  
  for (int i = 0; i < things.size(); i++)
  {
    Thing thing = things.get(i);
    thing.run();
  }
  
  for (int i = 0; i < miners.size(); i++)
  {
    Miner miner = miners.get(i);
    miner.run();
  }
  
  if(started == 0)
  {
    fill(255);
    textSize(20);
    text("Press left ctrl for 1P  Space for 2P  Down for 3P  numpad 0 for 4P", 100, 300 - fontSize / 2);
  }
  else if(started == 1)
  {
    int t = (millis() - startTime) / 1000;
    
    // println(t);
    
    // println("Number of bullets: " + cannon.bullets.size());
    
    fill(255);
    textSize(50);
    text(t, 740, 45);
    
    if(t >= 60)
    {
      started = 2;
      int max_score = 0;
      endMessage = "";
      for (int i = 0; i < miners.size(); i++)
      {
        Miner miner = miners.get(i);
        if(miner.hook.mark > max_score)
        {
          max_score = miner.hook.mark;
        }
      }
      for (int i = 0; i < miners.size(); i++)
      {
        Miner miner = miners.get(i);
        if(miner.hook.mark == max_score)
        {
          if(endMessage != "")
          {
            endMessage = endMessage + ", ";
          }
          endMessage = endMessage + "Player" + (i + 1);
        }
      }
      endMessage = endMessage + " Win!";
    }
  }
  else
  {
    fill(255);
    textSize(50);
    text(endMessage, 200, 300 - fontSize / 2);
  }
}
