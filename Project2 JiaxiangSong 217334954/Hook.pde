class Hook {
  
  int mark;
  PVector start_pos;
  PVector cur_pos;
  int status; //0:not launch 1: go 2: come back
  float rot;
  int direction;
  Thing hooked;

  Hook(float x, float y, float _rot) {
    start_pos = new PVector(x, y);
    cur_pos = new PVector(x, y);
    rot = _rot;
    status = 0;
    direction = 0;
    hooked = null;
    mark = 0;
  }
  
  void newPosition() {
    if(started == 0)
      return;
    if(status == 0)
    {
      if(direction == 0)
      {
        rot += 1;
        if(rot >= 75)
        {
          direction = 1;
        }
      }
      else if(direction == 1)
      {
        rot -= 1;
        if(rot <= -75)
        {
          direction = 0;
        }
      }
    }
    else if(status == 1)
    {
      cur_pos.x += 5 * sin(radians(rot));
      cur_pos.y += 5 * cos(radians(rot));
      for(int i = 0; i < things.size(); i++)
      {
        if(distance(cur_pos, things.get(i).position) < things.get(i).radius + 5)
        {
          hooked = things.get(i);
          status = 2;
          hooked.position.x = cur_pos.x + things.get(i).radius * sin(radians(rot));
          hooked.position.y = cur_pos.y + things.get(i).radius * cos(radians(rot));  
        }
      }
      if(cur_pos.x <= 5 || cur_pos.x >= 795 || cur_pos.y <= 5 || cur_pos.y >= 595)
      {
        status = 2;
      }
    }
    else if(status == 2)
    {
      if(distance(cur_pos, start_pos) < 6)
      {
        cur_pos.x = start_pos.x;
        cur_pos.y = start_pos.y;
        status = 0;
        if(hooked != null)
        {
          mark += hooked.mark;
          for(int i = 0; i < things.size(); i++)
          {
            if(hooked == things.get(i))
            {
              things.remove(i);
              break;
            }
          }
        }
        hooked = null;
      }
      else
      {
        if(hooked != null)
        {
          cur_pos.x -= (5 - (hooked.weight * 0.1)) * sin(radians(rot));
          cur_pos.y -= (5 - (hooked.weight * 0.1)) * cos(radians(rot));  
          hooked.position.x = cur_pos.x + hooked.radius * sin(radians(rot));
          hooked.position.y = cur_pos.y + hooked.radius * cos(radians(rot));  
        }
        else
        {
          cur_pos.x -= 5 * sin(radians(rot));
          cur_pos.y -= 5 * cos(radians(rot));  
        }
      }
    }
  }
  
  void update() {
    newPosition();
    
    // set bullets past their lifetime as not alive so they can be removedf (alive && millis() > timestamp + lifetime) alive = false;
  }
  
  void draw() {
    stroke(255);
    fill(100, 100, 100);
    beginShape();
    if(status == 2)
    {
      vertex(cur_pos.x, cur_pos.y);
      vertex(cur_pos.x + 18 * sin(radians(rot + 20)), cur_pos.y + 18 * cos(radians(rot + 20)));
      vertex(cur_pos.x + 27 * sin(radians(rot + 0)), cur_pos.y + 27 * cos(radians(rot + 0)));
      vertex(cur_pos.x + 1 * sin(radians(rot)), cur_pos.y + 1 * cos(radians(rot)));
      vertex(cur_pos.x + 27 * sin(radians(rot - 0)), cur_pos.y + 27 * cos(radians(rot - 0)));
      vertex(cur_pos.x + 18 * sin(radians(rot - 20)), cur_pos.y + 18 * cos(radians(rot - 20)));
    }
    else
    {
      vertex(cur_pos.x, cur_pos.y);
      vertex(cur_pos.x + 18 * sin(radians(rot + 50)), cur_pos.y + 18 * cos(radians(rot + 50)));
      vertex(cur_pos.x + 27 * sin(radians(rot + 30)), cur_pos.y + 27 * cos(radians(rot + 30)));
      vertex(cur_pos.x + 1 * sin(radians(rot)), cur_pos.y + 1 * cos(radians(rot)));
      vertex(cur_pos.x + 27 * sin(radians(rot - 30)), cur_pos.y + 27 * cos(radians(rot - 30)));
      vertex(cur_pos.x + 18 * sin(radians(rot - 50)), cur_pos.y + 18 * cos(radians(rot - 50)));
    }
    endShape();
    stroke(0);
    line(cur_pos.x, cur_pos.y, start_pos.x, start_pos.y);
  }
  
  void go()
  {
    if(status == 0)
    {
      status = 1;
    }
  }
  
  void run() {
    update();
    draw();  
  }
  

}
