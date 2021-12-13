class Piece{

private PVector vector;
private String name;
private float divX;
private float divY;

    public PVector getVector() {
        return vector;
    }

    public void setVector(PVector vector) {
        this.vector = vector;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Piece(String name,PVector vector,float divY) {
        this.name = name;
        this.vector = vector;
        this.divX = random(0.5,1);
        this.divY = divY;
         
    }

    public float getDivX() {
        return divX;
    }

    public void setDivX(float divX) {
        this.divX = divX;
    }

    public float getDivY() {
        return divY;
    }

    public void setDivY(float divY) {
        this.divY = divY;
    }



}
