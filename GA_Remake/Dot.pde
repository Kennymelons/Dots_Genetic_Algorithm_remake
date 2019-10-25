class Dot {
    Brain brain;
    PVector pos;
    PVector vel;
    PVector acc;
    boolean dead = false;
    boolean reachedGoal = false;
    boolean isBest = false;
    float fitness;
    
    float distogoal;

    Dot() {
        brain = new Brain(500);
        pos = new PVector(50, 750);
        vel = new PVector(0, 0);
        acc = new PVector(0, 0);
    }

    void show() {
        if (!dead) {
            if (isBest) {
                fill(0, 255, 0);
                ellipse(pos.x, pos.y, 8, 8);
            
            }
            /*
            else {
                fill(225);
                ellipse(pos.x, pos.y, 8, 8);
            }
            */
        }
    }

    void move() {
        if (brain.steps < brain.directions.length) {
            acc = brain.directions[brain.steps];
            brain.steps++;
        }
        else {
            dead = true;
        }
        vel.add(acc);
        vel.limit(5);
        pos.add(vel);
    }

    void update() {
        if (!dead && !reachedGoal) {
            move();
            if (pos.x > 1598 || pos.x < 2 || pos.y > 798 || pos.y < 2) {
                dead = true;
            }
            else if (dist(pos.x, pos.y, goal.pos.x, goal.pos.y) < 5) {
                reachedGoal = true;
            }
        }
    }

    void calculateFitness() {
        if (reachedGoal) {
            fitness = 1.0/16.0 + 10000.0/(float)(brain.steps * brain.steps);
        }
        else {
            distogoal = dist(pos.x, pos.y, goal.pos.x, goal.pos.y);
            fitness = 1  / (distogoal * distogoal);
        }
    }

    Dot getBaby() {
        Dot baby = new Dot();
        baby.brain = brain.clone();
        return baby;
    }

   //checks for collision for each guy and each obstacle
    //sorry for shit code I couldnt find a better way to do this
    boolean collision() {
        for (int i = 0; i < obstacles.obs.length; i++) {
            if (pos.x < obstacles.obs[i].dimensions.x + obstacles.obs[i].x && pos.y < obstacles.obs[i].y + obstacles.obs[i].dimensions.y && pos.x > obstacles.obs[i].x && pos.y > obstacles.obs[i].y) {
                return true;
            }
        }
        return false;
    }

}
