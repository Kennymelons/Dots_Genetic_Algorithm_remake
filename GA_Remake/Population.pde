class Population {
    Dot[] dots;
    float maxSteps = 1000;
    int bestDot = 0;
    float fitnessSum;
    int gen = 1;
    
    Population(int size) {
        dots = new Dot[size];
        for (int i = 0; i < dots.length; i++) {
            dots[i] = new Dot();    
        }
    }

    void show() {
        for (int i = 1; i < dots.length; i++) {
            dots[i].show();
        }
        dots[0].show();
    }

    void update() {
        for (int i = 0; i < dots.length; i++) {
            if (dots[i].brain.steps > maxSteps) {
                dots[i].dead = true;
            }
            else if(dots[i].collision()) {
                dots[i].dead = true;
            }
            else {
                dots[i].update();
            }
        }
    }

    boolean allDotsDead() {
        for (int i = 0; i < dots.length; i++) {
            if (!dots[i].dead && !dots[i].reachedGoal) {
                return false;
            }
        }
        return true;
    }

    void mutateBabies() {
        for (int i = 1; i <dots.length; i++) {
            dots[i].brain.mutate();
        }
    }

    void setBestDot() {
        float best = 0;
        int bestIndex = 0;
        for (int i = 0; i < dots.length; i++) {
            if (dots[i].fitness > best) {
                best = dots[i].fitness;
                bestIndex = i;
            }
        }
        bestDot = bestIndex;

        if (dots[bestDot].reachedGoal) {
            maxSteps = dots[bestDot].brain.steps;
            println("Steps:", maxSteps);
        }
        else {
            println("Gen:", gen);
            println("Fitness:", dots[bestDot].fitness);
            println("Distance to goal:", dots[bestDot].distogoal);
        }
    }

    void calculateFitness() {
        for (int i = 0; i < dots.length; i++) {
            dots[i].calculateFitness();
        }
    }

    void calculateFitnessSum() {
        fitnessSum = 0;
        for (int i = 0; i < dots.length; i++) {
            fitnessSum += dots[i].fitness;
        }
    }

    Dot selectParent() {
        float runningSum = 0;
        float rand = random(fitnessSum);
        for (int i = 0; i < dots.length; i++) {
            runningSum += dots[i].fitness;
            if (runningSum > rand) {
                return dots[i];
            }
        }
        return null;
    }

    void naturalSelection() {
        Dot[] newDots = new Dot[dots.length];
        calculateFitnessSum();
        setBestDot();
        newDots[0] = dots[bestDot].getBaby();
        newDots[0].isBest = true;
        for (int i = 1; i < newDots.length; i++) {
            Dot parent = selectParent();
            newDots[i] = parent.getBaby();
        }
        dots = newDots.clone();
        gen++;
    }

    boolean collision() {
        for (int i = 0; i < dots.length; i++) {
            if (dots[i].collision()) {
                return true;
            }
        }
        return false;
    }

    boolean standard() {
        if (maxSteps < 500) {
          return true;
        }
        return false;
    }

}
