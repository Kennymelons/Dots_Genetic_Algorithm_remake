//a single obstacle
class Ob {
    float x;
    float y;

    float s_xVel = random(-7, 7);
    float s_yVel = random(-7, 7);
    float yVel;
    float xVel;

    PVector dimensions;
    PVector changeSpeed = new PVector(0, 0);

    boolean dead = false;
    
    float startPosY = random(height - 100);
    float startPosX = random(800, 1500);

    Ob() {
        x = startPosX;
        y = startPosY;
       
        xVel = s_xVel;
        yVel = s_yVel;

        if (xVel < 2 && xVel > -2) {
            xVel = random(5, -5);
        } 

        dimensions = new PVector(50, 50);
    }   

    void show() {
        //fill(255,127,80);
        //rect(x, y, dimensions.x, dimensions.y);
        image(thwomp, x - 11, y - 13);
    }

    void move() {
        x += xVel;
        y += yVel;
    }
    
    void update() {
        if (x > 1550|| x < 0) {
            xVel *= -1;
        }
        else if(y > 750 || y < 0) {
            yVel *= -1;
        }
    }
 
}

//multiple obstacles
class Obstacles {
    Ob[] obs;
    
    Obstacles(int size) {
        obs = new Ob[size];
        for (int i = 0; i < size; i++) {
            obs[i] = new Ob();
        }
    }

    void show() {
        for (int i = 0; i < obs.length; i++) {
            obs[i].show();
        }
    }

    void move() {
        for (int i = 0; i < obs.length; i++) {
            obs[i].move();
        }
    }

    void update() {
        for (int i = 0; i < obs.length; i++) {
            obs[i].update();
        }
    }

    void reset() {
        for (int i = 0; i < obs.length; i++) {
            obs[i].x = obs[i].startPosX;
            obs[i].y = obs[i].startPosY;
            obs[i].xVel = obs[i].s_xVel;
            obs[i].yVel = obs[i].s_yVel;
        }
    }

}