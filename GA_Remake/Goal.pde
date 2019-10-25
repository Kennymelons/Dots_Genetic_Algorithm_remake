class Goal  {
    PVector pos;
    Goal(int x, int y) {
        pos = new PVector(x, y);
    }

    void show() {
        fill(255, 0, 0);
        ellipse(pos.x, pos.y, 12, 12);
    }

}
