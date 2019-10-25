Population test;
Goal goal;
Obstacles obstacles;
PImage thwomp;

boolean addObs = false;

void setup() {
    size(1600, 800);
    test = new Population(1000);
    goal = new Goal(1500, 100);
    obstacles = new Obstacles(60);
    thwomp= loadImage("thwomp.png");
    thwomp.resize(75, 75);
    frameRate(1000);
}

void draw() {
    background(50);
    fill(255);
    textSize(50);
    text("Gen:", 50, 50);

    fill(255);
    textSize(50);
    text(test.gen, 160, 50);
    
    fill(255);
    textSize(50);
    text("Steps:", 50, 100);

    fill(255);
    textSize(50);
    text(test.maxSteps, 180, 100);

    goal.show();
    
    if (test.allDotsDead()) {
        test.calculateFitness();
        test.naturalSelection();
        test.mutateBabies();
        obstacles.reset();
    } 
    else {
        test.update();
        //if (test.standard()) {
            test.show();
            obstacles.show();
        //}
        obstacles.move();
        obstacles.update();
    }

    if (addObs) {
        obstacles = new Obstacles(20);
    }

}
