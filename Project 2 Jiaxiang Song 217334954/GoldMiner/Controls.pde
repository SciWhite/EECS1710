void keyPressed() {
  if(started == 1)
  {
    if (miners.size() >= 1 && key == CODED && keyCode == 17)
    {
      miners.get(0).hook.go();
    }
    if (miners.size() >= 2 && key == ' ')
    {
      miners.get(1).hook.go();
    }
    if (miners.size() >= 3 && key == CODED && keyCode == 40)
    {
      miners.get(2).hook.go();
    }
    if (miners.size() >= 4 && keyCode == 26)
    {
      miners.get(3).hook.go();
    }
  }
  if(started == 0)
  {
    if (keyCode == 17 || key == ' ' || keyCode == 40 || keyCode == 26)
    {
      if(keyCode == 17)
      {
        miners.add(new Miner(355, 75));
      }
      if(key == ' ')
      {
        miners.add(new Miner(200, 75));
        miners.add(new Miner(510, 75));
      }
      if( keyCode == 40)
      {
        miners.add(new Miner(100, 75));
        miners.add(new Miner(355, 75));
        miners.add(new Miner(610, 75));
      }
      if(keyCode == 26)
      {
        miners.add(new Miner(100, 75));
        miners.add(new Miner(270, 75));
        miners.add(new Miner(440, 75));
        miners.add(new Miner(610, 75));
      }
      started = 1;
      for(int i = 0; i < 16; i++)
      {
        float f = random(7);
        float x = 0;
        float y = 0;
        int repeat = 1;
        while(repeat == 1)
        {
          x = random(700) + 50;
          y = random(350) + 220;
          repeat = 0;
          for(int j = 0; j < i; j++)
          {
            if(distance(things.get(j).position, new PVector(x, y)) < 80)
            {
              repeat = 1;
              break;
            }
          }
        }
        if(f <= 1.6)
        {
          things.add(new SmallGold(x, y));
        }
        else if(f <= 2.5)
        {
          things.add(new BigGold(x, y));
        }
        else  if(f <= 3.5)
        {
          things.add(new Diamond(x, y));
        }
        else if(f <= 4.6)
        {
          things.add(new BigStone(x, y));
        }
        else
        {
          things.add(new SmallStone(x, y));
        }
      }
      startTime = millis();
    }
  }
}
